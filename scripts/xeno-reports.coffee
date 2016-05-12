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

module.exports = (robot) ->
 
	robot.respond /money/i, (res) ->
		console.log('about to ask operator, who owes money?')
		Operator.whoOwesMoney().then(
			(result) ->
				console.log('Answering!')
				res.reply(result)
			(r) ->
				console.log('Something has gone wrong :( ' + r)
				res.reply("I'm not sure, how about you ask again later?")
		)
