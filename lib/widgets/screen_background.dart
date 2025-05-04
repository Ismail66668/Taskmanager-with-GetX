// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/assets_path.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          height: double.maxFinite,
          width: double.maxFinite,
          AssetsPath.bacgroundImgSVG,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child)
      ],
    );
  }
}
