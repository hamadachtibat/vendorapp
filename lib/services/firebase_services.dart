

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseServices {
  int ?employernumber;
  User ?user = FirebaseAuth.instance.currentUser;
  CollectionReference category = FirebaseFirestore.instance.collection(
      'category');
  CollectionReference products = FirebaseFirestore.instance.collection('vendors');
  CollectionReference users= FirebaseFirestore.instance.collection('users');

  Future<void> publishProduct({id, userid}) async {
    return products.doc(userid).collection('products').doc(id).update({
      'published': true,
    });
  }

  Future<void> unPublishProduct({id, userid}) async {
    return products.doc(userid).collection('products').doc(id).update({
      'published': false,
    });
  }

  Future<void> deleteProduct({id, userid}) async {
    return products.doc(userid).collection('products').doc(id).delete();
  }

  Future<void> numberofEmployer({id, userid}) async {
    return products.doc(userid).collection('products').get().then((snap) {
      employernumber = snap.size;
    });
  }
  Future<void> AvailableProduct({id, userid}) async {
    return products.doc(userid).collection('products').doc(id).update({
      'isavailbale': true,
    });
  }
  Future<void> NotAvailableProduct({id, userid,status}) async {
    return products.doc(userid).collection('products').doc(id).update({
      'isavailbale': status?false:true,
    });
  }
}