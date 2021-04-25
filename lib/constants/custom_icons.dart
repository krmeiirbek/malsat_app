import 'package:flutter/widgets.dart';

class Custom {
  Custom._();

  static const _kFontFam = 'Custom';
  static const String _kFontPkg = null;

  static const IconData heart_empty =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData home =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData user =
      IconData(0xe82a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData comment =
      IconData(0xf4ac, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
