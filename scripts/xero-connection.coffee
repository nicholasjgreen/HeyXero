Xero = require('xero');
FS = require('fs');

module.exports = () ->
		new Xero("MX3ALNIJI27NOYWIG0SKDZU3U7NI2U", "EQ4C2UHFTQK16GTSRXLGVTNBYRACSH", FS.readFileSync('./privatekey.pem')) 