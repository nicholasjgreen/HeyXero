Promise = require("bluebird");
XeroConnection = require('./xero-connection');
_ = require('lodash');

GetBillsComingUp = '/invoices?where=Type%3d%22ACCPAY%22+%26%26+Status%3d%3d%22AUTHORISED+%22&order=DueDate+DESC&page=1'

module.exports = {
	doRequest: () ->
		console.log('WhatBillsAreComingUp.doRequest()')
		promise = new Promise((resolve, reject) ->
			console.log("GET: #{GetBillsComingUp}")
			XeroConnection().call('GET', GetBillsComingUp, null, (err, json) ->
				console.log("Received: #{JSON.stringify(json)}")
				if(err)
					reject()
				else
					resolve(json.Response)
			)
		)
		return promise;

	createAnswer:  (response) ->
		#console.log("Parsing who owes me money response: #{JSON.stringify(response)}")
		if(!response || !response.Invoices || !response.Invoices.Invoice || !response.Invoices.Invoice.length)
			return [];

		results = [];
		_.forEach(_.take(response.Invoices.Invoice, 5), (invoice) ->
			results.push({
				invoiceNumber: invoice.InvoiceNumber
				name: invoice.Contact.Name
				dueDate: invoice.DueDate
				amountDue: invoice.AmountDue
			})
		)
		return results;

	formatAnswer: (answer) ->
		results = []
		if(!answer.length)
			results.push("No bills due soon");
		else
			_.forEach(answer, (invoice) ->
				line = invoice.dueDate;
				if(invoice.invoiceNumber)
					line += (' ' + invoice.invoiceNumber)
				line += ' ' + invoice.name + ': ' + Number(invoice.amountDue).toFixed(2)
			)
		return results;
  }