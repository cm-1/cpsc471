const express = require('express');
const router = express.Router();


var db = require('./../db');

router.get('/book_appt', ensureAuthenticated, function(req, res) {
    res.render('book_appt', {title:'Book your appointment'});
});

router.get('/', ensureAuthenticated, function(req, res) {
	var firstMethod = function(){
		var firstPromise = new Promise((resolve, reject) => {
			var q = "Select * from appointment as AP, attends as AT, EMPLOYEE AS E, CONTACT_INFO AS C where AP.date = AT.date and AP.start_time = AT.time and AP.Employee_ID = AT.Employee_ID and AP.Employee_ID = E.Employee_ID and E.CI_ID = C.CI_ID and AT.Healthcare_ID in (SELECT healthcare_id from client_account where accountID = " + req.user.id + ") and AP.date >= (select CURDATE()) and AP.date <= all (Select date from appointment as ap2 where date >= (select CURDATE()) and Exists(select * from attends as att2 where att2.healthcare_id = AT.healthcare_id and att2.Employee_ID = ap2.Employee_ID and att2.Time = ap2.start_time and att2.Date = ap2.Date)) order by  AP.date, AP.start_time;";
			db.query(q, function (err, rows, fields) {
				if (err) {
			
						throw err;
					
				} else {
					console.log(rows);
					resolve({upcomings:rows});
				}
				//console.log("appt booked");
			});
			//resolve({val1:"dog", val2:"pie"});
		});
		return firstPromise;
	};
	
	var secondMethod = function(result){
		var secondPromise = new Promise((resolve, reject) => {
		console.log("RESULT: ");
		console.log(result.upcomings);
		var q = "Select * from appointment as AP, attends as AT, EMPLOYEE AS E, CONTACT_INFO AS C where AP.date = AT.date and AP.start_time = AT.time and AP.Employee_ID = AT.Employee_ID and AP.Employee_ID = E.Employee_ID and E.CI_ID = C.CI_ID and AT.Healthcare_ID in (SELECT healthcare_id from client_account where accountID =" + req.user.id + ") and AP.date < (select CURDATE()) and AP.Attendance_Status = 0 order by  AP.date, AP.start_time";
		db.query(q, function (err, rows, fields) {
			if (err) {
		
				throw err;
				
			} else {
				console.log(rows);
				resolve({upcomings:result.upcomings, misseds:rows, numMissed:rows.length});
			}
			//console.log("appt booked");
		});
		});
		return secondPromise;
	};
	
	var thirdMethod = function(result){
		var thirdPromise = new Promise((resolve, reject) => {
		console.log("RESULT: ");
		console.log(result.upcomings);
		var q = `SELECT PSCI.Title, PSCI.Fname, PSCI.Lname, A.Date,
A.Start_Time, A.Duration, A.Amount_owed, A.Amount_paid, A.Employee_ID,
A.Reason, A.Attendance_status, A.Amount_Paid, A.Amount_Owed,
A.Dr_notes, ATT.Healthcare_ID
FROM PSYCHOLOGIST as PS, PATIENT as PA, 
CONTACT_INFO AS PSCI, client_account as CA, EMPLOYEE as E, APPOINTMENT as A left outer join attends as ATT on (A.Employee_ID = ATT.Employee_ID and A.Start_time = ATT.Time and A.Date = ATT.Date)
WHERE PS.Employee_ID = A.Employee_ID AND PSCI.CI_ID = E.CI_ID and CA.healthcare_id = PA.health_care_id and E.Employee_ID = PS.Employee_ID and (PA.health_care_id = ATT.Healthcare_id or ATT.Healthcare_id is null)
AND
((CA.accountID = 5 AND EXISTS(
SELECT * FROM ATTENDS WHERE ATTENDS.Date = A.Date AND
ATTENDS.Time = A.Start_time AND ATTENDS.Employee_ID =
A.Employee_ID AND ATTENDS.Healthcare_ID =
PA.Health_care_ID))
OR NOT EXISTS (
SELECT * FROM ATTENDS WHERE ATTENDS.Date = A.Date AND
ATTENDS.Time = A.Start_time AND ATTENDS.Employee_ID =
A.Employee_ID))
AND A.Date >= (select curdate()) order by A.date, A.start_time;`

		db.query(q, function (err, rows, fields) {
			if (err) {
				throw err;
			} else {
				console.log(rows);
				resolve({upcomings:result.upcomings, misseds:result.misseds, numMissed:result.numMissed, availables:rows});
			}
			//console.log("appt booked");
		});
		});
		return thirdPromise;
	};
		
	firstMethod().then(secondMethod).then(thirdMethod).then(function(finalResult) {
		console.log(finalResult);
		res.render('appt_home', finalResult);
	});
	/*upcomingPromise.then(function(val) {
	});*/
});



router.post('/book_appt', ensureAuthenticated, function(req, res) {
	var date = req.query.year + "-" + req.query.month + "-" + req.query.day;
	var emp = req.query.empid;
	var time = req.query.time;
	console.log([emp, time, req.user.id]);
    
        var query = "INSERT INTO attends (Healthcare_ID, Employee_ID, Date, Time) VALUES ?;";
		var vals = [[11, emp, date, time]];
		console.log(query);
        db.query(query, [vals], function (err, result) {
            if (err) {
				if (err.code == 'ER_DUP_ENTRY') {
					var msg = "Error: Date '" + date + "' is already in use!";
					/* Might not be an error for key primary */
					if (err.message.indexOf("for key 'PRIMARY'") > 0) {
						msg = "Error: Time '" + time + "' is already in use!";
				}
				console.log("Dup appointment");
				req.flash('danger', msg);
				res.redirect('/appointment/book_appt');
               
				} else {
					console.log(db.sql);
					throw err;
				}
			} else {
                req.flash('success', 'Appointment booked');
                res.redirect('/appointment');
            }
            console.log("appt booked");
        });
   
});


router.get('/delete', ensureAuthenticated, function(req, res) {


	db.query("select * from medication", function(err, rows, fields) {
		if (err) {
			console.log("error in select * from medication, medication.js");
			throw err;
		}
		res.render('delete_medication', {title:'Enter the ID you\'d like to delete', medication:rows});
	});
});

/* View all medication in the table and remove by ID */
router.post("/delete", function(req, res) {
	const ID = req.body.ID;
	req.checkBody('ID', 'ID must match a current ID').notEmpty();
	
	var delQuery = "DELETE from MEDICATION where ID =" + ID;

	db.query("select * from medication where ID ="+ ID, function (err, rows, fields) {
		if (err) {
			console.log(err);
			throw err;
		} else {
			db.query(delQuery, function (err2, rows2, fields2) {
				if (err2) {
					console.log(err2);
				} else {
					req.flash('success', 'Medication removed');
					res.redirect('/');
				}
			});
		}
	});
});

function ensureAuthenticated(req, res, next) {
    if (req.isAuthenticated()) {
        return next();
    } else {
        req.flash('danger', 'Please Login');
        res.redirect('/users/login');
    }
}

module.exports = router;
