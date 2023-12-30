const mongoose = require('mongoose');

const OrderSeller = mongoose.Schema({
   order_id:{
    required:true,
    type:String,
   },
    user_id:{
        required:true,
        type:String
    },
    product_id:{
        required:true,
        type:String
    },
    seller_id:{
        required:true,
        type:String
    },
    quantity_product:{
        required:true,
        type:Number
    },
    status:{
        default:0,
        type:Number
    }
});

const OrderSellerModel = mongoose.model("orderseller",OrderSeller);
module.exports = OrderSellerModel;