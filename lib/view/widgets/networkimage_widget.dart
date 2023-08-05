import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'imageloading_widget.dart';
Widget networkImage({required String imageUrl, double? width, double? height}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: BoxFit.cover,
    width: width,
    height: height,
    placeholder: (context, url) {
      return imageLoading();
    },
  //  errorWidget:Icon(Icons.error) ,
  );
}
