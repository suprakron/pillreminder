import 'package:flutter/material.dart';

// Colors that we use in our app
const kPrimaryColor = Color.fromARGB(255, 54, 181, 212);
const kSecondaryColor = Color(0xFFFFFFFF);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF8F8F6);
const kIconColor = Color(0xFF2C5B59);
const kTextNoData = Color.fromARGB(255, 224, 224, 224);
const double kDefaultPadding = 20.0;

// icon
// const iconcapsule = 'assets/images/capsule.svg';
// const iconcream = 'assets/images/cream.svg';
// const iconsyrup = 'assets/images/syrup.svg';
// const iconpill = 'assets/images/pill.svg';

const iconPill = 'assets/pill.png';
const iconCapsule = 'assets/pills.png';
const iconbottle = 'assets/bottle.png';

const sizeLabel = 20.0;

List<String> category = ['PILL', 'CAPSULE', 'POTION'];

class Category {
  static const pill = "PILL";
  static const capsule = 'CAPSULE';
  static const potion = 'POTION';
}

class Eat {
  static const before = "BEFORE";
  static const after = 'AFTER';
}
