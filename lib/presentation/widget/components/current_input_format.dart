// import 'package:flutter/services.dart';

// import 'numberformattter.dart';

// class CurrencyInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     if (newValue.text.isNotEmpty) {
//       // final String intStr = NumberFormatter.numberFormatter(double );
//       final String intStr = NumberFormatter.numberFormatter(
//           double.tryParse(newValue.text.replaceAll(",", "")));
//       return TextEditingValue(
//         text: intStr,
//         selection: TextSelection.collapsed(offset: intStr.length),
//       );
//     } else {
//       return const TextEditingValue(
//         text: "",
//         selection: TextSelection.collapsed(offset: 0),
//       );
//     }
//   }
// }
