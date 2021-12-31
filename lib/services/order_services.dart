import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderServices {
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  Future<void>updateOrderStatus(documentIn,status)async{
  var result = orders.doc(documentIn).update({
    'orderStatus': status,
  });
  return result;
  }
  Future<void>deleteOrder(documentIn,status)async{
     orders.doc(documentIn).delete();

  }
}