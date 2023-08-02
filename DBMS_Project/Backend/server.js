const sql = require("mssql");
const express = require("express"); //handling HTTP requests and responses,
const cors = require("cors");//cross origin resource sharing

const app = express();
app.use(cors());
app.use(express.json());

//config object to store connection details for connecting to ms sql db
const config = {
  user: "SA",
  password: "@BeingodockeR7",
  server: "localhost",
  database: "form_db",
  port: 1433,
  options: {
    encrypt: false,
  },
};

app.post("/submit-form", async (req, res) => {
  try {
    const { name, rollNo, clz } = req.body; //retrieves JSON data sent from client side
    const pool = await sql.connect(config); //connect to db

    //SQL query to insert the form data into the database
    const query = `INSERT INTO form_tbl (name, rollNo, clz) VALUES (@name, @rollNo, @clz)`;
    await pool
      .request()
      .input("name", sql.VarChar, name) //line 23 maa we retrieved data into name,rollNo,clz and we use those here.
      .input("rollNo", sql.VarChar, rollNo)
      .input("clz", sql.VarChar, clz)
      .query(query);

    console.log("Form data inserted successfully");
    res.sendStatus(200); // Send a success status response to the client

    await sql.close(); // Close the connection
  } catch (err) {
    console.error("Error executing query:", err);
    res.sendStatus(500);
  }
});
//server will listen for incoming HTTP requests on port 3000. 
const port = 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
