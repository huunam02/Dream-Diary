import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) hexColor = "FF$hexColor";
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class GlobalColors {
  /// Ánh bình minh tím → xanh trời (dùng cho CTA, header)
  static const LinearGradient linearPrimary1 = LinearGradient(
    colors: [
      Color(0xFFA78BFA), // Lavender
      Color(0xFF60A5FA), // Sky blue
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Phông nền nhẹ cho container/card ở Light mode
// Ấm hơn nhưng vẫn mộng mơ
  static const LinearGradient linearContainer2 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFEEF7), // hồng sương sớm
      Color(0xFFF5E6FF), // tím phấn ấm
    ],
    stops: [0.0, 1.0],
  );

  /// Viền/overlay nhẹ: hồng sương mai → lam mây
  static const LinearGradient linearPrimary2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFBCFE8), // Soft pink
      Color(0xFFC7D2FE), // Periwinkle
    ],
    stops: [0.0, 1.0],
  );

  /// Chữ/trang trí trên nền tối (trắng dịu để đỡ chói)
  static Color primary2 = Colors.white.withOpacity(0.85);

  /// Điểm nhấn “ánh trăng” (icon nhỏ, sao lấp lánh)
  static const Color primary3 = Color(0xFFFDE68A); // Moonlight amber

  // (Tuỳ chọn) Một số màu bổ sung nếu cần:
// NỀN CHÍNH SÁNG HƠN, DỄ “BẮT” VÀO MẮT
  static const Color bgLight = Color(0xFFEAF0FF); // trước là F7F7FB

  static const Color bgDark = Color(0xFF0F1526); // nền app dark
  static const Color textPrimary = Color(0xFFECEBFF); // chữ chính trên dark
  static const Color textMuted = Color(0xFF9AA5C4); // chữ phụ trên dark
  static const Color danger = Color(0xFFFF6B6B); // cảnh báo/ lỗi
}
