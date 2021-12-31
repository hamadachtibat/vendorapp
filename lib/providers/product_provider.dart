

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_vendorapp/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier{
  int ?numberOfUsers;
  String selectedcategory = 'not selected';
  String selectedsubcategory = 'not selected';
  String categoryImag = '';
  String shopname='';
  int ?numberofemployer ;
  QuerySnapshot ?snap;
  QuerySnapshot ?snappp;
  List cartList = [];
  int numberr=0;

  User ?user =FirebaseAuth.instance.currentUser;
  final FireBaseServices _employer = FireBaseServices();


  selectedCategory(mainCategory,categoryImage){
  selectedcategory = mainCategory;
  categoryImag = categoryImage;
  notifyListeners();
  }
  getShopName(shoppname){
    this.shopname = shoppname;

  }
  selectedSubCategory(selected){
    selectedsubcategory = selected;
    notifyListeners();
  }
  alertDialog(context,title,content){
    return showCupertinoDialog(
        context: context,

        builder: (BuildContext conext){
          return CupertinoAlertDialog(
            title: Text(title),
            content:Text(content) ,
            actions:  [
              CupertinoDialogAction(child: Text(" return"),
              onPressed: (){
                Navigator.pop(context);
              },)
            ],

          );
        }

        );
  }
  Future<String> uploadFile(String filePath,productname) async {
    File file = File(filePath);
    var timeStamp = Timestamp.now().millisecondsSinceEpoch;
    FirebaseStorage firebaseStorage=  FirebaseStorage.instance;
    try {
      await firebaseStorage.ref('ProductImage/${shopname}${productname}${timeStamp}').putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);

    }

    String downloadURL = await firebaseStorage.ref('ProductImage/${shopname}${productname}${timeStamp}').getDownloadURL();

    notifyListeners();
    return downloadURL ;
  }
   Future<void> saveProductDataToFb({
       productName,nationality,religion,salary,age,aboutemployer,
       mariedstatus,numberofchildren,country,period,
      context,producturl,birthday,postapplied,placeofbirth,
   livingtown,complection,height,weight,educational,number,dateofissue,dateodexp,
   spookarab,cleaning,washing,cooking,babysitting})
   async{
    var stamp = Timestamp.now().millisecondsSinceEpoch;
    User ?user = FirebaseAuth.instance.currentUser;
    CollectionReference _product = FirebaseFirestore.instance.
    collection('vendors').doc(user!.uid).collection('products');
   try{
     _product.doc(stamp.toString()).set({
       'seller':{'shopname':shopname,'selleruid':user.uid},
       'productName':productName,
       'nationality':nationality,
       'religion':religion,
       'salary':salary,
       'age':age,
       'marriedStatus':mariedstatus,
       'numberOfchildren':numberofchildren,
       'country':country,
       'period':period,
       'category': {'Main-category':selectedcategory,
         'subcategory':selectedsubcategory,
         'categoryImag':categoryImag},
       'published':false,
       'productId': stamp.toString(),
       'productUrl': producturl,
       'aboutemployer':aboutemployer,
       'isavailbale':false,
       'numberofemployer':numberr,
       'birthdate':birthday,
       'postappliedfor':postapplied,
       'placeofbirthday':placeofbirth,
       'livingtown':livingtown,
       'complection':complection,
       'height':height,
       'weight':weight,
       'education':educational,
       'number':number,
       'dateofissue':dateofissue,
       'dateofexp':dateodexp,
       'spookingarabic':spookarab,
       'cleaning':cleaning,
       'washing':washing,
       'cooking':cooking,
       'babySitting':babysitting,



     });

     alertDialog(context, 'Save Data', 'Employer Saved Successfully');



   }catch(e){
     print(e.toString());
     alertDialog(context, 'Failed', 'Went Wrong !! ');
   }

   }
  Future<int> numberofEmployer({ userid}) async {
    CollectionReference products = FirebaseFirestore.instance.collection(
        'vendors');
     return products.doc(userid).collection('products').get().then((snap) {
       snap.size;
       return snap.size;
    });


  }
  Future<void> updateProductDataToFb({
    productName,nationality,religion,salary,age,aboutemployer,
    mariedstatus,numberofchildren,country,period,
    stockquantity,context,lowquantity,producturl,productId,
  category,subcategory,categoryimage})
  async{
    User ?user = FirebaseAuth.instance.currentUser;
    CollectionReference _product = FirebaseFirestore.
    instance.collection('vendors').doc(user!.uid).collection('products');
    try{
      _product.doc(productId).update({
        'productName':productName,
        'nationality':nationality,
        'religion':religion,
        'salary':salary,
        'age':age,
        'marriedStatus':mariedstatus,
        'numberOfchildren':numberofchildren,
        'country':country,
        'period':period,
        'category': {'Main-category':category,
          'subcategory':subcategory,
          'categoryImag':categoryImag==null? categoryimage : categoryImag},
        'stockQuantity':stockquantity,
        'productId': productId,
        'lowQantity':lowquantity,
        'productUrl': producturl,
        'aboutemployer':aboutemployer,
        'categoryImag': categoryImag,






      });
      alertDialog(context, 'Updated', 'Employer Updated Successfully');




    }catch(e){
      print(e.toString());
      alertDialog(context, 'Failed', 'Went Wrong !! ');
    }

  }
  resetProvider(){
     selectedcategory = '';
     selectedsubcategory == '';
     categoryImag = '';
     shopname='';
     notifyListeners();
  }

  Future<int?> getTotalEmployer()  async {
    List _newList = [];
    QuerySnapshot snapshot= await
    _employer.products.doc(user!.uid).collection('products').
    where('published',isEqualTo: true).get();
    if(snapshot==null){
      return null;
    }
    snapshot.docs.forEach((doc) {
      if(!_newList.contains(doc.data())){
        _newList.add(doc.data());
        cartList =_newList;
        notifyListeners();
      }
    });

    numberofemployer= snapshot.size;
    snap=snapshot;
    notifyListeners();
    return numberofemployer;

  }


  Future<int?> getTotalUsers()  async {
    List _newList = [];
    QuerySnapshot snapshot= await
    _employer.users.get();
    if(snapshot==null){
      return null;
    }
    snapshot.docs.forEach((doc) {
      if(!_newList.contains(doc.data())){
        _newList.add(doc.data());
        cartList =_newList;
        notifyListeners();
      }
    });

    numberOfUsers= snapshot.size;
    snappp=snapshot;
    notifyListeners();
    return numberofemployer;

  }
}