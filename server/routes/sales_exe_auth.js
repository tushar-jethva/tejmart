const express = require('express')
const salesExecutiveRouter = express.Router();
const bcryptjs = require('bcryptjs');
const SalesExecutiveModel = require('../models/sales_exe');

//SignUp
salesExecutiveRouter.post('/api/salessignup',async(req,res)=>{
    try{
        const{name,email,password,shop_name,mobile_no} = req.body;
        const existingUser = await SalesExecutiveModel.findOne({email});
        if(existingUser){
            return res.status(400).json({msg:"Executive with this email already exists!"});
        }
        const hashedPassword = await bcryptjs.hash(password, 8);
        let salesExecutive = new SalesExecutiveModel({
            name,
            email,
            password:hashedPassword,
            shop_name,
            mobile_no
        });

        salesExecutive = await salesExecutive.save();
        res.json(salesExecutive);
    }
    catch(e){
        return res.status(500).json({error:e.message})
    }
});

//SignIn
salesExecutiveRouter.post('/api/salessignin',async(req,res)=>{
    try{
        const{email,password} = req.body;
        const userExists = await SalesExecutiveModel.findOne({email})
        if(!userExists){
            return res.status(400).json({msg:"Executive with this email doesn't exists!"});
        }
        
        const isMatchPassword = await bcryptjs.compare(password,userExists.password);
        if (!isMatchPassword) {
            return res.status(400).json({msg: "Incorrect password." });
        }
        
        res.json(userExists);
    }
    catch(e){
        return res.status(500).json({error:e.message}); 
    }
})

module.exports = salesExecutiveRouter;