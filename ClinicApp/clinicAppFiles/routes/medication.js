const express = require('express');
const router = express.Router();


var db = require('./../db');

router.get('/add', ensureAuthenticated, function(req, res) {
    res.render('add_medication', {title:'Add your Medication'});
});


router.post('/add', ensureAuthenticated, function(req, res) {
    
    const ID  = req.body.ID;
    const name = req.body.name;
    const manufacturer = req.body.manufacturer;
    const description = req.body.description;

    req.checkBody('ID', 'ID is required').notEmpty();
    req.checkBody('name', 'Name is required').notEmpty();
    req.checkBody('manufacturer', 'Manufacturer is required').notEmpty();
    req.checkBody('description', 'description is required').notEmpty();

   // var med_idExists = false;
   // var nameExists = false;
    
    /* Going off users.js, checking to see if the med_id is already in the table */ 
    let errors = req.validationErrors();
    if (errors) {
        res.render('add_medication', {Title:'Add Medication', errors: errors});
    } else {
        var query = "INSERT INTO medication (ID, name, manufacturer, description) VALUES?";
        var values = [[req.body.ID, req.body.name, req.body.manufacturer, req.body.description]];
        db.query(query, [values], function (err, result) {
            if (err) {
                throw err;
            } else {
                req.flash('success', 'Medication added');
                res.redirect('/');
            }
            console.log("med added");
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
