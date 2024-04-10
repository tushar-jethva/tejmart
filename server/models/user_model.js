const mongoose = require('mongoose')
const {productSchema} = require('./product_model');

const userSchema = mongoose.Schema({

    name:{
        required:true,
        type:String
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
          validator: (value) => {
            console.log(value);
            const re =
              /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
            return value.match(re);
          },
          message: "Please enter a valid email address",
        },
      },
    password:{
        required:true,
        type:String
    },
    mobile_no:{
        default:"",
        type:String
    },
    address:{
        default:"",
        type:String
    },
    type:{
        default:"customer",
        type:String
    },
    a_balance:{
        default:100,
        type:Number
    }        
});

const UserModel = mongoose.model("Users",userSchema);
module.exports = UserModel;