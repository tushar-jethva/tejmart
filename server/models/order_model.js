const mongoose = require('mongoose');

const OrderSchema = mongoose.Schema({
    
    user_id:{
        type:String,
        required:true
    },
    total_amount:{
        type:Number,
        required:true,
    },
    products:[
        {
            type:String,
            required:true
        }
    ],
    orderAt:{
        type:Number,
        required:true,
    },
});

const OrderModel = mongoose.model("order",OrderSchema);
module.exports = OrderModel;