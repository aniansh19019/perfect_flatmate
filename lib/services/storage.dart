import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

class Storage
{
  static Future<String> getImageUrl(String uri)async
  {
    final storageRef = FirebaseStorage.instance.ref();
    final imageUrl = await storageRef.child(uri).getDownloadURL();
    return imageUrl;
  }

  static Future<File> getImageCached(String uri)async
  {
    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = "${appDocDir.absolute.path}/images/$uri";
    // check if file exists
    if(await File(filePath).exists())
    {
      return File(filePath);
    }  
    var file = await File(filePath).create(recursive: true);

    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(uri);
    await imageRef.writeToFile(file);
    return file;
  }

  static String uploadFile(String filePath)
  {
    final storageRef = FirebaseStorage.instance.ref();
    final String fileID = Uuid().v4();
    final String extension = p.extension(filePath);
    // Create the file metadata
    final file = File(filePath);

    final uploadTask = storageRef
    .child("$fileID.$extension")
    .putFile(file);
    
    // Listen for state changes, errors, and completion of the upload.
uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
  switch (taskSnapshot.state) {
    case TaskState.running:
      final progress =
          100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
      debugPrint("Upload is $progress% complete.");
      break;
    case TaskState.paused:
      debugPrint("Upload is paused.");
      break;
    case TaskState.canceled:
      debugPrint("Upload was canceled");
      break;
    case TaskState.error:
      // Handle unsuccessful uploads
      break;
    case TaskState.success:
      // Handle successful uploads on complete
      // ...
      break;
  }
});

    return "$fileID.$extension";
  }
}