import 'dart:async';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_my_way/model/flex.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> widgetToBitmap(
  GlobalKey globalKey, {
  Size? size,
}) async {
  final completer = Completer<BitmapDescriptor>();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      completer.complete(BitmapDescriptor.fromBytes(
        byteData.buffer.asUint8List(),
        size: size,
      ));
    } else {
      completer.completeError('Failed to capture image.');
    }
  });
  return completer.future;
}

class CustomMarkerWidget extends StatelessWidget {
  const CustomMarkerWidget({
    required this.flex,
    required this.globalKey,
    this.isBroadcast = false,
    super.key,
  });

  final Flexes flex;
  final bool isBroadcast;
  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RepaintBoundary(
      key: globalKey,
      child: Container(
        color: transparentColor,
        height: 80,
        width: 160,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.none,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: greyColor.withOpacity(0.4),
                    ),
                    child: CachedNetworkImage(
                      alignment: Alignment.topCenter,
                      imageUrl: flex.bannerImage!.first,
                      width: 20,
                      height: 20,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: greyColor.withOpacity(0.4),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        flex.name ?? '',
                        maxLines: 1,
                        style: textTheme.bodySmall!.copyWith(
                          fontSize: 11,
                          color: neutralColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isBroadcast == true)
              Align(
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: const Offset(61, 9),
                  child: SvgPicture.asset(
                    broadcastImage,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            Positioned(
              bottom: 1,
              child: Transform.translate(
                offset: const Offset(-10, -5),
                child: CustomPaint(
                  size: const Size(16.15, 18.86),
                  painter: RPSCustomPainter(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5467400, size.height * 0.9518714);
    path_0.cubicTo(
        size.width * 0.5205257,
        size.height * 1.004907,
        size.width * 0.4448836,
        size.height * 1.004907,
        size.width * 0.4186693,
        size.height * 0.9518714);
    path_0.lineTo(size.width * 0.03421600, size.height * 0.1739557);
    path_0.cubicTo(
        size.width * 0.01075436,
        size.height * 0.1264829,
        size.width * 0.04529729,
        size.height * 0.07088036,
        size.width * 0.09825143,
        size.height * 0.07088036);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.07088036);
    path_0.lineTo(size.width * 0.8671571, size.height * 0.07088036);
    path_0.cubicTo(
        size.width * 0.9201143,
        size.height * 0.07088036,
        size.width * 0.9546571,
        size.height * 0.1264829,
        size.width * 0.9311929,
        size.height * 0.1739557);
    path_0.lineTo(size.width * 0.5467400, size.height * 0.9518714);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = whiteColor;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
