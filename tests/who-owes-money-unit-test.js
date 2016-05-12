var assert = require('assert');
var whoOwesMoney = require('../js/who-owes-money'); 


describe('WhoOwesMoney', function () {

	describe('#extract()', function () {
		it('should reject null messages', function () {
			var answer = whoOwesMoney.createAnswer(null);
			assert.equal(answer.name, 'bob');
        });
    });
        
});