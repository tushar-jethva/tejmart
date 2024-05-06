const express = require('express');
const OrderModel = require('../models/order_model')
const CartModel = require('../models/cart_model')
const UserModel = require('../models/user_model');
const { ProductModel } = require('../models/product_model');
const OrderSellerModel = require('../models/order_seller');
const nodemailer = require("nodemailer");
const orderRouter = express.Router();

orderRouter.post("/api/placeOrder",async(req,res)=>{
    try{
        const{products,user_id,total_amount} = req.body;
        
        let user = await UserModel.findById(user_id);
        let b = user.a_balance - total_amount;
        let u1 = await UserModel.findByIdAndUpdate(user_id,{"a_balance":b},{new:true});
        
        let cartproducts = await CartModel.find({"user_id":user_id});
       

        let order = new OrderModel({
            products,
            user_id,
            total_amount,
            orderAt: new Date().getTime(),
        });
        
        order = await order.save();
        
        let order_id = order._id.toString();

        for(let i=0;i<products.length;i++){
            let product = await ProductModel.findById(products[i]);
            
            // console.log(product['sales_id']);
            let order_seller = new OrderSellerModel({
                order_id,
                user_id,
                product_id:products[i],
                seller_id:product['sales_id'],
                quantity_product:cartproducts[i]['quantity_product']
            });
            
            order_seller = await order_seller.save();
        }


        await CartModel.deleteMany({"user_id":user_id});        
        res.json(order);
    }
    catch(e){
        res.status(500).json({error:e.message});
    }
});

orderRouter.get("/api/getAllUserOrders",async(req,res)=>{
    let orders = await OrderModel.find({user_id:req.query.user_id});
    let order_products = [];

    for(let i=0;i<orders.length;i++){
        let order_id = orders[i]._id.toString();
        let quantity_product = await OrderSellerModel.find({"order_id":order_id});
        // console.log(quantity_product);
        let product_list = [];
        for(let j=0;j<orders[i]['products'].length;j++){
            let q1 = quantity_product[j]['quantity_product'];
            let status = quantity_product[j]['status'];
            let product = await ProductModel.findById(orders[i]['products'][j]);
            let m = {
                "product":product,
                "quantity_product":q1,
                "status":status
            }
            product_list.push(m);
            
        }
        let map = {
            "product":product_list,
            "total_amount":orders[i]['total_amount'],
            "orderAt":orders[i]['orderAt']
        }
        order_products.push(map);
    }

    res.json(order_products);
});

orderRouter.get("/api/getSalesOrders",async(req,res)=>{
    let orders = await OrderSellerModel.find({seller_id:req.query.seller_id,status:0});
    console.log(req.query.seller_id);
    let sellerProducts = [];
    for(let i=0;i<orders.length;i++){
        
            let product = await ProductModel.findById(orders[i]['product_id']);
            let map = {
                "product":product,
                "quantity_product":orders[i].quantity_product,
                "status":orders[i].status,
                "order_id":orders[i].order_id
            }
            sellerProducts.push(map);
        
    }
    res.json(sellerProducts);
});

orderRouter.get("/api/getCompletedOrder",async(req,res)=>{
    let orders = await OrderSellerModel.find({seller_id:req.query.seller_id,status:1});
    console.log(req.query.seller_id);
    let sellerProducts = [];
    console.log(orders)
    for(let i=0;i<orders.length;i++){
       
            let product = await ProductModel.findById(orders[i]['product_id']);
            let map = {
                "product":product,
                "quantity_product":orders[i].quantity_product,
                "status":orders[i].status,
                "order_id":orders[i].order_id
            }
            sellerProducts.push(map);
        
    }
    res.json(sellerProducts);
});

orderRouter.post("/api/mail",async(req,res)=>{
    try{
       const{receiveremail} = req.body;

        let sender = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: 'jethvatushar55@gmail.com',
                pass: '9978003090'
            }
        });

        let mail = {
            from: "jethvatushar87@gmail.com",
            to: receiveremail,
            subject: "Sending Email using Node.js",
            text: "That was easy!"
        };

        sender.sendMail(mail, function (error, info) {
            if (error) {
                console.log(error);
            } else {
                console.log("Email sent successfully: "
                    + info.response);
            }
            });

            res.json({"msg":"Hello"});
    }
    catch(e){
        res.status(500).json({error:e.message});
    }
});

orderRouter.post("/api/acceptOrder",async(req,res)=>{
    try{
        const{order_id,product_id} = req.body;
        const oneOrderProduct = await OrderSellerModel.findOneAndUpdate({"order_id":order_id,"product_id":product_id},{"status":1},{new:true});
        res.json(oneOrderProduct);

    }
    catch(e){
        res.status(500).json({error:e.message});

    }
})


orderRouter.post("/api/declineOrder",async(req,res)=>{
    try{
        const{order_id,product_id} = req.body;

        const oneOrderProduct = await OrderSellerModel.findOneAndUpdate({"order_id":order_id,"product_id":product_id},{"status":2},{new:true});
        res.json(oneOrderProduct);

    }
    catch(e){
        res.status(500).json({error:e.message});

    }
})


module.exports = orderRouter;