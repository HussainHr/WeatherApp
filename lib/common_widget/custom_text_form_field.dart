import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final double topHeight;
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?) validator;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final void Function()? onFieldSubmitted;
  final FocusNode? nextFocusNode;
  final TextInputAction? textInputAction;

  const CustomTextFormField({
    Key? key,
    required this.topHeight,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.validator,
    this.suffixIcon,
    this.focusNode,
    this.onFieldSubmitted,
    this.nextFocusNode,
    this.textInputAction,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.topHeight,
        left: 20,
        right: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: TextFormField(
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          focusNode: _focusNode,
          cursorColor: Colors.green,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,
            hintStyle: const TextStyle(fontSize: 12),
            labelStyle: const TextStyle(color:Colors.blue, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color:Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: widget.suffixIcon,
          ),
          validator: widget.validator,
          onFieldSubmitted: (_) {
            if (widget.nextFocusNode != null) {
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            } else {
              // widget.controller.clear(); // Clear the text in the last field
              // _focusNode.unfocus(); // Unfocus the last field
            }

            if (widget.onFieldSubmitted != null) {
              widget.onFieldSubmitted!();
            }
          },
        ),
      ),
    );
  }
}
