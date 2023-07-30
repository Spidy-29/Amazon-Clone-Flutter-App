// IMPORTS FORM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
require('dotenv').config();
// import 'package:express/express.dart'

// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
// import './feature/auth/screens/auth_screen.dart'

// INIT
const PORT = process.env.PORT || 3000;
const app = express();
const DB = process.env.DB_URL;

// middleware
// CLIENT -> middleware -> SERVER -> CLIENT
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

//CREATING AN API
//http://<youripaddress>/hello-world

// GET, PUT, POST, DELETE, UPDATE --> CRUD

//connect with any address
app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT} `);
});
// localhost
