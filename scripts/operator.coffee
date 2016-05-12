Promise = require("bluebird");

# All of the operators
WhoOwesMoney = require('./who-owes-money');
HowMuchMoneyDoIHave = require('./how-much-money-do-i-have');

module.exports = {

  whoOwesMoney: () ->
    new Promise((outerResolve, outerReject) ->
      # Start the request and get its promise
      promise = WhoOwesMoney.doRequest();
      promise.then(
        (xeroResponse) ->
          answer = WhoOwesMoney.createAnswer(xeroResponse);
          formattedAnswer = WhoOwesMoney.formatAnswer(answer);
          outerResolve(formattedAnswer);
        () ->
          outerReject();
      )
    )

  howMuchMoneyDoIHave: () ->
    new Promise((resolve, reject) ->
      # Make the request
      promise = HowMuchMoneyDoIHave.doRequest()
      promise.then(
        (json) ->
          parsedXeroResonse = HowMuchMoneyDoIHave.parseResponse(json)
          formattedAnswer = HowMuchMoneyDoIHave.formatAnswer(parsedXeroResonse)
          # Resolve with the formatted answer
          resolve(formattedAnswer)
        () ->
          reject()
      )
    )

}
