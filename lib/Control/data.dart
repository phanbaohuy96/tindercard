import 'package:flutter/material.dart';

List data = [image1, image2, image3];

DecorationImage image1 = new DecorationImage(
  image: new ExactAssetImage('data/images/2.JPG'),
  fit: BoxFit.cover,
);
DecorationImage image2 = new DecorationImage(
  image: new ExactAssetImage('data/images/1.JPG'),
  fit: BoxFit.cover,
);

DecorationImage image3 = new DecorationImage(
  image: new ExactAssetImage('data/images/3.JPG'),
  fit: BoxFit.cover,
);