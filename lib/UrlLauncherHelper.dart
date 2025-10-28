import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  // Constructor privado para evitar instancias
  UrlLauncherHelper._();

  /// Abre una URL en el navegador o app externa
  /// 
  /// Ejemplo:
  /// ```dart
  /// await UrlLauncherHelper.launchURL('https://google.com');
  /// ```
  static Future<bool> launchURL(
    String url, {
    LaunchMode mode = LaunchMode.externalApplication,
    BuildContext? context,
    bool showErrorDialog = true,
  }) async {
    try {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: mode);
        return true;
      } else {
        if (context != null && showErrorDialog) {
          _showErrorDialog(context, 'No se puede abrir la URL: $url');
        }
        return false;
      }
    } catch (e) {
      if (context != null && showErrorDialog) {
        _showErrorDialog(context, 'Error al abrir URL: $e');
      }
      debugPrint('Error launching URL: $e');
      return false;
    }
  }

  /// Abre un email con asunto y cuerpo opcionales
  /// 
  /// Ejemplo:
  /// ```dart
  /// await UrlLauncherHelper.launchEmail(
  ///   'correo@ejemplo.com',
  ///   subject: 'Hola',
  ///   body: 'Mensaje aquí',
  /// );
  /// ```
  static Future<bool> launchEmail(
    String email, {
    String? subject,
    String? body,
    BuildContext? context,
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );

    return await launchURL(
      emailUri.toString(),
      context: context,
    );
  }

  /// Abre un número de teléfono
  /// 
  /// Ejemplo:
  /// ```dart
  /// await UrlLauncherHelper.launchPhone('+573001234567');
  /// ```
  static Future<bool> launchPhone(
    String phoneNumber, {
    BuildContext? context,
  }) async {
    final String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    return await launchURL(
      'tel:$cleanPhone',
      context: context,
    );
  }

  /// Abre WhatsApp con un número
  /// 
  /// Ejemplo:
  /// ```dart
  /// await UrlLauncherHelper.launchWhatsApp(
  ///   '+573001234567',
  ///   message: 'Hola!',
  /// );
  /// ```
  static Future<bool> launchWhatsApp(
    String phoneNumber, {
    String? message,
    BuildContext? context,
  }) async {
    final String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final String encodedMessage = message != null 
        ? Uri.encodeComponent(message) 
        : '';
    
    return await launchURL(
      'https://wa.me/$cleanPhone?text=$encodedMessage',
      context: context,
    );
  }

  /// Abre un SMS
  /// 
  /// Ejemplo:
  /// ```dart
  /// await UrlLauncherHelper.launchSMS(
  ///   '+573001234567',
  ///   message: 'Hola!',
  /// );
  /// ```
  static Future<bool> launchSMS(
    String phoneNumber, {
    String? message,
    BuildContext? context,
  }) async {
    final String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: cleanPhone,
      queryParameters: message != null ? {'body': message} : null,
    );

    return await launchURL(
      smsUri.toString(),
      context: context,
    );
  }

  /// Abre Google Maps con coordenadas o dirección
  /// 
  /// Ejemplo:
  /// ```dart
  /// // Con coordenadas
  /// await UrlLauncherHelper.launchMaps(
  ///   latitude: 2.4448,
  ///   longitude: -76.6147,
  /// );
  /// 
  /// // Con dirección
  /// await UrlLauncherHelper.launchMaps(
  ///   address: 'Popayán, Cauca, Colombia',
  /// );
  /// ```
  static Future<bool> launchMaps({
    double? latitude,
    double? longitude,
    String? address,
    BuildContext? context,
  }) async {
    String url;

    if (latitude != null && longitude != null) {
      url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    } else if (address != null) {
      final encodedAddress = Uri.encodeComponent(address);
      url = 'https://www.google.com/maps/search/?api=1&query=$encodedAddress';
    } else {
      if (context != null) {
        _showErrorDialog(context, 'Debes proporcionar coordenadas o dirección');
      }
      return false;
    }

    return await launchURL(url, context: context);
  }

  /// Abre una app en la Play Store o App Store
  /// 
  /// Ejemplo:
  /// ```dart
  /// await UrlLauncherHelper.launchStore(
  ///   androidPackageId: 'com.example.app',
  ///   iosAppId: '123456789',
  /// );
  /// ```
  static Future<bool> launchStore({
    String? androidPackageId,
    String? iosAppId,
    BuildContext? context,
  }) async {
    // Detectar plataforma (podrías usar Platform.isAndroid/isIOS)
    // Por ahora, priorizo Android
    if (androidPackageId != null) {
      return await launchURL(
        'https://play.google.com/store/apps/details?id=$androidPackageId',
        context: context,
      );
    } else if (iosAppId != null) {
      return await launchURL(
        'https://apps.apple.com/app/id$iosAppId',
        context: context,
      );
    }

    return false;
  }

  /// Muestra un diálogo de error
  static void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
