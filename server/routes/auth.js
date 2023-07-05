const express = require("express");
const User = require("../models/user");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  console.log(req.body);
  // get the data from client
  const { name, email, password } = req.body;
  // post that data in database

  //It's a promise
  const existingUser = await User.findOne({ email });
  if (existingUser) {
    return res.status().json({ msg: "User with same email already exists!!!" });
  }

  //status code : 200
  // check validation like weak-password - 6 characters, same-account-with-email
  // return that data to the user
});

// it is not private. It can be used anywhere
module.exports = authRouter;
