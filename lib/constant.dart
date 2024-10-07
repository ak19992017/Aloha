import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class SuperbaseCredentials {
  static const String url = "https://kapnkypovldoarardosa.supabase.co";
  static const String key =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImthcG5reXBvdmxkb2FyYXJkb3NhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODY3NDYwODEsImV4cCI6MjAwMjMyMjA4MX0.Q58r_x_o6harkCTKUY-dEKDCiqfe4bdf317mJMu_N9c";

  static SupabaseClient supabaseClient = SupabaseClient(url, key);
}

Color giveCategoryGetColor(String e) {
  if (e == 'home') {
    return Colors.redAccent;
  } else if (e == 'work') {
    return Colors.greenAccent.shade700;
  } else if (e == 'code') {
    return Colors.blueAccent;
  } else if (e == 'play') {
    return Colors.amberAccent.shade700;
  }
  return Colors.grey;
}

List<String> folderList = ["home", "work", "code", "play"];

List<String> imageList = [
  'pencil.png',
  'travel.png',
  'takeaway-cup.png',
  'rocket.png'
];

// PrimaryColor is of type Color
// PrimarySwatch only accepts a MaterialColor.
// We’ll create a cool function that will get a MaterialColor from a Color.
// MaterialColor is a color with a primary value (first param; int),
// and 10 shades of that color (second param; Map<int, Color>) with the int map key as the shade index

// (Important)Shade with index 500 is the primary color of that material color.
// So we needed to find a way to get darker and lighter shades of a certain color to create all the shades.

class AppColors {
  static List<Color> primaryColors = const [
    Color(0xffff5252),
    Color(0xff00c853),
    Color(0xff448aff),
    Color(0xffffab00),
  ];

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static MaterialColor getMaterialColorFromColor(Color color) {
    Map<int, Color> colorShades = {
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color,
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }
}
