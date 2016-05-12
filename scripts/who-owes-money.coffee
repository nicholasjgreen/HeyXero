Promise = require("bluebird");
XeroConnection = require('./xero-connection');
_ = require('lodash');

GetContactsOwingMoney = '/contacts?where=(Balances+!%3d+null+%26%26+Balances.AccountsReceivable+!%3d+null+%26%26+Balances.AccountsReceivable.Outstanding+%3e+0)&order=(Balances.AccountsReceivable.Outstanding)+DESC&page=1'

module.exports = {
	doRequest: () ->
		console.log('doRequest()')
		promise = new Promise((resolve, reject) ->
			console.log('sending...')
			XeroConnection().call( 'GET', GetContactsOwingMoney, null, (err, json) ->
				if(err)
					console.log('Rejecting -- the query to xero failed')
					reject()
				else
					console.log('Got our data...')
					resolve(json.Response)
			)
		)
		return promise;

	createAnswer:  (response) ->
		if(!response || !response.Contacts || !response.Contacts.Contact.length)
			console.log(response)
			console.log(response.Contacts.Contact)
			console.log('No contacts in response')
			return [];

		results = [];
		_.forEach(_.take(response.Contacts.Contact, 5), (contact) ->
				results.push({
					name: contact.Name
					outstanding: contact.Balances.AccountsReceivable.Outstanding
					overdue: contact.Balances.AccountsReceivable.Overdue
				})
			)	
		return results;

	formatAnswer: (answer) ->
		if(!answer.length)
			return "Nobody does";
		return 'you do, ' + answer[0].name;
}		