const express = require('express');
const {ProductModel} = require('../models/product_model');
const productRouter = express.Router();

productRouter.post('/api/addProduct',async(req,res)=>{
    try{
        const{sales_id,shop_name,name,price,category,discount,quantity,images,description} = req.body;
        
        let product = new ProductModel({
            sales_id,
            shop_name,
            name,
            price,
            category,
            discount,
            quantity,
            description,
            images
        });

        product = await product.save();
        res.json(product);

    }
    catch(e){
        return res.status(500).json({error:e.message});
    }
});

productRouter.get('/api/getAllProducts',async(req,res)=>{
    try{
        
        let products = await ProductModel.find({sales_id:req.query.sales_id});
        // console.log(req.query.sales_id)
        res.json(products);
        
    }
    catch(e){
        return res.status(500).json({error:e.message});
    }
});

productRouter.post('/api/deleteProduct',async(req,res)=>{
    try{
        
        const{product_id} = req.body;
        await ProductModel.findByIdAndDelete({_id:product_id});
        res.json("Product is deleted");
        
    }
    catch(e){
        return res.status(500).json({error:e.message});
    }
});

productRouter.get('/api/getCategoryProducts',async(req,res)=>{
    try{
        
        let category_products = await ProductModel.find({category:req.query.category});
        res.json(category_products);
    }
    catch(e){
        return res.status(500).json({error:e.message});
    }
});

productRouter.get('/api/getAllSalesmanWiseProducts',async(req,res)=>{
    try{

        let products = await ProductModel.find({"sales_id":req.query.sales_id})
        res.json(products);
    }
    catch(e){
        return res.status(500).json({error:e.message});

    }
});

productRouter.get('/api/getAllSystemProducts',async(req,res)=>{
    try{
        let product = await ProductModel.find({});
        res.json(product);
    }
    catch(e){
        return res.status(500).json({error:e.message});
        
    }
})



module.exports = productRouter;
