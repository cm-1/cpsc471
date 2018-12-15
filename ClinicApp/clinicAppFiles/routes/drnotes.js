const express = require('express');
const router = express.Router();


var db = require('./../db');

router.get('/add', ensureAuthenticated, function(req, res) {
	res.render('add_notes', {title:'Notes'});
});

router.post('/add', ensureAuthenticated, function(req, res) {

	const hcid = req.body.hc_id;
	const eid = req.body.e_id;
	const notes = req.body.dr_notes;
	const date = req.body.date;
	const time = req.body.time;

	let errors = req.validationErrors();
	if (errors) {
		res.render('add_notes', {title:'Notes', errors: errors});
	} else {

		var query = "INSERT into appointment (dr_notes) VALUES where (employee_id='" + eid + "', date='" + date + "', start_time='" + time + "');";
		var values = [[req.body.dr_notes]];

		db.query(query, [values], function(err, result) {
			if (err) {
				/* figure out error codes later */
				throw err; 
			} else {
			req.flash('success', 'Note added');
			res.redirect('/');
		} console.log("Note added");
	});
	}
});


function ensureAuthenticated(req, res, next) {
	if (req.isAuthenticated()) {
		return next();
	} else {
		req.flash('danger', 'Please login');
		res.redirect('/users/login');
	}
}




module.exports = router;

