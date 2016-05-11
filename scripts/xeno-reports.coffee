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
FS = require('fs');

module.exports = (robot) ->

  robot.respond /show me my balance sheets/i, (res) ->
    xero = new Xero("MX3ALNIJI27NOYWIG0SKDZU3U7NI2U", "EQ4C2UHFTQK16GTSRXLGVTNBYRACSH",
      FS.readFileSync('./privatekey.pem'))

    xero.call 'GET', '/Reports/BalanceSheet', null, (err, json) ->
      if(err)
        res.send 'Sorry, there was an error in fetching the balance sheets...'
      else
        res.send JSON.stringify(json)
