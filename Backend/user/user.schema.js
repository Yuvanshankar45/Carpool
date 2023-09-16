const mongoose = require('mongoose');

// Define a schema
const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        unique: true,
        required: true
    },
    password: {
        type: String,
        required: true
    },
    phoneNumber: {
        type: String,
        unique: true,
        maxlength: [10, 'Invalid Phone Number'],
        required: true
    },
    address: {
        type: String,
        required: true
    },
    ethereumAddress:{
        type: String
    }

}, { timestamps: true });

// Create a model
module.exports.User = mongoose.model('User', userSchema);

// Now you can use the User model to interact with the 'users' collection
