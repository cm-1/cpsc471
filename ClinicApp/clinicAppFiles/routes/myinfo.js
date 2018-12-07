const express = require('express');
const router = express.Router();

var db = require('./../db');



router.get('/info', function(req, res){

	/*req.checkBody('email', 'Email is required').notEmpty();
	req.checkBody('email', 'Email is not valid').isEmail();
	req.checkBody('username', 'Username is required').notEmpty();
	req.checkBody('password', 'Password is required').notEmpty();
	req.checkBody('password2', 'Passwords do not match').equals(req.body.password);*/
	
	if(req.user){
		db.query("select count(*) from client_account where accountID =" + req.user.id, function (err, rows, fields){
			var p = {Health_care_id :'', Sex:0, Birthdate:''};
			var c = {Title :'', Fname :'', Lname :'', Address :'',  Email :'', Home_phone :'', Cell_phone :''};
			var information = {patient:p, ci:c, Privilege_Level:req.user.Privilege_Level};
			if (err){
				console.log(err);
				throw err;
			} else {
				console.log(rows);
				res.render('my_info', {info:information});
			}
		});
	} else{
		req.flash('danger', 'Not Logged In');
		res.redirect('/');
	}

});

router.post('/info', function(req, res){
	const hcid = req.body.health_care_id;
	const sex = req.body.sex;
	const birthdate = req.body.birthdate;
	const title = req.body.title;
	const fname = req.body.fname;
	const lname = req.body.lname;
	const address = req.body.address;
	const email = req.body.email;
	const hphone = req.body.home_phone;
	const cphone = req.body.cell_phone;
	/*req.checkBody('email', 'Email is required').notEmpty();
	req.checkBody('email', 'Email is not valid').isEmail();
	req.checkBody('username', 'Username is required').notEmpty();
	req.checkBody('password', 'Password is required').notEmpty();
	req.checkBody('password2', 'Passwords do not match').equals(req.body.password);*/
	
	var query = "INSERT INTO contact_info (Title, Fname, Lname, Address, Email, Home_phone, Cell_phone) VALUES ?";
	var values = [[username, email, hashedPassword]];
	db.query(query, [values], function (err, result) {
		if (err){
			if (err.code == 'ER_DUP_ENTRY'){
				var msg = "Error: Username '" + username + "' is already in use!";
				if(err.message.indexOf("for key 'Email_UNIQUE'") > 0){
					msg = "Error: Email address '" + email + "' is already in use!";
				}
				console.log("Well, there's a duplicate!");
				req.flash('danger', msg);
				res.redirect('/users/register');
			}
			else{
				console.log(err);
			throw err;
			}
			
		} else{
			console.log("# records inserted: " + result.affectedRows);

			req.flash('success', 'Account Created!');

			res.redirect('/users/login');
			
		}
	});

});


module.exports = router;