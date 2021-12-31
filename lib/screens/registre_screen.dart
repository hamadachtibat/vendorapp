
import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/localization/language_data.dart';
import 'package:desktop_vendorapp/localization/locale_constant.dart';
import 'package:desktop_vendorapp/widgets/form_validation.dart';
import 'package:desktop_vendorapp/widgets/imag_picker.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class RegistreScreen extends StatefulWidget {
  static const String id = 'Registre-screen';
  const RegistreScreen({Key? key}) : super(key: key);

  @override
  State<RegistreScreen> createState() => _RegistreScreenState();
}

class _RegistreScreenState extends State<RegistreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children:   [

               ShopPicCard(),

                RegistreForm(),
                Row(
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child:RichText(text: TextSpan(
                          text:'',
                          children: [
                            TextSpan(text: Languages.of(context)!.aryoucustomer,
                              style: TextStyle(
                                  fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                  'Cairo' : 'Nunito',
                                color: Colors.black),
                            ),
                            TextSpan(text:Languages.of(context)!.login,style: TextStyle(
                                color: Colors.red,
                              fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                              'Cairo' : 'Nunito',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
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
    );
  }

}
