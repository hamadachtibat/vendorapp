import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_vendorapp/providers/product_provider.dart';
import 'package:desktop_vendorapp/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final FireBaseServices _services = FireBaseServices();
  @override
  Widget build(BuildContext context) {
    var _provider=Provider.of<ProductProvider>(context);
    return Dialog(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Category'),
                IconButton(
                    onPressed: (){Navigator.of(context).pop();},
                    icon: Icon(Icons.close))
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _services.category.snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.hasError){
                  return Center(child: Text("SomeThing went Wrong"),);

                }if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                return Expanded(

                  child: ListView(
                    children:
                      snapshot.data!.docs.map((DocumentSnapshot document){
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage((document.data() as dynamic) ['imag']),
                          ),
                          title: Text((document.data() as dynamic) ['name']),
                          onTap: (){
                            _provider.selectedCategory((document.data() as dynamic) ['name'],(document.data() as dynamic) ['imag']);
                            Navigator.pop(context);
                          },
                        );
                      }).toList()

                  ),
                );
              }

          )
        ],
      ),
    );
  }
}




class SubCategoryList extends StatefulWidget {
  const SubCategoryList({Key? key}) : super(key: key);

  @override
  _SubCategoryListState createState() => _SubCategoryListState();
}

class _SubCategoryListState extends State<SubCategoryList> {
  final FireBaseServices _services = FireBaseServices();
  @override
  Widget build(BuildContext context) {
    var _provider=Provider.of<ProductProvider>(context);
    return Dialog(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Sub-Category'),
                IconButton(
                    onPressed: (){Navigator.of(context).pop();},
                    icon: Icon(Icons.close))
              ],
            ),
          ),
          FutureBuilder<DocumentSnapshot>(
              future: _services.category.doc(_provider.selectedcategory).get(),
              builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasError){
                  return Center(child: Text("SomeThing went Wrong"),);

                }if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                        children: [
                          const Text('main-Category :',style: TextStyle(
                              fontWeight: FontWeight.bold),),
                          const SizedBox(width: 20,),
                          FittedBox(child: Text(_provider.selectedcategory,style: TextStyle(
                              fontWeight: FontWeight.bold))),
                        ],
                    ),
                      ),
                    const Divider(thickness: 3,),
                      Container(
                        child: Expanded(

                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(

                                itemBuilder: (BuildContext context,int index){
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      child: Text('${index+1}'),
                                    ),
                                    title: Text(data['subcat'][index]['name'],),
                                    onTap: (){
                                      _provider.selectedSubCategory(data['subcat'][index]['name']);
                                      Navigator.pop(context);
                                    },
                                  );

                                },
                                itemCount: data['subcat']==null? 0 :data['subcat'].length,


                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

          )
        ],
      ),
    );
  }
}
