const mongoose = require('mongoose')

const productSchema = mongoose.Schema({
    sales_id:{
        required:true,
        type:String,
    },
    shop_name:{
        required:true,
        type:String,
    },
    name:{
        required:true,
        type:String,
    },
    description:{
        required:true,
        type:String
    },
    price:{
        required:true,
        type:Number,
    },
    category:{
        required:true,
        type:String,
    },
    discount:{
        default:0,
        type:Number,
    },
    quantity:{
        required:true,
        type:Number,
    },
    images:[
        {
            type:String,
            required:true,
        }
    ]
});

const ProductModel = mongoose.model("Products",productSchema);
module.exports = {ProductModel,productSchema};
