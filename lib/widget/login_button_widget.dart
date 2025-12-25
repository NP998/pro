import 'package:flutter/material.dart';

class LoginButtonWidget extends StatefulWidget {
  final String? buttonText;
  final ValueChanged<bool>? onPressed;
  const LoginButtonWidget({super.key,this.buttonText,this.onPressed});

  @override
  State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          // gradient: const LinearGradient(
          //   colors: [Colors.purple, Colors.blue],
          // ),
          color: Colors.deepPurple.shade600,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ElevatedButton(
          onPressed: () {
            widget.onPressed?.call(true);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text("${widget.buttonText}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
