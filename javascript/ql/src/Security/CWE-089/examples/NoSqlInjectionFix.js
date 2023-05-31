const express = require("express");
const mongoose = require("mongoose");
const Todo = mongoose.model(
  "Todo",
  new mongoose.Schema({ text: { type: String } }, { timestamps: true })
);

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.delete("/api/delete", async (req, res) => {
  let id = req.body.id;
  await Todo.deleteOne({ _id: { $eq: id } }); // GOOD: using $eq operator for the comparison

  res.json({ status: "ok" });
});