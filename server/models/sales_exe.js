const mongoose = require('mongoose');

const salesExecutiveSchmea = mongoose.Schema({
   
    name:{
        required:true,
        type:String
    },
    email:{
        required:true,
        type:String
    },
    password:{
        required:true,
        type:String
    },
    mobile_no:{
        required:true,
        type:String
    },
    shop_name:{
        required:true,
        type:String
    }

});

const SalesExecutiveModel = mongoose.model("SalesExecutive",salesExecutiveSchmea);
module.exports = SalesExecutiveModel;