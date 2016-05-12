# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md
Xero = require('xero');
Operator = require('./operator');
Promise = require("bluebird");
_ = require('lodash');

module.exports = (robot) ->

  robot.respond(/who owes( me)?( the most)?( money)?\??/i, (res) ->
    console.log('about to ask operator, who owes money?')
    Operator.whoOwesMoney().then(
      (result) ->
        res.reply(_.join(result, '\n'))
      (r) ->
        console.log('Something has gone wrong :( ' + r)
        res.reply("I'm not sure, how about you ask again later?")
    )
  )

  robot.respond(/how much money do I have/i, (res) ->
    console.log('about to ask operator, how much money do i have?')
    Operator.howMuchMoneyDoIHave().then(
      (result) ->
        console.log('Answering!')
        res.reply(result)
      (err) ->
        console.log("Something has gone wrong :( #{err}")
        res.reply("I'm not sure, how about you ask again later?")
    )
  )

#  robot.respond(/what bills( are)?( coming up)?\??/i, (res) ->
  robot.respond(/bills/i, (res) ->
    console.log('about to ask operator, what bills are coming up?')
    Operator.whatBillsAreComingUp().then(
      (result) ->
        res.reply(_.join(result, '\n'))
      (r) ->
        console.log('Something has gone wrong :( ' + r)
        res.reply("I'm not sure, how about you ask again later?")
    )
  )

