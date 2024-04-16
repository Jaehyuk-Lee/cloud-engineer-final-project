const express = require('express');
const app = express();
const mysql = require('mysql2');

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET,POST');
  res.header('Access-Control-Allow-Headers',
  'Origin,Accept,X-Requested-With,Content-Type,Access-Control-Request-Method,Access-Control-Request-Headers,Authorization');
  next();
});

app.get('/', (req, res) => {
  // create the connection to database
  const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'wbdb'
  });

  // simple query
  connection.query(
    'SELECT * FROM mydb1',
    function(err, results, fields) {
      console.log(results); // results contains rows returned by server
      console.log(fields); // fields contains extra meta data about results, if available

      res.send(results);
      res.status(200).end();
    }
  );
  connection.end();
});

app.listen(8000);
console.log("Listening to port 8000");
