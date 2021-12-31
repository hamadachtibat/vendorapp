



import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

class AuthProvider extends ChangeNotifier{
  var type;
  String pickerError='';
  bool ispickava=false;
  double ?shoplaltitude;
  double ?shoplongitude;
  String ?shopaddress;
  String ?placename;
  String error = "";
  String emaill = '';
  var imag;
  var picture;
  var pictureproduct;

  Future<XFile?>  getImag()async{
    ImagePicker imagePicker =  ImagePicker();
      XFile? image = await imagePicker.pickImage(
         source: ImageSource.gallery, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
     if(image!=null){
       imag=File(image.path) ;
       notifyListeners();
     }else{
       pickerError='no img selected';
       print('no imag selected');
     }
     return imag ;
    }




  Future getCurrentLocation()async{
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    shoplaltitude =_locationData.latitude;
    shoplongitude=_locationData.longitude;
    notifyListeners();
    final coordinates =  Coordinates
      (_locationData.latitude,_locationData.longitude );
    var _address = (await Geocoder.local.findAddressesFromCoordinates(coordinates))
    ;


    var  _shopaddress= _address.first;
    shopaddress=_shopaddress.addressLine;
    placename= _shopaddress.featureName;
    notifyListeners();
    return shopaddress;
  }

  Future<UserCredential?>RegistreVendor(email,password)async{
     UserCredential ?userCredential;
     emaill=email;
     notifyListeners();
    try {
       userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
        notifyListeners();
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        error= 'The account already exists for that email.';
        print('The account already exists for that email.');
        notifyListeners();
      }
    } catch (e) {
      error=e.toString();
      notifyListeners();
      print(e);
    }return userCredential;
  }
  Future<void> SaveVendorData({String ?url,String ?shopname,String ?phonenumber}) async{
    User? user  = FirebaseAuth.instance.currentUser;
    DocumentReference _vendors= FirebaseFirestore.instance.
    collection('vendors').doc(user!.uid);

    _vendors.set({
      'uid':user.uid,
      'shopname':shopname,
      'url':url,
      'phonenumber':phonenumber,
      'email':emaill,
      'address':'${shopname} : ${shopaddress}',
      'location':GeoPoint(shoplaltitude!,shoplongitude!),
      'shopopen':true,
      'rating':0.0,
      'total rating':0.0,
      'isTopPick':false,
      'acountverified':false,
      'numberOfEmployer':0,
    });
  }
  Future<UserCredential?> LoginVendor(email,password)async{
    UserCredential ?userCredential;
    emaill=email;
    notifyListeners();
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {

      error = e.code;
        notifyListeners();

    } catch (e) {
      error=e.toString();
      notifyListeners();
      print(e);
    }return userCredential;
  }


  Future<void> ResetpassVendor(email)async{
    emaill=email;
    notifyListeners();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,);
    } on FirebaseAuthException catch (e) {

      error = e.code;
      notifyListeners();

    } catch (e) {
      error=e.toString();
      notifyListeners();
      print(e);
    };
  }
}