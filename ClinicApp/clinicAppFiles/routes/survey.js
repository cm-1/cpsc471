const express = require('express');
const router = express.Router();
const url = require('url');


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

/* ! ! ! This one needs to be at the bottom, so that it's called last, or else /articles/add will apply, with id = add! */

//Retrieving individual surveys
// The ':id' is a placeholder
router.get('/view/:id', function(req, res){
	console.log("Rendering /view/id")
	db.query("select * from survey where id = " + req.params.id, function (err, rows, fields){
		if (err){
			console.log(err);
			throw err;
		}
		var surveyInfo = rows[0];
		db.query("select number, prompt from question where survey_ID = "+ surveyInfo.ID, function(err2, rows2, fields2){
			if (err2){
				console.log(err2);
				throw err2;
			}
			//console.log(rows);
			res.render('survey', {title:'Survey', survey:surveyInfo, questions:rows2});
		});
		
	});
});


module.exports = router;

