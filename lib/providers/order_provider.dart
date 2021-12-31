import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_vendorapp/services/order_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier{
  int ?totalOrders;
  int ?accptedOrders;
  int ?deliveredOrders;
  final OrderServices _orders = OrderServices();
  User?user = FirebaseAuth.instance.currentUser;
  List cartList = [];
  List  acceptedList=[];
  List delivreedlist = [];

  String ?status;

  filterOrder(statuss){
    status = statuss;
    notifyListeners();
  }


  Future<int?> getorders()  async {
    List _newList = [];
    QuerySnapshot snapshot= await
    _orders.orders.where('seller.sellerId',isEqualTo: user!.uid).get();
    if(snapshot==null){
      return null;
    }
    for (var doc in snapshot.docs) {
      if(!_newList.contains(doc.data())){
        _newList.add(doc.data());
        cartList =_newList;
        notifyListeners();
      }
    }

    totalOrders= snapshot.size;
    notifyListeners();
    return totalOrders;

  }

  Future<int?> getacceptedorders()  async {
    List _newList = [];
    QuerySnapshot snapshot= await
    _orders.orders.where('seller.sellerId',isEqualTo: user!.uid).
    where('orderStatus',isEqualTo: 'Accepted').get();
    if(snapshot==null){
      return null;
    }
    for (var doc in snapshot.docs) {
      if(!_newList.contains(doc.data())){
        _newList.add(doc.data());
        acceptedList =_newList;
        notifyListeners();
      }
    }

    accptedOrders= snapshot.size;
    notifyListeners();
    return accptedOrders;

  }
  Future<int?> getDelivredOrders()  async {
    List _newList = [];
    QuerySnapshot snapshot= await
    _orders.orders.where('seller.sellerId',isEqualTo: user!.uid).
    where('orderStatus',isEqualTo: 'Delivered').get();
    if(snapshot==null){
      return null;
    }
    for (var doc in snapshot.docs) {
      if(!_newList.contains(doc.data())){
        _newList.add(doc.data());
         delivreedlist=_newList;
        notifyListeners();
      }
    }

    deliveredOrders= snapshot.size;
    notifyListeners();
    return deliveredOrders;

  }
}