const express = require('express')
const UserModel = require('../models/user_model')
const authRouter = express.Router()
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth')

let token = ""
//SignUp
authRouter.post('/api/signup',async(req,res)=>{
    try{
        const{name,email,password} = req.body;
        const existingUser = await UserModel.findOne({email});
        if(existingUser){
            return res.status(400).json({msg:"User with this email already exists!"});
        }
        const hashedPassword = await bcryptjs.hash(password, 8);
        let user = new UserModel({
            name,
            email,
            password:hashedPassword
        });

        user = await user.save();
        res.json(user);
    }
    catch(e){
        return res.status(500).json({error:e.message})
    }
});

//SignIn
authRouter.post('/api/signin',async(req,res)=>{
    try{
        const{email,password} = req.body;
        const userExists = await UserModel.findOne({email})
        if(!userExists){
            return res.status(400).json({msg:"User with this email doesn't exists!"});
        }
        
        const isMatchPassword = await bcryptjs.compare(password,userExists.password);
        if (!isMatchPassword) {
            return res.status(400).json({msg: "Incorrect password." });
        }
        
        const token = jwt.sign({ id: userExists._id }, "passwordKey");
        res.json({token,...userExists._doc});
    }
    catch(e){
        return res.status(500).json({error:e.message}); 
    }
});

//token verification
authRouter.post("/api/tokenIsValid",async(req,res)=>{
    try{
      const token = req.header("x-auth-token");
      if(!token) return res.json(false);
      const verified = jwt.verify(token,"passwordKey");
      if(!verified) return res.json(false);
      token = req.token;
      const user = UserModel.findById(verified.id);
      if(!user) return res.json(false);
      res.json(true);
    }
    catch(e){
      res.status(500).json({error:e.message});
    }
  });
  
  //get user data
  authRouter.get("/",auth, async(req,res)=>{
    const user = await UserModel.findById(req.user);
  
    res.json({...user._doc,token:req.token});
  });

  authRouter.get("/api/getUser",async(req,res)=>{
    try{
        const user = await UserModel.findById(req.query.user_id);
        res.json(user);
    }
    catch(e){
        res.status(500).json({error:e.message});

    }
  })

  authRouter.post("/api/addAddressAndMobile",async(req,res)=>{
    try{
        const{address,mobile_no,user_id} = req.body;
        let user = await UserModel.findByIdAndUpdate(user_id,{"address":address,"mobile_no":mobile_no},{new:true});
        res.json({...user._doc,token});
    }
    catch(e){
        res.status(500).json({error:e.message});
    }
  });

  authRouter.post("/api/addAmount",async(req,res)=>{
    try{
        const{amount,user_id} = req.body;
        console.log(amount);
        let user = await UserModel.findById(user_id);
        let a_balance = +user.a_balance + amount;
        let u1 = await UserModel.findByIdAndUpdate(user_id,{"a_balance":a_balance},{new:true})
        res.json({...u1._doc,token});
    }
    catch(e){
        res.status(500).json({error:e.message});
        
    }
  })

module.exports = authRouter;