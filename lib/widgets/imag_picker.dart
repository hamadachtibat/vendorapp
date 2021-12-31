
import 'dart:io';

import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ShopPicCard extends StatefulWidget {
  const ShopPicCard({Key? key}) : super(key: key);

  @override
  State<ShopPicCard> createState() => _ShopPicCardState();
}

class _ShopPicCardState extends State<ShopPicCard> {
  var _image;
  var imagePicker;
  var type;
@override

  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }



  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () async{
      XFile image = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 20, preferredCameraDevice: CameraDevice.front);
      setState(() {
        _image = File(image.path);
        authData.ispickava=true;
        authData.picture =image.path;
      });

    },

         child: ClipRRect(
           borderRadius: BorderRadius.circular(20),
           child: Container(
            width: 200,
            height: 200,

            child: _image != null
                ? Image.file(

              _image,
              width: 200.0,
              height: 200.0,
              fit: BoxFit.fill,

        ) : Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey),
              width: 200,
              height: 200,
              child:
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 20,),
                   Text(Languages.of(context)!.addPicture,

                    style: TextStyle(fontSize: 15,
                        fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                        'Cairo' : 'Nunito',
                        fontWeight: FontWeight.bold),),
                ],
              ),
            ),
      ),
         ),
      )
    );
  }

}
