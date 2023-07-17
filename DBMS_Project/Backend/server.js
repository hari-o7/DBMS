const { Client } = require("pg");

const express = require("express");
const app = express();


// Database connection details
const connectionString = "postgres://wfeqgjvl:v11R8OryXqB0d0FMWkcwvpoeJ4oXskJ4@hansken.db.elephantsql.com/wfeqgjvl";
const client = new Client({
  connectionString: connectionString,
});

// Connect to the database
client.connect();

//try
app.get("/", (req, res) => {
  res.send("Hello World");
});



// Handle form submission
app.post("/submit-form", (req, res) => {
  console.log("POST request received on /submit-form endpoint");
    const { name, rollNo, clz } = req.body;
    // SQL query to insert form data into the table 'form_data'
  const query = "INSERT INTO form_data (name, rollNo, clz) VALUES ($1, $2, $3)";
  const values = [name, rollNo, clz];

  // Execute the SQL query to insert form data
  client.query(query, values, (err, result) => {
    if (err) {
      console.error("Error executing query:", err);
      res.sendStatus(500);
    } else {
      console.log("Form data inserted successfully");
      res.sendStatus(200);
    }
  });
});

// Start the server
const port = 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
