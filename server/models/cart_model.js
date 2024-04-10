const mongoose = require('mongoose');

const cartSchema =  mongoose.Schema({
    
    user_id:{
        required:true,
        type:String,
    },
    product_id:{
        required:true,
        type:String,
    },
    quantity_product:{
        required:true,
        type:Number
    }
});

const CartModel = mongoose.model("cart",cartSchema);
module.exports  = CartModel;