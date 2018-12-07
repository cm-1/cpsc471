const express = require('express');
const path = require('path');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const passport = require('passport');

var db = require('./db');

const expressValidator = require('express-validator');
const { check, validationResult } = require('express-validator/check');
const { matchedData, sanitize } = require('express-validator/filter'); 

const flash = require('connect-flash');
const session = require('express-session');



//init app
const app = express();

//Body parser middleware
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json())

//Tell express about the static "./Public" folder.
//__dirname refers to the current directory
app.use(express.static(path.join(__dirname, 'public')));



// ! ! ! !
// Look up why this is important, i.e. what it does!
// ! ! ! !
app.use(session({
	secret: 'keyboard cat', //Some default
	resave: true, //Needed for the messages/flash/alerts to show up!
	saveUninitialized: true
}));

//Passport Config
require('./config/passport')(passport);
app.use(passport.initialize());
app.use(passport.session());


app.use(expressValidator());

// ! ! ! !
// Look up why this is important, i.e. what it does!
// ! ! ! !
app.use(require('connect-flash')());
app.use(function (req, res, next){
	//Basically sets a global variable named "messages" to the express messages module
	res.locals.messages = require('express-messages')(req, res);
	next();
});



app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

//! ! ! What does this do, exactly?
app.get('*', function(req, res, next){
	//console.log(res);
	res.locals.user = req.user || null;
	if (req.url === '/users/register' || req.url === '/users/login'){
		console.log("Seems to get caught!");
		next();
	} else if (req.user){
		next();
	}
	else {
		req.flash('warning', 'Please log in to your account.');
		res.redirect('/users/login');
	}
});

app.get('/', function(req, res){
	//Gets the article table in JSON format.
	// "rows" is, predictably, the actual data
	console.log("Before insert...");
	
	res.render('index');
	console.log("...after insert.");
});

let articles = require('./routes/articles');
app.use('/articles', articles);

let users = require('./routes/users');
app.use('/users', users);

let medication = require('./routes/medication');
app.use('/medications', medication);

let myinfo = require('./routes/myinfo');
app.use('/myinfo', myinfo);

let survey = require('./routes/survey');
app.use('/survey', survey);


app.listen(3000, function(){
	console.log("Server started on port 3000...");
});
