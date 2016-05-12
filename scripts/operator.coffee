Promise = require("bluebird");

# All of the operators
WhoOwesMoney = require('./who-owes-money');
HowMuchMoneyDoIHave = require('./how-much-money-do-i-have');

module.exports = {

  whoOwesMoney: () ->
    console.log('yo')
    new Promise((outerResolve, outerReject) ->
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

  howMuchMoneyDoIHave: () ->
    new Promise((resolve, reject) ->
      # Make the request
      promise = HowMuchMoneyDoIHave.doRequest()
      promise.then(
        (json) ->
          console.log('Got a response!')
          parsedXeroResonse = HowMuchMoneyDoIHave.parseResponse(json)
          formattedAnswer = HowMuchMoneyDoIHave.formatAnswer(parsedXeroResonse)
          # Resolve with the formatted answer
          resolve(formattedAnswer)
        () ->
          console.log('Rejecting')
          reject()
      )
    )

}
