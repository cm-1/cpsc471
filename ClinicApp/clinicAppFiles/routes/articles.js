const express = require('express');
const router = express.Router();

var db = require('./../db');


//Add Route
router.get('/add', ensureAuthenticated, function(req, res){
	//Gets the article table in JSON format.
	// "rows" is, predictably, the actual data
	res.render('add_article', {title:'Add an Article'});
	
});



//Load edit form
// The ':id' is a placeholder
router.get('/edit/:id', ensureAuthenticated, function(req, res){
	db.query("select * from article where id = " + req.params.id, function (err, rows, fields){
		
		if (err){
			console.log(err);
			throw err;
		}
		else if(rows[0].authorID != req.user.id){
			req.flash('danger', 'Not Authorized');
			res.redirect('/');
		} else {
		//console.log(rows);
			res.render('edit_article', {title:'Editing Article', article:rows[0]});
		}
	});
});


//It's fine that the URL is the same as the get request.
router.post('/add', function(req, res){
	req.checkBody('title', "Title is required").notEmpty();
	//req.checkBody('author', "Title is required").notEmpty();
	req.checkBody('body', "Title is required").notEmpty(); //There are lots of validator options!
															//Check online, on the module's github!
	//Get Errors
	let errors = req.validationErrors();
	
	if(errors){
		res.render('add_article', {title:'Add Article', errors: errors});
	} else {
		var query = "INSERT INTO article (title, author, body, authorID) VALUES ?";
		var values = [[req.body.title, req.user.username, req.body.body, req.user.id]];
		db.query(query, [values], function (err, result) {
			if (err){ 
				throw err;
			} else{
				req.flash('success', 'Article Added');
				res.redirect('/');
			}
			console.log("# records inserted: " + result.affectedRows);
		});
	}

});

//Editing an article
//It's fine that the URL is the same as the get request.
router.post('/edit/:id', function(req, res){
	var query = "UPDATE article SET ? WHERE ?";
	var articleID = req.params.id;
	
	//The structure for this one's more interesting...
	//The first "object" in the array is the values to alter.
	//The second "object" goes in the "WHERE"
	//That is, below, the title, author, and body are updated wherever article.id = articleID
	var values = [{ title: req.body.title, author: req.body.author, body: req.body.body },
				{id: articleID}];
				
	db.query(query, values, function (err, result) {
		if (err){ 
			throw err;
		} else{
			req.flash('success', 'Article updated');
			res.redirect('/articles/'+articleID);
		}
		console.log("# records inserted: " + result.affectedRows);
	});
})

function ensureAuthenticated(req, res, next){
	if (req.isAuthenticated()){
		return next();
	} else{
		req.flash('danger', 'Please login');
		res.redirect('/users/login');
	}
}

router.delete('/:id', function(req, res){
	if(!req.user){
		res.status(500).send();
	} else {
		var query = "DELETE FROM article WHERE id =" + req.params.id;
	
	
		db.query("select * from article where id = " + req.params.id, function(err, rows, fields){
			if(rows[0].authorID != req.user.id){
				res.status(500).send();
			} else {
				db.query(query, function (err2, rows2, fields2){
					if (err2){
						console.log(err2);
					} else{
						res.send("Success");
					}
					//console.log(rows);
				});
			}
		});
	}
	

});


/* ! ! ! This one needs to be at the bottom, so that it's called last, or else /articles/add will apply, with id = add! */

//Retrieving individual articles
// The ':id' is a placeholder
router.get('/:id', function(req, res){
	db.query("select * from article where id = " + req.params.id, function (err, rows, fields){
		if (err){
			console.log(err);
			throw err;
		}
		var articleInfo = rows[0];
		db.query("select id, username from user where id = " + articleInfo.authorID, function(err2, rows2, fields2){
			if (err2){
				console.log(err2);
				throw err2;
			}
			//console.log(rows);
			res.render('article', {title:'Selected Article', article:articleInfo, author:{id:rows2[0].id, username:rows2[0].username}});
		});
		
	});
});

module.exports = router;