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

router.get('/view/:id', function(req, res) {
	db.query("select * from survey where id = " + req.params.id, function(err, rows, fields) {
		if (err) {
			console.log(err);
			throw err;
		}
		var surveyInfo = rows[0];
		db.query("select number, prompt from question where survey_id = " +surveyInfo.ID, function(err2, rows2, fields2) {
			if (err2) {
				console.log("err in selecting router.get/view/:id");
				throw err;
			}
		res.render('survey', {title:'Survey', questions:rows2});
		});
	});
});

//Retrieving individual surveys
// The ':id' is a placeholder
router.post('/view/:id', function(req, res){
	console.log("hello world");
	const q1 = req.body.q1;
	const q2 = req.body.q2;

	req.checkBody('q1', 'Answer is required').notEmpty();
	req.checkBody('q2', 'Answer is required').notEmpty();
	
	var score = score + q1;
	score = score + q2;
	req.flash("Success", "Your score is saved");
	res.redirect("/");
	/*
	console.log("Rendering /view/id");
	db.query("select * from survey where id = " + req.params.id, function (err, rows, fields){
		if (err){
			console.log(err);
			throw err;
		}
		var surveyInfo = rows[0];
		var score = 0;	
		db.query("select number, prompt from question where survey_ID = "+ surveyInfo.ID, function(err2, rows2, fields2){
			console.log("test3");
			if (err2){
				console.log(err2);
				throw err2;
			} else {
				console.log("test1");

				for (var i = 1; i < 3; i++){
					console.log("test");	
					score += req.body.q+i; 
					//console.log(rows)
					console.log("score: " + score);
					}
			}
					var query2 = "insert into survey_response (Survey_ID, Healthcare_ID, Date, Score) Values ?";
					var gethcid = "select healthcare_id from client_account where accountID = " + req.user.id;
					var q2 = db.query(gethcid);
					var d = 1994-02-03;
					console.log(q2);
					/*
					var entries = [[surveyInfo.ID, q2, '1994-03-09', 3]];
					db.query(query2, [entries], function(err, results) {
						if (err) throw err;
						req.flash("success", "Info updated!");
						res.redirect("/");
					});

	
		});
	//		res.render('survey', {title:'Survey', questions:rows2});	
	});
*/
});


module.exports = router;

