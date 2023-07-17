const sql = require("mssql");
const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

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
    const { name, rollNo, clz } = req.body;
    const pool = await sql.connect(config);

    const query = `INSERT INTO form_tbl (name, rollNo, clz) VALUES (@name, @rollNo, @clz)`;
    await pool
      .request()
      .input("name", sql.VarChar, name)
      .input("rollNo", sql.VarChar, rollNo)
      .input("clz", sql.VarChar, clz)
      .query(query);

    console.log("Form data inserted successfully");
    res.sendStatus(200);

    await sql.close(); // Close the connection
  } catch (err) {
    console.error("Error executing query:", err);
    res.sendStatus(500);
  }
});

const port = 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
