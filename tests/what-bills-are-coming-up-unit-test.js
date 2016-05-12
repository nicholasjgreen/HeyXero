var assert = require('assert');
var FS = require('fs');
var whatBillsAreComingUp = require('../js/what-bills-are-coming-up'); 


describe('WhatBillsAreComingUp', function () {

	describe('#createAnswer()', function () {
		it('should handle multiple invoices', function () {
			var json = FS.readFileSync('./tests/data/what-bills-are-coming-up-multiple.json');
			var answer = whatBillsAreComingUp.createAnswer(JSON.parse(json));
			assert.equal(answer.length, 5);
			assert.equal(answer[0].name, 'Zulu Company Limited')
			assert.equal(answer[0].dueDate, '2015-07-28T00:00:00')
			assert.equal(answer[0].amountDue, 258.75)
        });

		it('should handle one invoices', function () {
			var json = FS.readFileSync('./tests/data/what-bills-are-coming-up-single.json');
			var answer = whatBillsAreComingUp.createAnswer(JSON.parse(json));
			assert.equal(answer.length, 1);
			assert.equal(answer[0].name, 'Whiskey Company Limited')
			assert.equal(answer[0].dueDate, '2014-04-01T00:00:00')
			assert.equal(answer[0].amountDue, 149.50)
        });

		it('should handle no invoices', function () {
			assert.equal(whatBillsAreComingUp.createAnswer(null).length, 0);
			assert.equal(whatBillsAreComingUp.createAnswer({}).length, 0);
			assert.equal(whatBillsAreComingUp.createAnswer().length, 0);
			assert.equal(whatBillsAreComingUp.createAnswer({Contacts: []}).length, 0);
        });
    });

	describe('#formatAnswer()', function () {

		function anInvoice(contactName, dueDate, amountDue){
			return {
				name: contactName
				dueDate: dueDate
				amountDue: amountDue
			};
		}

		it('should handle multiple invoices', function () {
			var result = whatBillsAreComingUp.formatAnswer([
				anInvoice('Bob', "2014-04-01T00:00:00", 100.00),
				anInvoice('Fred', "2014-04-01T00:00:00", 50.00),
				anInvoice('Malthilde', "2014-04-01T00:00:00", 12.12)
			]);

			assert.equal(result[0], 'Bob: 100.00 (10.00 overdue)');
			assert.equal(result[1], 'Fred: 50.00 (5.00 overdue)');
			assert.equal(result[2], 'Malthilde: 10.00');
        });

		it('should handle one invoices', function () {
        });

		it('should handle no invoices', function () {
        });
    });


        
});