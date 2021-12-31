

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/screens/edit_view_product.dart';
import 'package:desktop_vendorapp/services/firebase_services.dart';
import 'package:flutter/material.dart';

class UnpublishProduct extends StatefulWidget {
  const UnpublishProduct({Key? key}) : super(key: key);

  @override
  _UnpublishProductState createState() => _UnpublishProductState();
}

class _UnpublishProductState extends State<UnpublishProduct> {
 final FireBaseServices _services = FireBaseServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream:_services.products.doc(_services.user!.uid).collection('products').where('published',isEqualTo: false).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
        {
         if(snapshot.hasError){
           return Center(child: Text("Something wrong"),);
         }if(snapshot.connectionState==ConnectionState.waiting){
           return Center(child: CircularProgressIndicator(),);
         }
         return SingleChildScrollView(
           child: FittedBox(

             child: DataTable(
               columnSpacing: 30,
               showBottomBorder: true,
               dataRowHeight: 60,
               headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
               columns: <DataColumn>[
                 DataColumn(label: Text(Languages.of(context)!.employers,
                   style: TextStyle(
                     color: Colors.black,fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                 'Cairo' : 'Nunito'
                 ),)),
                 DataColumn(label: Text(Languages.of(context)!.image,style: TextStyle(
                     color: Colors.black,fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                 'Cairo' : 'Nunito'
                 ),)),
                 DataColumn(label: Text(Languages.of(context)!.info,style: TextStyle(
                     color: Colors.black,fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                 'Cairo' : 'Nunito'
                 ),)),
                 DataColumn(label: Text(Languages.of(context)!.action,style: TextStyle(
                     color: Colors.black,fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                 'Cairo' : 'Nunito'
                 ),)),


               ],
               rows:_productDetails(snapshot.data),
             ),
           ),
         );
        },),
    );
  }
  List<DataRow> _productDetails(QuerySnapshot snapshot){
   List<DataRow> newlist = snapshot.docs.map((DocumentSnapshot document){
       return DataRow(
         cells: [
           DataCell(Text((document.data()as dynamic)['productName'])),
           DataCell(
               Row(
                children: [
               Image.network((document.data()as dynamic)['productUrl'],
               width: 50,),
             ],
           )),
           DataCell(
               IconButton(onPressed: (){
             Navigator.push(context,MaterialPageRoute (
               builder: (BuildContext context) =>  EditViewProduct(
                   productId:(document.data()as dynamic)['productId'] ),
             ),
             );
           },
                 icon:const Icon(Icons.info_outline),)),
           DataCell(popUpButton(document.data(), context: context)),

         ]
       );


   }).toList();
   return newlist;
  }
  Widget popUpButton(data,{required BuildContext context}){
    FireBaseServices _services = FireBaseServices();
return PopupMenuButton<String>(

  onSelected: (String value){
    if(value=='publish'){
      _services.publishProduct(userid: _services.user!.uid,
          id: data['productId']);
    }
    if(value=='Delete'){
      _services.deleteProduct(
        userid: _services.user!.uid,
          id :data['productId']);
    }
  },
    itemBuilder: (BuildContext context)=> <PopupMenuEntry<String>> [
       PopupMenuItem<String>(
        value: 'publish',
        child: ListTile(
          leading:const Icon(Icons.check) ,
          title: Text(Languages.of(context)!.publishemployer,
            style:TextStyle(
                color: Colors.black,fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
            'Cairo' : 'Nunito'
            ), ),
        ),
      ),
       PopupMenuItem<String>(
        value: 'Delete',
        child: ListTile(
          leading:Icon(Icons.delete) ,
          title: Text(Languages.of(context)!.delete,style:TextStyle(
              color: Colors.black,fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
          'Cairo' : 'Nunito'
          ),),
        ),
      ),

    ]

);

  }
}
