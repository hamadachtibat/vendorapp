import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/providers/auth_provider.dart';
import 'package:desktop_vendorapp/providers/product_provider.dart';
import 'package:desktop_vendorapp/services/firebase_services.dart';
import 'package:desktop_vendorapp/widgets/category_list_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditViewProduct extends StatefulWidget {
  const EditViewProduct({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  _EditViewProductState createState() => _EditViewProductState();
}

class _EditViewProductState extends State<EditViewProduct> {
  final FireBaseServices _services = FireBaseServices();
  final _formKey = GlobalKey<FormState>();
  bool _isvisible = false;
  final TextEditingController _religionTextcont=TextEditingController();
  final TextEditingController _nationalityTextcont=TextEditingController();
  final TextEditingController _productnameTextcont=TextEditingController();
  final TextEditingController _marriedStatus =TextEditingController();
  final TextEditingController _numberofChildrencont =TextEditingController();
  final TextEditingController _salarycont =TextEditingController();
  final TextEditingController _aboutycont =TextEditingController();
  final TextEditingController _categTextCont = TextEditingController();
  final TextEditingController _subcategTextCont = TextEditingController();
  final TextEditingController _experinceTextCont = TextEditingController();
  final TextEditingController _counteyexpTextCont = TextEditingController();
  final TextEditingController _ageTextCont = TextEditingController();


  var _image;
  String ?productid;
  var imagePicker;

  var type;

  String ?image;
  bool  availibility=false;
  String ?categoryImage;





  @override
  void initState() {
    getProductDetails();
    imagePicker = new ImagePicker();
    super.initState();
  }

  Future<void> getProductDetails() async{
    _services.products.doc(_services.user!.uid).
    collection('products').doc(widget.productId).get().then((DocumentSnapshot document){
      if(document.exists){
        setState(() {

       _religionTextcont.text = (document.data()as dynamic)['religion'];
       _ageTextCont.text = (document.data()as dynamic)['age'];
        _nationalityTextcont.text = (document.data()as dynamic)['nationality'];
        _productnameTextcont.text = (document.data()as dynamic)['productName'];
        _marriedStatus.text = (document.data()as dynamic)['marriedStatus'];
        _numberofChildrencont.text = (document.data()as dynamic)['numberOfchildren'];
        _salarycont.text = ((document.data()as dynamic)['salary']).toString();
        image = (document.data()as dynamic)['productUrl'];
        _aboutycont.text = (document.data()as dynamic)['aboutemployer'];
          _categTextCont.text = (document.data()as dynamic)['category']['Main-category'];
          _subcategTextCont.text = (document.data()as dynamic)['category']['subcategory'];
          _experinceTextCont.text = (document.data()as dynamic)['period'];
          _counteyexpTextCont.text = (document.data()as dynamic)['country'];
          _counteyexpTextCont.text = (document.data()as dynamic)['age'];
          availibility = (document.data()as dynamic)['isavailbale'];
          productid = (document.data()as dynamic)['productId'];
          categoryImage=(document.data()as dynamic)['categoryImag'];
          _experinceTextCont.text =(document.data()as dynamic)['period'];





        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<ProductProvider>(context);
    final authData = Provider.of<AuthProvider>(context);

    

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(Languages.of(context)!.editEmployer,
        style: TextStyle(fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
        'Cairo' : 'Nunito',),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              EasyLoading.show(status: 'Updating....');
              if (_image != null) {
                _provider.uploadFile(
                    authData.pictureproduct, _productnameTextcont.text).then((
                    url) {
                    if(url!=null){
                      EasyLoading.dismiss();
                      _provider.updateProductDataToFb(
                        context: context,
                        period: _experinceTextCont.text,
                        productName: _productnameTextcont.text,
                          country: _counteyexpTextCont.text,
                        nationality: _nationalityTextcont.text,
                        salary: double.parse(_salarycont.text),
                          age:_ageTextCont.text,
                        religion: _religionTextcont.text,
                        aboutemployer: _aboutycont.text,
                        mariedstatus: _marriedStatus.text,
                        numberofchildren: _numberofChildrencont.text,
                        producturl: url,
                        category: _categTextCont.text,
                        subcategory: _subcategTextCont.text,
                        categoryimage:  categoryImage,
                        productId: productid,
                      );
                    }

                });

              }else{
                EasyLoading.dismiss();
                _provider.updateProductDataToFb(
                  context: context,
                  period: _experinceTextCont.text,
                  productName: _productnameTextcont.text,
                  country: _counteyexpTextCont.text,
                  nationality: _nationalityTextcont.text,
                  salary: double.parse(_salarycont.text),
                  age:_ageTextCont.text,
                  religion: _religionTextcont.text,
                  aboutemployer: _aboutycont.text,
                  mariedstatus: _marriedStatus.text,
                  numberofchildren: _numberofChildrencont.text,
                  producturl: image,
                  category: _categTextCont.text,
                  subcategory: _subcategTextCont.text,
                  categoryimage:  categoryImage,
                  productId: productid,
                );
              }

            }
          },
        label: Text(Languages.of(context)!.saveEmployer,style: TextStyle(fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
        'Cairo' : 'Nunito',),),
        icon: const Icon(Icons.save_alt_outlined),

        splashColor: Colors.red,
      ),

      body:Form(
        key: _formKey,
        child: Padding(padding: EdgeInsets.all(10),

        child
            : ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SwitchListTile(
                  inactiveTrackColor: Colors.red,
                    title:  Text(Languages.of(context)!.availibility,style: TextStyle(fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                    'Cairo' : 'Nunito',)),
                    value: availibility, onChanged: (bool value){
                  setState(() {
                    _services.NotAvailableProduct(id: productid,
                        userid: _services.user!.uid,
                        status:availibility );
                    availibility = value;
                  });
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 40,
                        child: TextFormField(
                          controller: _religionTextcont,
                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8,right: 8,top: 8),
                              labelText: Languages.of(context)!.religion,
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                  fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                  'Cairo' : 'Nunito',
                              ),
                              border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.green.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       Text(Languages.of(context)!.nationality,style: TextStyle(fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                       'Cairo' : 'Nunito',),),
                        SizedBox(
                          width:100,
                          child:TextFormField(
                            controller: _nationalityTextcont,
                            decoration:  InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 8,right: 8),
                              labelStyle: const TextStyle(
                                color: Colors.grey,

                              ),
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.green.withOpacity(0.1),
                            ),
                          ),
                        ),
                    ],
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text(Languages.of(context)!.age,style: TextStyle(fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                     'Cairo' : 'Nunito',),),
                    SizedBox(
                      width:100,
                      child:TextFormField(
                        controller:_ageTextCont,
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 8,right: 8),
                          labelStyle: const TextStyle(
                            color: Colors.grey,

                          ),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.green.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                 mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(Languages.of(context)!.employerName,style: TextStyle(fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                    'Cairo' : 'Nunito',)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: _productnameTextcont,
                          style: const TextStyle(fontSize: 18,
                            fontWeight: FontWeight.bold),
                          decoration:  InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 8,right: 8),
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.green.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('MarriedStatus:'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: _marriedStatus,
                          style: const TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold),
                          decoration:  InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 8,right: 8),
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.green.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [
                     Text(Languages.of(context)!.childnumber,style: TextStyle(fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                     'Cairo' : 'Nunito',)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: _numberofChildrencont,
                          style: const TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold),
                          decoration:  InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 8,right: 8),
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.green.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _salarycont,
                    decoration:  InputDecoration(
                      prefixText: 'R.O ',
                      contentPadding: EdgeInsets.only(left: 8,right: 8),
                      labelText: Languages.of(context)!.salary,
                      labelStyle: TextStyle(
                        color: Colors.grey,
                          fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                          'Cairo' : 'Nunito',

                      ),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.green.withOpacity(0.1),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
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
                          Center(child:Image.network(image as dynamic),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text('About Employer',style: const TextStyle(
                  fontSize: 18,
                    fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.all(2),
                child: TextFormField(
                  controller: _aboutycont,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:20.0,bottom: 10),
                  child: Row(children:  [
                    const Text('Category',style: TextStyle(
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

                Row(
                  children: [
                     const Text("Experience"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 80,
                        child: TextFormField(
                          controller: _experinceTextCont,
                          style: const TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold),
                          decoration:  InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 8,right: 8),
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.green.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(Languages.of(context)!.country),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 80,
                        child: TextFormField(
                          controller: _counteyexpTextCont,
                          style: const TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold),
                          decoration:  InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 8,right: 8),
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.green.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        ),
      )

    );
  }
}
