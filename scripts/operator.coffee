Promise = require("bluebird");

# All of the operators
WhoOwesMoney = require('./who-owes-money');
HowMuchMoneyDoIHave = require('./how-much-money-do-i-have');
WhatBillsAreComingUp = require('./what-bills-are-coming-up');

standardSingleQuery = (operation) ->
	new Promise((resolve, reject) ->
      # Start the request and get its promise
      promise = operation.doRequest();
      promise.then(
        (xeroResponse) ->
          answer = operation.createAnswer(xeroResponse);
          formattedAnswer = operation.formatAnswer(answer);
          resolve(formattedAnswer);
        () ->
          reject();
      )
    )


module.exports = {

  whoOwesMoney: () ->
  	standardSingleQuery(WhoOwesMoney)

  whatBillsAreComingUp: () ->
  	standardSingleQuery(WhatBillsAreComingUp)

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
