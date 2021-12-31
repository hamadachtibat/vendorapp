import 'package:flutter/material.dart';

abstract class Languages {

  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }
  String get availibility;
  String get editEmployer;
  String get cooking;
  String get employerImag;
  String get pickbirthdate;
  String get country;
  String get contractPeriod;
  String get saveEmployer;
  String get addPicture;
  String get buildingAccount;
  String get desktopName;
  String get delivredOrders;
  String get acceptedOrder;
  String get numberOfOrders;
  String get numberOfUsers;
  String get delete;
  String get action;
  String get info;
  String get image;
  String get unpublishEmployer;
  String get publishemployer;
  String get addnewEmployer;
  String get logout;
  String get employers;
  String get dashboard;
  String get registre;
  String get dontHaveAccount;
  String get forgotPassword;
  String get search;
  String get cart;
  String get orderConfirmation;
  String get orderSucces;
  String get pleaseupdateProfile;
  String get toPay;
  String get employer;
  String get youhaveSelected;
  String get showCart;
  String get email;
  String get lastName;
  String get firstName;
  String get updateProfile;
  String get change;
  String get removeFromFavourites;
  String get savetofavourites;
  String get employerAlreadySaved;
  String get age;
  String get function;
  String get babysitting;
  String get washing;
  String get cleaning;
  String get add;
  String get removeFromCart;
  String get removeItem;
  String get details;
  String get salary;
  String get religion;
  String get employerName;
  String get nationality;
  String get myAccount;
  String get myOrders;
  String get favourite;
  String get home;
  String get otherStore;
  String get theBestDesktop;
  String get enterDigits;
  String get verificationCode;
  String get coontinue;
  String get confirmlocation;
  String get prefixNumber;
  String get addyourPhoneNumber;
  String get adressdelivery;
  String get employerinallcategories;
  String get login;
  String get aryoucustomer;
  String get yourLocation;
  String get pickemployer;
  String get appName;
  String get adminNAme;
  String get password;
  String get adminlogin;
  String get placebirth;
  String get maritalstatus;
  String get childnumber;
  String get education;
  String get spookingarabic;
  String get height;
  String get weight;
  String get dateofissue;
  String get expirationdate;
  String get addtofavourite;
  String get labelWelcome;

  String get labelInfo;

  String get labelSelectLanguage;

  String get labelGoogle;

  String get labelLangA;

  String get labelLangE;

  String get appTitle;
  String get appTitlePr1;
  String get  appTitlePr2;
  String get prfTitle;

  String get usrName;

  String get labelPrf1;

  String get labelPrf2;

  String get labelPrf3;

  String get labelPrf2_1;

  String get labelPrf2_2;

  String get labelPrf2_3;
  String get labelLis1;
  String get labelLis2;
  String get labelLis3;
  String get labelLis4;
  String get labelLis5;
  String get labelLis6;
  String get labelLis7;
  String get labelLis8;
  String get labelLis2_2;
  String get labelLis2_3;
  String get labelLis2_4;
  String get labelLis2_5;
  String get labelLis2_7;
  //app title
  String get AppPolyTitle;
  String get HelpTitle;
  String get CouponsTitle;
  String get MsgTitle;
  String get privTitle;
  String get searchTitle;
  String get SettingsTitle;
  String get walletTitle;
  String get wallet2Title;
  String get whoareTitle;


}
