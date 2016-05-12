Promise = require("bluebird");

# All of the operators
WhoOwesMoney = require('./who-owes-money');

module.exports = {
	whoOwesMoney: () ->
		console.log('yo')
		outerPromise = new Promise((outerResolve, outerReject) -> 
			# Start the request and get its promise
			promise = WhoOwesMoney.doRequest();
			promise.then(
				(xeroResponse) ->
					answer = WhoOwesMoney.createAnswer(xeroResponse);
					formattedAnswer = WhoOwesMoney.formatAnswer(answer);
					console.log('Got a formatted answer, resolving!  ' + formattedAnswer)
					outerResolve(formattedAnswer);
				() ->
					console.log('Rejecting')
					outerReject();
			)
		)
		return outerPromise;
}
