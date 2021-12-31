import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/localization/language_data.dart';
import 'package:desktop_vendorapp/localization/locale_constant.dart';
import 'package:desktop_vendorapp/providers/auth_provider.dart';
import 'package:desktop_vendorapp/screens/home_screen.dart';
import 'package:desktop_vendorapp/screens/registre_screen.dart';
import 'package:desktop_vendorapp/widgets/reset_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id='login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  Icon ?icon;
  bool _visible=false;
  final _formKey=GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  String ?email;
  String ?password;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    final _authdata=Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _createLanguageDropDown(),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         Text(Languages.of(context)!.login
                          ,style: TextStyle(fontSize: 25,
                               fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                               'Cairo' : 'Nunito'),),
                        const SizedBox(width: 20,),
                        Image.asset('images/logo.png',height: 80,),

                      ],
                    ),
                    const SizedBox(height: 20,),
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

                      decoration:  InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),

                        ),
                        enabledBorder: OutlineInputBorder(

                        ),

                        contentPadding: EdgeInsets.zero,
                        hintText: Languages.of(context)!.email,
                        hintStyle: TextStyle(
                            fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                            'Cairo' : 'Nunito'),

                        prefixIcon: Icon(Icons.email),
                        focusColor: Colors.green
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'enter your password';
                        }
                        setState(() {
                          password=value;
                        });
                        return null;
                      },
                      controller: _passwordcontroller,
                      obscureText: _visible==false? true:false,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon:Icon(
                                _visible?Icons.remove_red_eye_outlined : Icons.visibility_off),
                        onPressed: (){
                              setState(() {
                                _visible=!_visible;
                              });
                        },),
                        focusedBorder: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        focusColor: Colors.green,
                        contentPadding: EdgeInsets.zero,
                        hintText: Languages.of(context)!.password,
                        hintStyle: TextStyle(
                            fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                            'Cairo' : 'Nunito'),
                        prefixIcon: Icon(Icons.vpn_key_outlined),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                             Navigator.pushNamed(context, ResetPassword.id);
                          },
                          child:  Text(Languages.of(context)!.forgotPassword,textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                                fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                'Cairo' : 'Nunito'),),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(

                          child: FlatButton(
                            color: Colors.green,
                              onPressed: (){
                              if(_formKey.currentState!.validate()){
                                setState(() {
                                  loading=true;
                                });
                                _authdata.LoginVendor(email,
                                    password).then((cred){
                                      if(cred!=null){
                                        setState(() {
                                          loading=false;
                                        });
                                        Navigator.
                                        pushReplacementNamed(context, HomeScreen.id);
                                      }else{
                                        setState(() {
                                          loading=false;
                                        });
                                        return ScaffoldMessenger.of(context).
                                        showSnackBar( SnackBar(
                                          content: Text(_authdata.error),
                                        ),);
                                      }
                                });
                              }else{
                                setState(() {
                                  loading=false;
                                });
                                ScaffoldMessenger.of(context).
                                showSnackBar(const SnackBar(
                                  content: Text('login failed plz repeat'),
                                ),);
                              }

                              },
                              child: loading?const LinearProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                              ):  Text(Languages.of(context)!.login,style: TextStyle(
                                fontWeight: FontWeight.bold,fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                              'Cairo' : 'Nunito'
                              ),),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, RegistreScreen.id);
                          },
                            child:RichText(text: TextSpan(
                              text:'',
                              children: [
                                TextSpan(text: Languages.of(context)!.dontHaveAccount,
                                  style: TextStyle(
                              color: Colors.black,fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                'Cairo' : 'Nunito'

                                ),
                              ),
                                TextSpan(text:Languages.of(context)!.registre,style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                    fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                    'Cairo' : 'Nunito'
                                )),
                              ]
                            )),

                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  _createLanguageDropDown() {
    return DropdownButton<LanguageData>(
      iconSize: 30,
      hint: Text(Languages
          .of(context)!
          .labelSelectLanguage,style: TextStyle(color: Colors.deepOrange,
          fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
          'Cairo' : 'Nunito'),),
      onChanged: (LanguageData ?language) {
        changeLanguage(context, language!.languageCode);
      },

      items: LanguageData.languageList()
          .map<DropdownMenuItem<LanguageData>>(
            (e) =>
            DropdownMenuItem<LanguageData>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    e.flag,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(e.name)
                ],
              ),
            ),
      )
          .toList(),
    );
  }
}

