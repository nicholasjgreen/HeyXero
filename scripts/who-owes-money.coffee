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
					reject()
				else
          			resolve(json.Response)
			)
		)
		return promise;

	createAnswer:  (response) ->
    #console.log("Parsing who owes me money response: #{JSON.stringify(response)}")
    if(!response || !response.Contacts || !response.Contacts.Contact || !response.Contacts.Contact.length)
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
  	results = []
  	if(!answer.length)
     	results.push("Nobody does");
    else
     	_.forEach(answer, (contact) ->
      	line = '' + contact.name + ': ' + Number(contact.outstanding).toFixed(2)
      	if(contact.overdue > 0)
      		line += ' (' + Number(contact.overdue).toFixed(2) + ' overdue)'
      	results.push(line)
      	)
  		return results;
  }
