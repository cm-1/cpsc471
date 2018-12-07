const express = require('express');
const router = express.Router();

var db = require('./../db');


//Add Route

router.get('/view', function(req, res){
	//Gets the article table in JSON format.
	// "rows" is, predictably, the actual data
	console.log("Before insert...");
	db.query("select * from survey", function (err, rows, fields){
		if (err){
			console.log(err);
			throw err;
		}
		//console.log(rows);
		res.render('view_survey', {title:'take a survey', surveys:rows});
	});
	console.log("...after insert.");
});


//Ensure Authentication
function ensureAuthenticated(req, res, next){
	if (req.isAuthenticated()){
		return next();
	} else{
		req.flash('danger', 'Please login');
		res.redirect('/users/login');
	}
}
module.exports = router;