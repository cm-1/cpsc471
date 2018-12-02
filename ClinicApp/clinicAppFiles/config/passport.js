const LocalStrategy = require('passport-local').Strategy;

var db = require('../db');

const bcrypt = require('bcryptjs');

module.exports = function(passport){
	//Local strategy
	passport.use(new LocalStrategy(function(username, password, done){
		console.log("..Username = " + username);
		//Match Username
		db.query("select * from user_account where username = \"" + username + "\";", function (err, rows, fields){
			console.log(rows[0]);
			if (err){
				console.log(err);
				throw err;
			} else if (rows.length <= 0){
				return done(null, false, {message: "Incorrect Login"});
			} else {
				var user = rows[0];
				console.log("Password comparison:");
				console.log(" - " + password + " " + typeof(password));
				console.log(" - " + user.Password + " " + typeof(user.Password));
				bcrypt.compare(password, user.Password, function(err, isMatch){
					if (err){
						throw err;
					} 
					else if(isMatch){
						return done(null, user);
					} else{
						return done(null, false, {message: "Incorrect Login"});
					}
				});
			}
		});
	
	}));
	
	passport.serializeUser(function(user, done){
		done(null, user.id);
	});
	
	passport.deserializeUser(function(id, done){
		db.query("select * from user_account where id = " + id + ";", function (err, rows, fields){
			done(err, rows[0]);
		});
	});
}