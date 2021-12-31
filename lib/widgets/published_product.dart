


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/screens/edit_view_product.dart';
import 'package:desktop_vendorapp/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PublishProduct extends StatefulWidget {
  const PublishProduct({Key? key}) : super(key: key);

  @override
  _PublishProductState createState() => _PublishProductState();
}

class _PublishProductState extends State<PublishProduct> {
  final FireBaseServices _services = FireBaseServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream:_services.products.
          doc(_services.user!.uid).collection('products').where('published',isEqualTo: true).snapshots(),

        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
        {
          if(snapshot.hasError){
            return Center(child: Text("Something wrong"),);
          }if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return SingleChildScrollView(
            child:FittedBox(
              child: DataTable(
                columnSpacing: 30,
                showBottomBorder: true,
                dataRowHeight: 60,
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns:  <DataColumn>[
                  DataColumn(label: Text(Languages.of(context)!.employers,style: TextStyle(
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
            DataCell(
              Text((document.data()as dynamic)['productName']),
            ),
            DataCell(Row(
              children: [
                Image.network((document.data()as dynamic)['productUrl'],
                width: 50,),
              ],
            ),
            ),
            DataCell(IconButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute (
                builder: (BuildContext context) =>  EditViewProduct(
                    productId:(document.data()as dynamic)['productId'] ),
              ),
              );
            }, icon:const Icon(Icons.info_outline),)),
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
          if(value=='unpublished'){
            _services.unPublishProduct(id: data['productId'],
                userid: _services.user!.uid);
          }
        },
        itemBuilder: (BuildContext context)=> <PopupMenuEntry<String>> [
           PopupMenuItem<String>(
            value: 'unpublished',
            child: ListTile(
              leading:const Icon(Icons.check) ,
              title: Text(Languages.of(context)!.unpublishEmployer,style:TextStyle(
                  color: Colors.black,fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
              'Cairo' : 'Nunito'
              ),),
            ),
          ),

        ]

    );

  }
}