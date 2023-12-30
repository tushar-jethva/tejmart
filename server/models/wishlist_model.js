const mongoose = require('mongoose')

const wishListSchema =  mongoose.Schema({
    
    user_id:{
        required:true,
        type:String,
    },
    product_id:{
        required:true,
        type:String,
    }
   
});

const WishListModel = mongoose.model("wishlist",wishListSchema);
module.exports  = WishListModel;