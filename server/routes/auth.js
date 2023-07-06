const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");

const authRouter = express.Router();

// SIGN UP
authRouter.post("/api/signup", async (req, res) => {
  console.log(req.body);
  // get the data from client
  try {
    const { name, email, password } = req.body;
    // post that data in database

    //It's a promise
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!!!" });
    }
    //status code : 200
    // check validation like weak-password - 6 characters, same-account-with-email

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password : hashedPassword,
      name,
    });

    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
  // _v
  // id
  // return that data to the user
});

// it is not private. It can be used anywhere
module.exports = authRouter;
