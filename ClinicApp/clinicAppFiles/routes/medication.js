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


function ensureAuthenticated(req, res, next) {
    if (req.isAuthenticated()) {
        return next();
    } else {
        req.flash('danger', 'Please Login');
        res.redirect('/users/login');
    }
}

module.exports = router;
