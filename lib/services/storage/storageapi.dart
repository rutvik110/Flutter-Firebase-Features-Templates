import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_firebase_feature_templates/services/storage/storage_ab.dart';

class StorageApi implements StorageAbstract {
  @override
  Future<String> uploadFile(Reference ref, File file) async {
    try {
      if (kIsWeb) {
        UploadTask uploadTask = ref.putData(await file.readAsBytes());

        await uploadTask.whenComplete(() => '');
      } else {
        File uploadFile = File(file.path);
        UploadTask uploadTask = ref.putFile(uploadFile);
        await uploadTask.whenComplete(() => '');
      }

      String imageUrl = await ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      rethrow;
    }
  }
}
