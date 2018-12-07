const express = require('express');
const router = express.Router();


var db = require('./../db');

router.get('/book_appt', ensureAuthenticated, function(req, res) {
    res.render('book_appt', {title:'Book your appointment'});
});


router.post('/book_appt', ensureAuthenticated, function(req, res) {
    
    const name = req.body.name;
    const emName = req.body.emName;
    const date = req.body.date;
    const time = req.body.time;
    const hcid = req.body.hcid;

    req.checkBody('hcid', 'HealthcareID is required').notEmpty();
    req.checkBody('name', 'Name is required').notEmpty();
    req.checkBody('emName', 'Employee ID is required').notEmpty();
    req.checkBody('date', 'Date is required').notEmpty();
    req.checkBody('time', 'time is required').notEmpty();
    
    /* Going off users.js, checking to see if the med_id is already in the table */ 
    let errors = req.validationErrors();
    if (errors) {
        res.render('book_appt', {Title:'Book your Appointment', errors: errors});
    } else {
        var query = "INSERT INTO attends (Healthcare_ID, Employee_ID, Date, Time) VALUES ?";
        var values = [[req.body.hcid, req.body.emName, req.body.date, req.body.time]];
        db.query(query, [values], function (err, result) {
            if (err) {
				if (err.code == 'ER_DUP_ENTRY') {
					var msg = "Error: Date '" + date + "' is already in use!";
					/* Might not be an error for key primary */
					if (err.message.indexOf("for key 'PRIMARY'") > 0) {
						msg = "Error: Time '" + time + "' is already in use!";
				}
				console.log("Dup appointment");
				req.flash('danger', msg);
				res.redirect('/appointment/book_appt');
               
				} else {
					throw err;
				}
			} else {
                req.flash('success', 'Appointment booked');
                res.redirect('/');
            }
            console.log("appt booked");
        });
    }
});


router.get('/delete', ensureAuthenticated, function(req, res) {


	db.query("select * from medication", function(err, rows, fields) {
		if (err) {
			console.log("error in select * from medication, medication.js");
			throw err;
		}
		res.render('delete_medication', {title:'Enter the ID you\'d like to delete', medication:rows});
	});
});

/* View all medication in the table and remove by ID */
router.post("/delete", function(req, res) {
	const ID = req.body.ID;
	req.checkBody('ID', 'ID must match a current ID').notEmpty();
	
	var delQuery = "DELETE from MEDICATION where ID =" + ID;

	db.query("select * from medication where ID ="+ ID, function (err, rows, fields) {
		if (err) {
			console.log(err);
			throw err;
		} else {
			db.query(delQuery, function (err2, rows2, fields2) {
				if (err2) {
					console.log(err2);
				} else {
					req.flash('success', 'Medication removed');
					res.redirect('/');
				}
			});
		}
	});
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
