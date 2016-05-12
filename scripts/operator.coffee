Promise = require("bluebird");

# All of the operators
WhoOwesMoney = require('./who-owes-money');

module.exports = {
	hello: "yo"
	whoOwesMoney: () ->
		outerPromise = new Promise (resolve, reject) -> 

			# Start the request and get its promise
			promise = WhoOwesMoney.doRequest();
			promise.then (xeroResponse) ->
				parsedXeroResponse = WhoOwesMoney.parseXeroRespone(xeroResponse);
				answer = WhoOwesMoney.createAnswer(parsedXeroResponse);
				formattedAnswer = WhoOwesMoney.formatAnswer(answer);

				# Resolve with the formatted answer
				resolve(formattedAnswer);

		return outerPromise;
}
