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


module.exports = router;