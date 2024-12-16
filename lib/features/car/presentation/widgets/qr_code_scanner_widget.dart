import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rahnegar/theme/app_themes.dart';

class QrCodeScannerWidget extends StatelessWidget {
  QrCodeScannerWidget({super.key,required this.onDetect});
  Function(String) onDetect;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:MobileScanner(
          overlayBuilder: (BuildContext context, BoxConstraints box) {

            return
              Center(
                child: CustomPaint(
                  foregroundPainter: BorderPainter(
                      height: MediaQuery.of(context).size.width-100,
                      width: MediaQuery.of(context).size.width-100,
                      borderColor: lightPrimaryColor,
                      borderWidth: 5
                  ),
                ),
              );
          },
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            onDetect(barcodes[0].displayValue!);
            Get.back();
          },
        )
    );
  }
}


class BorderPainter extends CustomPainter {
  BorderPainter({required this.width,required this.height,this.borderWidth = 2,this.borderColor=Colors.white});
  double width,height;
  double borderWidth;
  Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    double sh = height;
    double sw = width;
    double cornerSide = sh * 0.2; // Adjust this value for desired corner curvature
    canvas.translate((size.width - sw) / 2, (size.height - sh) / 2);
    Paint paint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}
