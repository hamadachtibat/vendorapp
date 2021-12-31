import 'dart:io';

import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/providers/auth_provider.dart';
import 'package:desktop_vendorapp/screens/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';


class RegistreForm extends StatefulWidget {
   const RegistreForm({Key? key}) : super(key: key);


  _RegistreFormState createState() => _RegistreFormState();

}

class _RegistreFormState extends State<RegistreForm> {
  final _formKey = GlobalKey<FormState>();
  final _namecontroller = TextEditingController();

  final _emailcontroller  = TextEditingController();
  final _paswordcontroller = TextEditingController();
  final _cpaswordcontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  String ?email;
  String ?password;
  String ?shopname;
  String ?phonenumber;
  bool isloading=false;

  @override
  Widget build(BuildContext context) {
    final _authData= Provider.of<AuthProvider>(context);
    return isloading?const Center(child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
    ),):
    Form(
      key: _formKey,
      child: SingleChildScrollView(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter shop name";

                  }
                  setState(() {
                    _namecontroller.text = value;
                  });
                  setState(() {
                    shopname=value;
                  });
                  return null;

                },
                decoration:  InputDecoration(
                  prefixIcon: const Icon(Icons.add_business),
                  labelText: Languages.of(context)!.desktopName,
                  labelStyle: TextStyle(
                    fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                    'Cairo' : 'Nunito',
                  ),
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2,
                        color: Colors.green),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2,
                        color: Colors.green),
                  ),
                  focusColor: Colors.green,

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value!.isEmpty){
                    return "Phone number";

                  }
                  setState(() {
                    phonenumber=value;
                  });

                  return null;

                },
                decoration:  InputDecoration(
                  prefixIcon: const Icon(Icons.phone_android),
                  prefixText: '+968',
                  labelText: Languages.of(context)!.addyourPhoneNumber,
                  labelStyle: TextStyle(
                    fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                    'Cairo' : 'Nunito',
                  ),
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2,
                        color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2,
                        color: Colors.green),
                  ),
                  focusColor: Colors.green,

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailcontroller,
                validator: (value){
                  if(value!.isEmpty){
                    return "Email";
                  }
                  final bool _isvalidate =
                  EmailValidator.validate(_emailcontroller.text);
                  if(!_isvalidate){
                    return 'Invalid Email format';
                  }
                  setState(() {
                    email=value;
                  });

                  return null;


                },
                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: Languages.of(context)!.email,
                  labelStyle: TextStyle(
                    fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                    'Cairo' : 'Nunito',
                  ),
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2,
                        color: Colors.green),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2,
                        color: Colors.green),
                  ),
                  focusColor: Colors.green,

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _paswordcontroller,
                obscureText: true,
                validator: (value){
                  if(value!.isEmpty){
                    return "Password";

                  }if(value.length<6){
                    return "Minimum 6 digits";
                  }

                  setState(() {
                    password=value;
                  });
                  return null;

                },
                decoration:  InputDecoration(
                  prefixIcon: const Icon(Icons.vpn_key_outlined),
                  labelText: Languages.of(context)!.password,
                  labelStyle: TextStyle(
                    fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                    'Cairo' : 'Nunito',
                  ),
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2,
                        color: Colors.green),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2,
                        color: Colors.green),
                  ),
                  focusColor: Colors.green,

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _cpaswordcontroller,
                obscureText: true,
                validator: (value){
                  if(value!.isEmpty){
                    return "Confirm Password";

                  }if(value.length<6){
                    return "Minimum 6 digits";
                  }
                  if(_paswordcontroller.text!=_cpaswordcontroller.text){

                    return 'Not Match';
                  }
                  return null;

                },
                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                  labelText: Languages.of(context)!.password,
                  labelStyle: TextStyle(
                    fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                    'Cairo' : 'Nunito',
                  ),
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2,
                        color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2,
                        color: Colors.green),
                  ),
                  focusColor: Colors.green,

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _addresscontroller,
                maxLines: 4,
                validator: (value){
                  if(value!.isEmpty){
                    return "Add Location press icon";

                  } if(_authData.shoplaltitude==null){
                    return 'add Location press icon';
                  }
                  return null;

                },
                decoration:  InputDecoration(
                  prefixIcon: const Icon(
                      Icons.location_on),
                  suffixIcon: IconButton(
                      onPressed: (){
                        _addresscontroller.text=
                        'locating... \n please wait';
                        _authData.getCurrentLocation().then(
                                (address){
                                  if(address!=null){
                                    setState(() {
                                      _addresscontroller.text=
                                      '${_authData.placename} \n ${_authData.shopaddress}';
                                    });
                                  }else{ScaffoldMessenger.of(context).
                                  showSnackBar(
                                      const SnackBar(content: Text("Couldn't find your location")));}

                                });
                      },
                    icon:const Icon(Icons.add_location_alt_outlined), ),
                  labelText: Languages.of(context)!.confirmlocation,
                  labelStyle: TextStyle(
                    fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                    'Cairo' : 'Nunito',
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2,
                        color: Colors.green),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2,
                        color: Colors.green),
                  ),
                  focusColor: Colors.green,

                ),
              ),
            ),
            Row(
              children: [
                Expanded(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(onPressed: (){
                      if(_authData.ispickava==true){
                        if(_formKey.currentState!.validate()){
                         setState(() {
                           isloading=true;
                         });
                          _authData.RegistreVendor(email, password).then((cred){
                          if(cred!.user!.uid!=null){
                           uploadFile(_authData.picture).then((url)  {
                             if(url!=null){
                               _authData.SaveVendorData(
                                url: url,
                                phonenumber: phonenumber,
                                shopname: shopname,
                              );
                               setState(() {

                                 isloading=false;
                               });
                               Navigator.pushReplacementNamed(context, HomeScreen.id);
                             }else{
                               ScaffoldMessenger.of(context).
                               showSnackBar(
                                   const SnackBar(content: Text("failed to upload picture")));
                             }
                           });
                          }else{
                            ScaffoldMessenger.of(context).
                            showSnackBar(
                                const SnackBar(content: Text("registration failed ,plz repeat")));
                          }
                          });
                          ScaffoldMessenger.of(context).
                          showSnackBar(
                               SnackBar(content: Text(Languages.of(context)!.buildingAccount,
                                 style:TextStyle(fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                 'Cairo' : 'Nunito',)

                                 ),));
                        }
                      }else{
                        ScaffoldMessenger.of(context).
                        showSnackBar(
                            const SnackBar(content: Text("Please add picture")));
                      }

                    }, child:
                     Text(Languages.of(context)!.registre,style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.bold,
                       fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                       'Cairo' : 'Nunito',
                     ),),
                    color: Colors.green,),
                  ),
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
  Future<String> uploadFile(String filePath) async {
    File file = File(filePath);
   FirebaseStorage firebaseStorage=  FirebaseStorage.instance;
    try {
       await firebaseStorage.ref('uploads/shopname/${_namecontroller.text}').putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);

    }
    String downloadURL = await firebaseStorage.ref('uploads/shopname/${_namecontroller.text}').getDownloadURL();
    return downloadURL ;
  }
}
