import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ImagePickerController extends GetxController{

  Rx<File> image = File('').obs;

  Future pickimage() async {

    try {
      final imagepick = await ImagePicker().pickImage(
          source: ImageSource.gallery);

      if (imagepick == null) {
        return;
      }
      final imagetemp = File(imagepick.path);
      image.value = imagetemp;
    }catch(e){
      return e;
    }

  }



  Rx<String> networkimage = ''.obs;

  Future<String> uploadImageToFirebase () async{

    String filename = DateTime.now().microsecondsSinceEpoch.toString();

    try{

      Reference refrence = FirebaseStorage.instance.ref().child('userdp/$filename.png');
      await refrence.putFile(image.value);

      String downloadURL =await refrence.getDownloadURL();
      networkimage.value=downloadURL;
      return downloadURL;

    }catch(e){
      return 'File NOt uploaded';
    }

  }

}
