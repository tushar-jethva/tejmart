const express = require('express')
const wishListRouter = express.Router();
const WishListModel = require('../models/wishlist_model');
const { ProductModel } = require('../models/product_model');


wishListRouter.post("/api/addToWishlist",async(req,res)=>{
    try{
        const{product_id,user_id} = req.body;

        const isExist = await WishListModel.findOne({"user_id":user_id,"product_id":product_id});
        if(!isExist){
            let wishProduct = new WishListModel({
                user_id,
                product_id
            });
    
            wishProduct = await wishProduct.save();
            res.json({"message":"product is added"});
        }
        else{
            res.json({"message":"Already in wishlist!"});
        }
        
    }
    catch(e){
        res.status(500).json({error:e.message})
    }
});

wishListRouter.get("/api/getWishListProducts",async(req,res)=>{
    try{
        let products = await WishListModel.find({"user_id":req.query.user_id});
        console.log(products);
        let wishListProducts = [];

        for(let i=0;i<products.length;i++){
            let p = await ProductModel.findById(products[i]['product_id']);
            wishListProducts.push(p);
        }

        res.json(wishListProducts);

    }
    catch(e){
        res.status(500).json({error:e.message})
    }
});

wishListRouter.post("/api/deleteWishListProducts",async(req,res)=>{
    try{
        const{user_id,product_id} = req.body;
        await WishListModel.findOneAndDelete({ user_id, product_id })
        res.json({"message":"product is removed from wishlist"});
    }
    catch(e){
        res.status(500).json({error:e.message})
    }
});

wishListRouter.get("/api/isWishlisted",async(req,res)=>{
    try{
        const isExist = await WishListModel.findOne({"user_id":req.query.user_id,"product_id":req.query.product_id});
        if(isExist){
            res.json({"isLiked":true});
        }
        else{
            res.json({"isLiked":false})
        }
    }
    catch(e){
        res.status(500).json({error:e.message})
    }
})

module.exports = wishListRouter;
