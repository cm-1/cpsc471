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
	const name = req.body.name;
	const email = req.body.email;
	const username = req.body.username;
	const password = req.body.password;
	const password2 = req.body.password2;
	
	req.checkBody('name', 'Name is required').notEmpty();
	req.checkBody('email', 'Email is required').notEmpty();
	req.checkBody('email', 'Email is not valid').isEmail();
	req.checkBody('username', 'Username is required').notEmpty();
	req.checkBody('password', 'Password is required').notEmpty();
	req.checkBody('password2', 'Passwords do not match').equals(req.body.password);
	
	var hashedPassword;
	let errors = req.validationErrors();
	
	var userExists = false;
	var emailExists = false;
	
	//! ! ! The "duplicate user" checking is currently broken!!!
	db.query("select * from user where username = \"" + username + "\";", function (err, rows, fields){
		if (err){
			console.log(err);
			throw err;
		}
		userExists = rows.length > 0;
	});
	db.query("select * from user where email = \"" + email + "\";", function (err, rows, fields){
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
				
				var query = "INSERT INTO user (username, email, password, name) VALUES ?";
				var values = [[username, email, hashedPassword, name]];
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

router.get('/logout', function(req, res){
		//console.log(req);
	req.logout();
	req.flash("success", "You are logged out, boy");
	res.redirect('/users/login');
});

module.exports = router;