//Imports from packages
const express = require('express')
const mongoose = require('mongoose')

//Imports from other files
const authRouter = require('./routes/auth_router')
const productRouter = require('./routes/product_router')
const salesExecutiveRouter = require('./routes/sales_exe_auth');
const cartRouter = require('./routes/cart_router');
const orderRouter = require('./routes/order_router');
const wishListRouter = require('./routes/wishlist_router');

//constants
const DB = "mongodb://127.0.0.1:27017/TEJMART?directConnection=true&serverSelectionTimeoutMS=2000"
const PORT = 3000;

//define
const app = express();

//middleware
app.use(express.json())
app.use(authRouter)
app.use(salesExecutiveRouter)
app.use(productRouter)
app.use(cartRouter)
app.use(orderRouter)
app.use(wishListRouter)


//apis
app.get("/",(req,res)=>{
    res.send("Welcome to TEJMART!")
})


//connections
mongoose.connect(DB).then(()=>{
    console.log("Databse connected!")
}).catch((err)=>{
    console.log(err)
})

app.listen(PORT,"0.0.0.0",(req,res)=>{
    console.log("You are connected with port "+PORT)
})