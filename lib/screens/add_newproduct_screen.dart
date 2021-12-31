
import 'dart:io';
import 'dart:math';

import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/providers/auth_provider.dart';
import 'package:desktop_vendorapp/providers/product_provider.dart';
import 'package:desktop_vendorapp/widgets/category_list_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddNewProduct extends StatefulWidget {
  static const String id = 'add-product';
   AddNewProduct({Key? key}) : super(key: key);

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final _formKey = GlobalKey<FormState>();

  List<String> _collection=[

  ];

  String ?_dropDownvalue;

  final TextEditingController _categTextCont =TextEditingController();

  final TextEditingController _subcategTextCont =TextEditingController();
  final _datecontroller = TextEditingController();
  final _dateofissuecontroller = TextEditingController();
  final _dateofexperationcontroller = TextEditingController();


  DateTime ?_dateTime;



  var _image;

  var imagePicker;

  var type;
  bool _isvisible = false;
  bool _track = false;
  late String productName;
  late String nationality;
  late String Religion;
  late double Salary;
  late String Age;
  late String MariedStatus='yes';
  late String Periodexp;
  late String Numberofchild ;
  late String country;
  late String aboutEmployer;
  late String postAppliedfor;
  late String locationofbirth;
  late String livingTown;
  late String complection;
  late String height;
  late String weight;
  late String education;
  late String spooking='beginner';
  late String number;
  late String cleaning='yes';
  late String washing='yes';
  late String cooking='yes';
  late String babysitting='yes';








  @override

  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    var _provider = Provider.of<ProductProvider>(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: Form(
         key: _formKey,
          child: Column(
            children: [
              Material(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          child: Row(
                            children:  [
                              Text(Languages.of(context)!.addnewEmployer,style:
                              TextStyle(fontSize: 17,fontWeight: FontWeight.w700,
                                fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                'Cairo' : 'Nunito',
                              ),),
                            ],

                          ),
                        ),
                      ),

                      TextButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green),
                          ),
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              if(_image!=null){
                                EasyLoading.show(status: "saving...");
                                _provider.uploadFile(authData.pictureproduct,
                                    productName).then(
                                        (url){
                                          if(url!=null){
                                            EasyLoading.dismiss();
                                          _provider.saveProductDataToFb(
                                            context: context,
                                            aboutemployer: aboutEmployer,
                                            nationality: nationality,
                                            productName: productName,
                                            religion: Religion,
                                            country: country,
                                            mariedstatus: MariedStatus,
                                            numberofchildren: Numberofchild,
                                            salary: Salary,
                                            age: Age,
                                            period: Periodexp,
                                            producturl: url,
                                            birthday: _datecontroller.text,
                                            postapplied: postAppliedfor,
                                            placeofbirth: locationofbirth,
                                            livingtown: livingTown,
                                            complection: complection,
                                            height: height,
                                            weight: weight,
                                            educational: education,
                                            number: number,
                                            dateofissue: _dateofissuecontroller.text,
                                            dateodexp: _dateofexperationcontroller.text,
                                            spookarab: spooking,
                                            cleaning: cleaning,
                                            cooking: cooking,
                                            washing: washing,
                                            babysitting: babysitting,


                                          );
                                          setState(() {
                                            _formKey.currentState!.reset();
                                            _subcategTextCont.clear();
                                            _categTextCont.clear();
                                            _image =null;
                                            _track=false;
                                            _isvisible = false;
                                          });
                                          }else{
                                            _provider.alertDialog
                                              (context, 'Failed to Upload',
                                                'Please Repeat something wrong happen');
                                          }
                                        }
                                        );
                              }
                              else{
                                _provider.alertDialog
                                  (context, 'no image',
                                    'Please choose picture');
                              }
                            }
                          },
                          icon: const Icon(Icons.save_alt_outlined,color: Colors.white,),
                          label:  Text(Languages.of(context)!.saveEmployer,
                            style: TextStyle(color: Colors.white,
                              fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                              'Cairo' : 'Nunito',
                            ),))
                    ],
                  ),
                ),
              ),
               TabBar(
                  indicatorColor: Colors.green,
                  tabs: [
                const Tab(child:
                Text('Manage your  Employers',style: TextStyle(color: Colors.black),),),
              ]
                ),
               Expanded(

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(

                    child:
                    TabBarView(children: [
                      ListView(children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                             TextFormField(
                               validator: (value){
                                 if(value!.isEmpty){
                                   return 'Product Name';
                                 }
                                 setState(() {
                                   productName = value;
                                 });
                                 return null;
                               } ,
                               decoration:  InputDecoration(
                                 labelText: Languages.of(context)!.employerName,
                                 labelStyle: TextStyle(
                                   color: Colors.grey,
                                   fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                   'Cairo' : 'Nunito',
                                 ),
                                 enabledBorder: UnderlineInputBorder(
                                   borderSide: BorderSide(
                                     color: Colors.grey
                                   )
                                 )
                               ),

                             ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'please add post';
                                  }
                                  setState(() {
                                    postAppliedfor = value;
                                  });
                                  return null;
                                } ,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.function,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),

                              ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Country';
                                  }
                                  setState(() {
                                    country = value;
                                  });
                                  return null;
                                } ,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.country,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',

                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'exprience Period';
                                  }
                                  setState(() {
                                    Periodexp = value;
                                  });
                                  return null;
                                } ,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.contractPeriod,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                             TextFormField(
                               validator: (value){
                                 if(value!.isEmpty){
                                   return 'Nationality';
                                 }
                                 setState(() {
                                  nationality = value;
                                 });
                                 return null;
                               } ,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.nationality,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                             TextFormField(
                               validator: (value){
                                 if(value!.isEmpty){
                                   return 'Religion';
                                 }
                                 setState(() {
                                   Religion = value;
                                 });
                                 return null;
                               } ,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.religion,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',

                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Place Of Birth';
                                  }
                                  setState(() {
                                    locationofbirth = value;
                                  });
                                  return null;
                                } ,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.placebirth,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',

                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              TextFormField(
                                controller: _datecontroller,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Pick a date';
                                  }
                                  return null;
                                } ,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.pickbirthdate,
                                    suffixIcon: IconButton(
                                        onPressed: (){
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2222)).then(
                                                  (date){
                                                    setState(() {
                                                          _datecontroller.text=DateFormat.yMMMd().format
                                                            (DateTime.parse(date.toString()) );

                                                    });
                                                  });
                                        },
                                        icon: const Icon(Icons.date_range)),
                                    labelStyle:  TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Age';
                                  }
                                  setState(() {
                                    Age = value;
                                  });
                                  return null;
                                } ,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.age,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',

                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                               Padding(
                                padding: EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async{
                                    XFile image = await imagePicker.pickImage(
                                        source: ImageSource.gallery, imageQuality: 20, preferredCameraDevice: CameraDevice.front);
                                    setState(() {
                                      _image = File(image.path);
                                      authData.ispickava=true;
                                      authData.pictureproduct=image.path;
                                    });

                                  },
                                  child: _image != null
                                      ? Image.file(

                                    _image,
                                    width: 150.0,
                                    height: 150.0,
                                    fit: BoxFit.fill,

                                  ): Container(
                                    height: 150,
                                    width: 150,
                                    child: Card(
                                      elevation: 4,
                                      child:
                                      Center(child: Text(Languages.of(context)!.employerImag,
                                        style: TextStyle(fontWeight: FontWeight.bold,
                                          fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                          'Cairo' : 'Nunito',
                                        ),),),
                                    ),
                                  ),
                                ),
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Salary';
                                  }
                                  setState(() {
                                    Salary = double.parse(value);
                                  });
                                  return null;
                                } ,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.salary,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              TextFormField(
                                maxLines: 3,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'About Employer';
                                  }
                                  setState(() {
                                    aboutEmployer = value;
                                  });
                                  return null;
                                } ,
                                decoration: const InputDecoration(
                                    labelText: "About Employer",
                                    labelStyle: TextStyle(
                                      color: Colors.grey,

                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              Row(children: [

                                Container(
                                  width: 250,
                                  child:AbsorbPointer(

                                    child: Text(Languages.of(context)!.maritalstatus,
                                      style: TextStyle(
                                        fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                        'Cairo' : 'Nunito',
                                      ),
                                    ),
                                  ),
                                ),

                                DropdownButton<String>(
                                  value: MariedStatus,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 5,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      MariedStatus = newValue!;
                                    });
                                  },
                                  items: <String>['yes', 'no']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],),
                              Visibility(
                                visible: MariedStatus=='yes'?true:false,
                                child: TextFormField(
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'number of children';
                                    }
                                    setState(() {
                                      Numberofchild = value;
                                    });
                                    return null;
                                  } ,
                                  decoration:  InputDecoration(
                                      labelText: Languages.of(context)!.childnumber,
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                        'Cairo' : 'Nunito',
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey
                                          )
                                      )
                                  ),
                                ),
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Complection';
                                  }
                                  setState(() {
                                    complection = value;
                                  });
                                  return null;
                                } ,
                                decoration: const InputDecoration(
                                    labelText: 'Complection',
                                    labelStyle: TextStyle(
                                      color: Colors.grey,

                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Height';
                                  }
                                  setState(() {
                                    height = value;
                                  });
                                  return null;
                                } ,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.height,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',

                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Weigth';
                                  }
                                  setState(() {
                                    weight = value;
                                  });
                                  return null;
                                } ,
                                decoration: InputDecoration(
                                    labelText: Languages.of(context)!.weight,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',

                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Education';
                                  }
                                  setState(() {
                                    education = value;
                                  });
                                  return null;
                                } ,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.education,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Number';
                                  }
                                  setState(() {
                                    number = value;
                                  });
                                  return null;
                                } ,
                                decoration: const InputDecoration(
                                    labelText: 'Number',
                                    labelStyle: TextStyle(
                                      color: Colors.grey,

                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              TextFormField(
                                controller: _dateofissuecontroller,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Date Of Issue';
                                  }
                                  return null;
                                } ,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.dateofissue,
                                    suffixIcon: IconButton(
                                        onPressed: (){
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2222)).then(
                                                  (date){
                                                setState(() {
                                                  _dateofissuecontroller.text=DateFormat.yMMMd().format
                                                    (DateTime.parse(date.toString()) );

                                                });
                                              });
                                        },
                                        icon: const Icon(Icons.date_range)),
                                    labelStyle:  TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',

                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Living Town';
                                  }
                                  setState(() {
                                    livingTown = value;
                                  });
                                  return null;
                                } ,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.placebirth,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                        fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                        'Cairo' : 'Nunito',

                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              TextFormField(
                                controller: _dateofexperationcontroller,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Date Of Issue';
                                  }
                                  return null;
                                } ,
                                decoration:  InputDecoration(
                                    labelText: Languages.of(context)!.expirationdate,
                                    suffixIcon: IconButton(
                                        onPressed: (){
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2222)).then(
                                                  (date){
                                                setState(() {
                                                  _dateofexperationcontroller.text=DateFormat.yMMMd().format
                                                    (DateTime.parse(date.toString()) );

                                                });
                                              });
                                        },
                                        icon: const Icon(Icons.date_range)),
                                    labelStyle:  TextStyle(
                                      color: Colors.grey,
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',

                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    )
                                ),
                              ),
                              Row(children: [

                                Container(
                                  width: 250,
                                  child:AbsorbPointer(
                                    child: Text(Languages.of(context)!.spookingarabic,style:
                                    TextStyle(
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',
                                    ),
                                    ),
                                  ),
                                ),

                                DropdownButton<String>(
                                  value: spooking,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 5,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      spooking = newValue!;
                                    });
                                  },
                                  items: <String>['beginner', 'Good','Excellent']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],),
                              Row(children: [

                                Container(
                                  width: 250,
                                  child:AbsorbPointer(
                                    child: Text(
                                        Languages.of(context)!.cleaning,
                                      style: TextStyle(
                                        fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                        'Cairo' : 'Nunito',
                                      ),
                                    ),
                                  ),
                                ),

                                DropdownButton<String>(
                                  value: cleaning,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 5,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      cleaning = newValue!;
                                    });
                                  },
                                  items: <String>['yes', 'no']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],),
                              Row(children: [

                                Container(
                                  width: 250,
                                  child:AbsorbPointer(

                                    child: Text(
                                        Languages.of(context)!.washing,style: TextStyle(fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                    'Cairo' : 'Nunito',),)
                                  ),
                                ),

                                DropdownButton<String>(
                                  value: washing,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 5,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      washing = newValue!;
                                    });
                                  },
                                  items: <String>['yes', 'no']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],),
                              Row(children: [

                                Container(
                                  width: 250,
                                  child:AbsorbPointer(

                                    child: Text(
                                      Languages.of(context)!.cooking,
                                        style: TextStyle(fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                        'Cairo' : 'Nunito',)
                                    ),
                                  ),
                                ),

                                DropdownButton<String>(
                                  value: cooking,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 5,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      cooking = newValue!;
                                    });
                                  },
                                  items: <String>['yes', 'no']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],),
                              Row(children: [

                                Container(
                                  width: 250,
                                  child:AbsorbPointer(

                                    child: Text(
                                        Languages.of(context)!.babysitting,
                                        style: TextStyle(fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                        'Cairo' : 'Nunito',)
                                    ),
                                  ),
                                ),

                                DropdownButton<String>(
                                  value: babysitting,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 5,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      babysitting = newValue!;
                                    });
                                  },
                                  items: <String>['yes', 'no']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],),



                              Padding(
                                padding: const EdgeInsets.only(top:20.0,bottom: 10),
                                child: Row(children:  [
                                  const Text("category",style: TextStyle(
                                      color: Colors.grey,fontSize: 16,
                                  ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: AbsorbPointer(
                                      absorbing: true,
                                      child: TextFormField(
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Select Category";
                                          }
                                          setState(() {
                                            _categTextCont.text=value;
                                          });
                                          return null;
                                        },
                                        controller: _categTextCont,
                                        decoration: const InputDecoration(
                                            labelText: 'not selected',
                                            labelStyle: TextStyle(
                                              color: Colors.grey,

                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                )
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    showDialog(context: context,
                                        builder: (BuildContext context){
                                      return const CategoryList();
                                        }).whenComplete((){
                                          setState(() {
                                            _categTextCont.text =_provider.selectedcategory;
                                            _isvisible=true;
                                          });

                                    });
                                  }
                                  , icon:Icon(Icons.edit))
                                ],),
                              ),
                              Visibility(
                                visible: _isvisible,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:20.0,bottom: 10),
                                  child: Row(children:  [
                                    const Text('Sub-Category',style: TextStyle(
                                      color: Colors.grey,fontSize: 16,
                                    ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: AbsorbPointer(
                                        absorbing: true,
                                        child: TextFormField(
                                          validator: (value){
                                            if(value!.isEmpty){
                                              return "Select Sub-Category";
                                            }
                                            setState(() {
                                              _subcategTextCont.text=value;
                                            });
                                            return null;
                                          },
                                          controller: _subcategTextCont,
                                          decoration: const InputDecoration(
                                              labelText: 'not selected',
                                              labelStyle: TextStyle(
                                                color: Colors.grey,

                                              ),
                                              enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey
                                                  )
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(onPressed: (){
                                      showDialog(context: context,
                                          builder: (BuildContext context){
                                            return const SubCategoryList();
                                          }).whenComplete((){
                                        _subcategTextCont.text =_provider.selectedsubcategory;
                                      });
                                    }
                                        , icon:Icon(Icons.edit))
                                  ],),
                                ),
                              ),


                            ],
                          ),
                        )
                      ],),

                    ]),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
