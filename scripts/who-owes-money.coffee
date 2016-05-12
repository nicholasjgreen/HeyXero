Promise = require("bluebird");
XeroConnection = require('./xero-connection');

module.exports = {
	doRequest: () ->
		promise = new Promise (resolve, reject) ->
    		XeroConnection().call 'GET', '/Reports/BalanceSheet', null, (err, json) ->
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