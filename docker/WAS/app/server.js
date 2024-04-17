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
  console.log("name: " + req.query.name);

  // create the connection to database
  const connection = mysql.createConnection({
    host: '192.168.111.31',
    user: 'myuser',
    password: 'mypassword!',
    database: 'wbdb'
  });

  connection.query(
    `SELECT * FROM mydb1 WHERE 지역 = '${req.query.name}'`,
    function(err, results, fields) {
      console.log(results);
      console.log(fields);

      res.send(results);
      res.status(200).end();
    }
  );
  connection.end();
});

app.listen(3000);
console.log("Listening to port 3000");
