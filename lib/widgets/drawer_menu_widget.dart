
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/providers/product_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:provider/provider.dart';

class MenuWidget extends StatefulWidget {
  final Function(String)? onItemClick;

  const MenuWidget({Key? key, this.onItemClick}) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
User? user = FirebaseAuth.instance.currentUser;
DocumentSnapshot ?vendorData;
  @override
  void initState() {
    getVendorData();
    super.initState();
  }

Future<DocumentSnapshot> getVendorData() async{
  var result = await FirebaseFirestore.instance.
  collection('vendors').doc(user!.uid).get();
  if(result.exists){
    setState(() {
      vendorData=result;
    });
  }
  return result;
}
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<ProductProvider>(context,listen: false);


      _provider.getShopName(vendorData !=null?
      (vendorData?.data() as dynamic)['shopname']:'');


    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
           CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              backgroundImage: NetworkImage( vendorData!=null?
              ((vendorData?.data() as dynamic)['url']):null),
              radius: 60,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
           Text( vendorData!=null ? (vendorData?.data() as dynamic)['shopname']:
            'Shop name',
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          sliderItem(Languages.of(context)!.dashboard, Icons.dashboard_customize_outlined),
          sliderItem(Languages.of(context)!.employers, Icons.shopping_bag_outlined),
          sliderItem(Languages.of(context)!.myOrders, Icons.list_alt_outlined),
          sliderItem(Languages.of(context)!.logout, Icons.arrow_back_ios)
        ],
      ),
    );
  }

  Widget sliderItem(String title, IconData icons) => InkWell(

    child: Container(
     decoration: BoxDecoration(
       border: Border(bottom: BorderSide(
         color: Colors.grey
       ))
     ),
      child: ListTile(
          title: Text(
            title,
            style:
            TextStyle(color: Colors.black, fontFamily: 'BalsamiqSans_Regular'),
          ),
          leading: Icon(
            icons,
            color: Colors.black,
          ),

          ),
    ),
      onTap: () {
        widget.onItemClick!(title);
        print(title);
      }
  );
}