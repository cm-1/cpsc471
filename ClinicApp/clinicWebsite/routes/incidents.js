const express = require('express');
const router = express.Router();

var db = require('./../db');


router.get('/add', ensureAuthenticated, function(req, res) {
	res.render('add_incident', {title:'Report an Incident'});
});

router.post('/add', ensureAuthenticated, function(req,res) {

	const empID = req.body.Employee_ID;
	const date = req.body.Date;
	const time = req.body.Time;
	const description = req.body.Description;
	const severity = req.body.Severity;
	const category = req.body.Category;
	const resolution = req.body.Resolution;
	const hcid = req.body.Health_care_id;
	const esid = req.body.ES_ID;
	const ename = req.body.Name;

	req.checkBody('empID', 'Employee ID is required').notEmpty();
	req.checkBody('date', 'Date is required').notEmpty();
	req.checkBody('time', 'Time is required').notEmpty();
	req.checkBody('description', 'Description is required').notEmpty();
	req.checkBody('severity', 'Severity is required').notEmpty();
	req.checkBody('category', 'Category is required').notEmpty();
	req.checkBody('resolution', 'Resolution is required').notEmpty();
	req.checkBody('hcid', 'Health care ID is required').notEmpty();
	req.checkBody('esid', 'Emergency Services ID is required').notEmpty();
	req.checkBody('ename', 'Emergency Services name is required').notEmpty();

	let errors = req.validationErrors();

	if (errors) {
		res.render('add_incident', {title:'Report an Incident', errors:errors});
	} else {
		var query = "INSERT INTO incident (Employee_ID, Date, Time, Description, Severity, Category, Resolution) Values ?";

		var values = [[req.body.empID, req.body.date, req.body.time, req.body.description, req.body.severity, req.body.category, req.body.resolution]];
		
		db.query(query, [values], function (err, result) {
			if (err) {
				/* some error */
				var msg = "some error";

				console.log("some err in inserting to incident");
				req.flash('danger', msg);
				res.redirect('/incidents/add');
			/*} else {
				throw err;
			}*/
		} else {
			req.flash('success', 'Incident added');
			res.redirect('/');
/*
			var query2 = "INSERT into informed_of (Employee_ID, Date, Time, ES_ID) " "(`" + req.body.empID + "`, `" + req.body.date + "`, `" + req.body.time + "`, `" + 
*/
		console.log("something added");
		}
	});
	}
});




function ensureAuthenticated(req, res, next) {
	if (req.isAuthenticated()) {
		return next();
	} else {
		req.flash('danger', 'Please Login');
		res.redirect('/users/login');
	}
}

module.exports = router;
