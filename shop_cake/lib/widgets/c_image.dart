import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';

class CImage extends StatefulWidget {
  final String? assetsPath;
  final String? assetsNetworkUrl;
  final String? svgPath;
  final String? svgNetworkUrl;
  final double? radius;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final Color? color;

  const CImage({
    Key? key,
    this.assetsPath,
    this.assetsNetworkUrl,
    this.width,
    this.height,
    this.radius,
    this.boxFit,
    this.color,
    this.svgPath,
    this.svgNetworkUrl,
  }) : super(key: key);
  @override
  _CImageState createState() => _CImageState();
}

class _CImageState extends State<CImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (() {
        if (widget.assetsPath != null) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius ?? 0),
              child: Image.asset(
                widget.assetsPath ?? '',
                height: widget.height,
                width: widget.width,
                color: widget.color,
                fit: widget.boxFit ?? BoxFit.fill,
              ));
        } else {
          return SvgPicture.asset(
            widget.svgPath ?? '',
            width: widget.width,
            height: widget.height,
            fit: widget.boxFit ?? BoxFit.fill,
            color: widget.color,
          );
        }
      }()),
    );
  }
}
