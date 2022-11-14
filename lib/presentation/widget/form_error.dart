import 'package:flutter/material.dart';
import 'package:fmbp/presentation/common/export_common.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: List.generate(
            errors.length, (index) => formErrorText(error: errors[index]!)),
      ),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        Image.asset(
          'assets/icon/error.png',
          height: 20,
          width: 20,
          color: Colors.red,
        ),
        const SizedBox(
          width: 14,
        ),
        Flexible(
          child: Text(
            error,
            style: styleTextError,
          ),
        ),
      ],
    );
  }
}
