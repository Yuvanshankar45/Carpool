const { User } = require("./user.schema.js");
const bcrypt = require("bcryptjs");
const { sign, verify } = require("jsonwebtoken");
const ethers = require('ethers');

module.exports = {
    createUser: async (req, res) => {
        try {
            const payload = req.body;
            // Generate a salt
            const salt = await bcrypt.genSalt(10);
            // Hash the password with the generated salt
            const hash = await bcrypt.hash(payload.password, salt);
            payload["password"] = hash;
            const wallet = ethers.Wallet.createRandom();
            const ethereumAddress = wallet.address;
            const newUser = new User({
                name: payload.name,
                email: payload.email,
                password: payload.password,
                phoneNumber: payload.phoneNumber,
                address: payload.address,
                ethereumAddress: ethereumAddress
            });
            const repsonse = await newUser.save()
            return res.status(201).json({ success: true, data: repsonse })
        }
        catch (error) {
            return res.status(500).json({ success: false, error: error })
        }
    },

    loginUser: async (req, res) => {
        const payload = req.body;
        let filter;
        if (payload.email)
            filter = { email: payload.email };
        if (payload.phoneNumber)
            filter = { phoneNumber: payload.phoneNumber };
        const user = await User.findOne(filter);
        if (!user) {
            return res.status(400).json({ success: false, error: "User no found with email or password" })
        }
        const passwordMatch = await bcrypt.compare(
            payload.password,
            user.password
        );
        if (!passwordMatch) {
            return res.status(400).json({ success: false, error: "User no found with email or password" })
        }
        const accessToken = sign(
            { email: user.email, userId: user._id, phoneNumber: user.phoneNumber },
            process.env.ACCESS_JWT_KEY,
            { expiresIn: process.env.EXPIRY_JWT }
        );
        return res.status(200).json({ success: true, data: { accessToken: accessToken } })
    },
}