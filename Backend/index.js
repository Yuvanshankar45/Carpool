
const express = require('express')
const app =express();
const mongoose = require('mongoose');
const cors = require('cors')
const UserContoller = require('./user/user.controller')
require('dotenv').config();
const port = process.env.PORT || 4000;

app.use(cors({ origin: "*" }));
app.use(express.json());
// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})
    .then(() => {
        console.log('Connected to MongoDB');

        // Now you can define and perform operations on your models
    })
    .catch((error) => {
        console.error('Error connecting to MongoDB:', error);
    });

//routes
app.use('/api/user',UserContoller)

app.listen(port, () => {
    console.log(`Server listening on Port ${port}`)
})

