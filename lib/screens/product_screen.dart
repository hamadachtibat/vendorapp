import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/providers/product_provider.dart';
import 'package:desktop_vendorapp/screens/add_newproduct_screen.dart';
import 'package:desktop_vendorapp/services/firebase_services.dart';
import 'package:desktop_vendorapp/widgets/published_product.dart';
import 'package:desktop_vendorapp/widgets/unpublish_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final FireBaseServices _services =FireBaseServices();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var _provider=Provider.of<ProductProvider>(context);
    _provider.getTotalEmployer();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Material(
              elevation: 3,
              child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      child: Row(
                       children:   [
                          Text(Languages.of(context)!.employers,style:
                         TextStyle(fontSize: 17,fontWeight: FontWeight.w700,
                             fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                             'Cairo' : 'Nunito'),),
                         const SizedBox(width: 10,),
                         CircleAvatar(
                           backgroundColor: Colors.black,
                           maxRadius: 12,
                           child: FittedBox(

                             child: Padding(
                               padding: const EdgeInsets.all(6.0),
                               child: Text(_provider.numberofemployer.toString(),style:
                               const TextStyle(
                                   color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                             ),
                           ),
                         ),
                       ],

                      ),
                    ),
                  ),

                  TextButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                      onPressed: (){
                      Navigator.pushNamed(context, AddNewProduct.id);
                      },
                      icon: const Icon(Icons.add,color: Colors.white,),
                      label:  Text(Languages.of(context)!.addnewEmployer,
                        style: TextStyle(color: Colors.white,
                            fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                        'Cairo' : 'Nunito'),))
                ],
              ),
          ),
            ),
              TabBar(
                 indicatorColor: Colors.green,

                 tabs: [
              Tab(child:
              Text(Languages.of(context)!.publishemployer,style: TextStyle(
                  fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                  'Cairo' : 'Nunito',
                  color: Colors.black),),),
              Tab(child:Text(Languages.of(context)!.unpublishEmployer,
                style: TextStyle(color: Colors.black,
                  fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                  'Cairo' : 'Nunito',

                ),)
               ,)
            ]),
            const Expanded(
              child: TabBarView(children:[
                PublishProduct(),
                UnpublishProduct(),
              ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
