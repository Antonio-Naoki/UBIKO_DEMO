import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/config/theme/app_colors.dart';

Future<BitmapDescriptor> createUserMarker() async {
  const int width = 80;
  const int height = 100;
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(recorder);
  final Paint paint = Paint();

  // 📍 Crear la forma de pin de Google Maps
  final Path pinPath = Path();
  
  // Parte circular superior del pin
  const double circleRadius = 25.0;
  const Offset circleCenter = Offset(width / 2, circleRadius + 5);
  
  // Dibujar el pin completo (forma de gota)
  pinPath.addOval(Rect.fromCircle(center: circleCenter, radius: circleRadius));
  
  // Punta del pin (más suave)
  const double tipWidth = 16.0;
  pinPath.moveTo(circleCenter.dx - tipWidth/2, circleCenter.dy + circleRadius - 5);
  pinPath.quadraticBezierTo(
    circleCenter.dx, circleCenter.dy + circleRadius + 15, // punto de control
    width / 2, height - 5, // punto final
  );
  pinPath.quadraticBezierTo(
    circleCenter.dx, circleCenter.dy + circleRadius + 15, // punto de control
    circleCenter.dx + tipWidth/2, circleCenter.dy + circleRadius - 5, // punto final
  );
  pinPath.close();

  // 🔵 Fondo azul del pin
  paint.color = AppColors.primaryColor;
  canvas.drawPath(pinPath, paint);

  // ⚪ Círculo blanco interior
  paint.color = AppColors.primaryTextColor;
  canvas.drawCircle(circleCenter, circleRadius - 4, paint);

  // 🖼️ Imagen en el centro del círculo
  try {
    final image = await _loadImage('assets/images/imagen_user.webp');
    final double imageRadius = circleRadius - 6;
    
    // Guardar el estado del canvas
    canvas.save();
    
    // Crear clip circular para la imagen
    final Path clipPath = Path()
      ..addOval(Rect.fromCircle(center: circleCenter, radius: imageRadius));
    canvas.clipPath(clipPath);
    
    // Dibujar la imagen
    paintImage(
      canvas: canvas,
      rect: Rect.fromCircle(center: circleCenter, radius: imageRadius),
      image: image,
      fit: BoxFit.cover,
    );
    
    // Restaurar el estado del canvas
    canvas.restore();
    
  } catch (e) {
    // Si no se puede cargar la imagen, usar un icono de persona
    final TextPainter textPainter = TextPainter(
      text: const TextSpan(
        text: '👤',
        style: TextStyle(
          fontSize: 20,
          color: AppColors.primaryCircleUser,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        circleCenter.dx - textPainter.width / 2,
        circleCenter.dy - textPainter.height / 2,
      ),
    );
  }

  final ui.Picture picture = recorder.endRecording();
  final ui.Image img = await picture.toImage(width, height);
  final ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.bytes(byteData!.buffer.asUint8List());
}

Future<ui.Image> _loadImage(String path) async {
  final ByteData data = await rootBundle.load(path);
  final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  final ui.FrameInfo frame = await codec.getNextFrame();
  return frame.image;
}