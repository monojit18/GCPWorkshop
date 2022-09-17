'use strict';

const express = require('express');
const app = express();

app.get('/date', (req, res) => {
  const dt = new Date().toLocaleDateString("en-IN", {timeZone: "Asia/Kolkata"});
  const msg = `Hello from Node - ${dt}\n`; 
  res.status(200).send(msg).end();
});

const PORT = parseInt(process.env.PORT) || 8080;
app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}`);
  console.log('Press Ctrl+C to quit.');
});

module.exports = app;
