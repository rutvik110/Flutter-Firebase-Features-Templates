import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageAbstract {
  Future<String> uploadFile(Reference ref, File file);
}
