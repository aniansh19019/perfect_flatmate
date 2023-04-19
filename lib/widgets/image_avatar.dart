import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../services/storage.dart';

class ImageAvatar extends StatelessWidget 
{
  final String imageUri;
  final double radius;
  const ImageAvatar({super.key, required this.imageUri, this.radius = 70});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
                    future: Storage.getImageCached(imageUri),
                    builder: (context, snapshot)
                    {
                      if (snapshot.hasData)
                      {
                        return CircleAvatar(radius: radius, 
                        backgroundImage: FileImage(snapshot.data!)
                        );
                      }
                      else if(snapshot.hasError)
                      {
                        debugPrint(snapshot.error.toString());
                        return CircleAvatar(radius: radius, child: Icon(Icons.error),);
                      }
                      else
                      {
                        return CircleAvatar(radius: radius, child: CircularProgressIndicator(),);
                      }
                    });
  }
}