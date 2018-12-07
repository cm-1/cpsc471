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
	var values_ci = [[title, fname, lname, address, email, hphone, cphone]];
	db.query(query, [values_ci], function (err, result) {
		if (err){
			if (err){
				console.log(err);
				throw err;
			}
			
		} else{
			const ci_id = result.insertId;
			
			var query2 = "INSERT INTO Patient (Health_care_id, Sex, Birthdate, CI_ID) VALUES ?";
			var values_p = [[hcid, sex, birthdate, ci_id]];
			db.query(query2, [values_p], function (err, result) {
				if (err) console.log(err);
				if (err && err.code == 'ER_DUP_ENTRY'){
					var msg = "Error: HCID '" + hcid + "' is already in use!";
					console.log("Well, there's a duplicate!");
					req.flash('danger', msg);
					res.redirect('/myinfo/info');
				}
				else if (err){
					console.log(err);
					throw err;
				}
				else{
					//var query3 = "SELECT COUNT(*) FROM client_account where id = "+req.user.id;
					db.query("select count(*) from client_account where accountID =" + req.user.id, function (err, rows, fields){
						console.log("\n\nCOUNT*!!!:");
						console.log(rows);
						if (err){
							console.log(err);
							throw err;
						} 
						if (rows[0]['count(*)'] <= 0) {
							var query4 = "Insert into client_account (accountID, healthcare_id) values ?";
							var values_ca = [[req.user.id, hcid]];
							db.query(query4, [values_ca], function(err, results){
								if(err) throw err;
								req.flash("success", "Info updated!");
								res.redirect('/');
							});
						} else{
							req.flash('success', "Info updated!")
							res.redirect('/');
						}
					});
				}
			});
		
		}
	});

});


module.exports = router;