Promise = require("bluebird");
XeroConnection = require('./xero-connection');

module.exports = {
	doRequest: () ->
		promise = new Promise (resolve, reject) ->
			# https://api.xero.com/api.xro/2.0/contacts?where=(Balances+!%3d+null+%26%26+Balances.AccountsReceivable+!%3d+null+%26%26+Balances.AccountsReceivable.Outstanding+%3e+0)&order=(Balances.AccountsReceivable.Outstanding)+DESC&page=1
    		XeroConnection().call 'GET', 'contacts?where=(Balances+!%3d+null+%26%26+Balances.AccountsReceivable+!%3d+null+%26%26+Balances.AccountsReceivable.Outstanding+%3e+0)&order=(Balances.AccountsReceivable.Outstanding)+DESC&page=1', null, (err, json) ->
      			if(err)
      				reject
      			else
        			resolve(json)

		return promise;

	parseXeroRespone: (xeroResponse) ->
		return xeroResponse

	createAnswer:  (parsedResponse) ->
		return {
			name: 'bob' 
			} 

	formatAnswer: (answer) ->
		return 'you do, ' + answer.name;
}		