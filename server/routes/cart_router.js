const express = require('express');
const cartRouter = express.Router();
const CartModel = require('../models/cart_model');
const { ProductModel } = require('../models/product_model');

cartRouter.post('/api/addCartProduct',async(req,res)=>{
    try{
        const{user_id,product_id,quantity_product} = req.body;
        
        let isExist = await CartModel.findOne({product_id:product_id,user_id:user_id});
        if(isExist){
            let num = isExist.quantity_product;
            
            isExist =  await CartModel.findOneAndUpdate({product_id:product_id,user_id:user_id},{"quantity_product":num+quantity_product},{new:true});
            return res.json(isExist);
        }
        // console.log(isExist);

        let cart = new CartModel(
            {
            user_id,
            product_id,
            quantity_product
        }
        );

        cart = await cart.save();
        res.json(cart);
    }
    catch(e){
        return res.status(500).json({error:e.message});
    }
});

cartRouter.get('/api/incrementQuantity',async(req,res)=>{
    try{

    let product = await CartModel.findOne({"product_id":req.query.product_id});
   
    product.quantity_product++;

    await product.save();
    }
    catch(e){
        return res.status(500).json({error:e.message});
    }
});

cartRouter.get('/api/decrementQuantity',async(req,res)=>{
    try{
    let product = await CartModel.findOne({"product_id":req.query.product_id});
    product.quantity_product--;
    await product.save();
    }
    catch(e){
        return res.status(500).json({error:e.message});
    }
});

cartRouter.get('/api/getAllCustomerCartProducts',async(req,res)=>{
    try{
        let products = await CartModel.find({"user_id":req.query.user_id});
        
        let arr = [];
        for(let i=0;i<products.length;i++){
            let p1 = await ProductModel.findById(products[i].product_id);
            let map = {
                "product":p1,
                "quantity_product":products[i].quantity_product
            }
            arr.push(map);
        }
        
        res.json(arr);
    }
    catch(e){
        return res.status(500).json({error:e.message});
    }
});

cartRouter.get('/api/deleteFromCart',async(req,res)=>{
    try{
        await CartModel.findOneAndDelete({"product_id":req.query.product_id});
    }
    catch(e){
        return res.status(500).json({error:e.message});
    }
});

module.exports = cartRouter;