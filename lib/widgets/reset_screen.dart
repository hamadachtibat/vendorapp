import 'package:desktop_vendorapp/providers/auth_provider.dart';
import 'package:desktop_vendorapp/screens/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);
  static const String id='reset-screen';

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailcontroller=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String ?email;
  bool _loading=false;
  @override
  Widget build(BuildContext context) {
    final _authData=Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("images/man-forgot.jpeg"),
              SizedBox(height: 10,),
              TextFormField(
                controller: _emailcontroller,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter your Email';
                  } final bool _isvalidate =
                  EmailValidator.validate(_emailcontroller.text);
                  if(!_isvalidate){
                    return 'Invalid Email format';
                  }
                  setState(() {
                    email=value;
                  });
                  return null;
                },

                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),

                    ),
                    enabledBorder: OutlineInputBorder(

                    ),

                    contentPadding: EdgeInsets.zero,
                    hintText: 'enter your email to reset your password',

                    prefixIcon: Icon(Icons.email),
                    focusColor: Colors.green
                ),
              ),
              const SizedBox(height: 20,),
              FlatButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      _loading=true;
                    });
                    _authData.ResetpassVendor(email);
                    Navigator.pushReplacementNamed(context, LoginScreen.id);
                  }

                },
                color: Colors.green,
                child: _loading? LinearProgressIndicator(color: Colors.indigo,) :
                Text('Reset your password'),
              )
            ],
          ),
        ),),
      ),
    );
  }
}
