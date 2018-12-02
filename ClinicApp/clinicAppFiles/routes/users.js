const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const passport = require('passport');


var db = require('./../db');

// NOTE: Remember, this will go to /users/register !
router.get('/register', function(req, res){
	res.render("register");
});

// Register Process
router.post('/register', function(req, res){
	const email = req.body.email;
	const username = req.body.username;
	const password = req.body.password;
	const password2 = req.body.password2;
	
	req.checkBody('email', 'Email is required').notEmpty();
	req.checkBody('email', 'Email is not valid').isEmail();
	req.checkBody('username', 'Username is required').notEmpty();
	req.checkBody('password', 'Password is required').notEmpty();
	req.checkBody('password2', 'Passwords do not match').equals(req.body.password);
	
	var hashedPassword;
	let errors = req.validationErrors();
	
	var userExists = false;
	var emailExists = false;
	
	console.log("\n\n! ! ! ! ! ! ! ! ! \nDuplicate user/email accounts check still needs fixing!!!!!\n= ==  =     = = =   =  =\n\n");
	//! ! ! The "duplicate user" checking is currently broken!!!
	db.query("select * from user_account where username = \"" + username + "\";", function (err, rows, fields){
		if (err){
			console.log(err);
			throw err;
		}
		userExists = rows.length > 0;
	});
	db.query("select * from user_account where email = \"" + email + "\";", function (err, rows, fields){
		if (err){
			console.log(err);
			throw err;
		}
		emailExists = rows.length > 0;
	});
	
	if (userExists) errors.push(new Error("Username already exists."));
	if (emailExists) errors.push(new Error("Email already exists."));
	
	if(errors){
		res.render('register', {errors:errors});
	} else {
		bcrypt.genSalt(10, function(err, salt){
			bcrypt.hash(password, salt, function(err, hash){
				if (err) console.log(err);
				console.log("! ! !" + hash);
				hashedPassword = hash;
				
				var query = "INSERT INTO user_account (username, email, password) VALUES ?";
				var values = [[username, email, hashedPassword]];
				db.query(query, [values], function (err, result) {
					if (err){
						console.log(err);
						throw err;
					} else{
						req.flash('success', 'Account Created!');
						res.redirect('/users/login');
					}
					console.log("# records inserted: " + result.affectedRows);
				});
			});
		});
	}
});

router.get('/login', function(req, res){
	res.render('login');
});

router.post('/login', function(req, res, next){
	passport.authenticate('local', {successRedirect: '/', failureRedirect:'/users/login', failureFlash: true})(req, res, next);
	
});

router.get('/editaccount', function(req, res){
	if(req.user){
		db.query("select Email from user_account where id = " + req.user.id, function (err, rows, fields){
			if (err){
				console.log(err);
				throw err;
			} else {
			//console.log(rows);
				res.render('edit_account', {account:rows[0]});
			}
		});
	} else{
		req.flash('danger', 'Not Logged In');
		res.redirect('/');
	}

});

router.post('/editaccount', function(req, res){
	var query;
	var userID = req.user.id;
	var values;
	
	const email = req.body.email;
	const password = req.body.password;
	const password2 = req.body.password2;
	
	req.checkBody('email', 'Email is required').notEmpty();
	req.checkBody('email', 'Email is not valid').isEmail();
	
	var hashedPassword;
	console.log("\n\n! ! ! ! ! ! ! ! ! \nDuplicate user/email accounts check still needs fixing!!!!!\n= ==  =     = = =   =  =\n\n");
	//! ! ! The "duplicate user" checking is currently broken!!!

	
	if (password == ''){
		let errors = req.validationErrors();

		if(errors){
			res.render('edit_account', {errors:errors});
		} else {
			query = "UPDATE user_account SET ? WHERE ?";
			//The structure for this one's more interesting...
			//The first "object" in the array is the values to alter.
			//The second "object" goes in the "WHERE"
			values = [{ Email:email },
				{id: userID}];
				
			db.query(query, values, function (err, result) {
				if (err){
					console.log(err);
					throw err;
				} else{
					req.flash('success', 'Account Updated!');
					res.redirect('/');
				}
			});
		}
		
	} else {
		req.checkBody('password', 'Password is required').notEmpty();
		req.checkBody('password2', 'Passwords do not match').equals(req.body.password);
		let errors = req.validationErrors();
		
		if(errors){
			res.render('edit_account', {errors:errors});
		} else {
			bcrypt.genSalt(10, function(err, salt){
				bcrypt.hash(password, salt, function(err, hash){
					if (err) console.log(err);
					console.log("! ! !" + hash);
					hashedPassword = hash;
					
					query = "UPDATE user_account SET ? WHERE ?";
					//The structure for this one's more interesting...
					//The first "object" in the array is the values to alter.
					//The second "object" goes in the "WHERE"
					values = [{ Email:email, Password:hashedPassword },
						{id: userID}];
					db.query(query, values, function (err, result) {
						if (err){
							console.log(err);
							throw err;
						} else{
							req.flash('success', 'Account Updated!');
							res.redirect('/');
						}
					});
				});
			});
		}
	}
});

router.get('/logout', function(req, res){
		//console.log(req);
	req.logout();
	req.flash("success", "You are logged out, boy");
	res.redirect('/users/login');
});

module.exports = router;