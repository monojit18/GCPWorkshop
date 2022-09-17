const express = require('express');
const app = express();

app.get('/cr', (req, res) => {
  // const dt = new Date().toLocaleString("en-IN", {timeZone: "Asia/Kolkata"});
  
  let dt = new Date();
  dt = new Date(dt.setDate(dt.getDate() + 1)).toLocaleString("en-IN", {timeZone: "Asia/Kolkata"});
  
  res.send(`Hello from Cloudrun - ${dt}!`);
});

const port = parseInt(process.env.PORT) || 8080;
app.listen(port, () => {
  console.log(`helloworld: listening on port ${port}`);
});
