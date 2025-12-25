import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String? title;
  final String? hintText;
  final String? initialValue;
  final ValueChanged<String>? onPressed;
  const TextFieldWidget({super.key,this.title,this.hintText,this.initialValue,this.onPressed});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final TextEditingController _controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title??"",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        TextFormField(
          initialValue: widget.initialValue,
          controller: _controller,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          onChanged: (value){
            widget.onPressed?.call(value);
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.grey.shade100,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 10,
            ),

            // Default border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),

            // Focused border
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Colors.pink,
                width: 2,
              ),
            ),

            // Error border
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "${widget.hintText}";
            }
            return null;
          },
        ),
      ],
    );

  }
}
