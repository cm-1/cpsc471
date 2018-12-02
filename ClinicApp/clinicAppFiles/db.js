var mysql = require('mysql');
var pool;

function returnPool() {
	var p; //Replace this with your personal root password
	if(!p)
		console.log("=========\n\nERROR: Hey guys! You gotta set the password in db.js! :-) \n\n=================");
	if(!pool){
		pool  = mysql.createPool({
		  connectionLimit : 10,
		  host            : 'localhost',
		  user            : 'root',
		  password        : p, 
		  database        : 'clinicdb'
		});
	}
	return pool;
}

module.exports = returnPool();