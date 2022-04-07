import 'package:flutter/material.dart';

//from Totorial
/**this is use for create text field then we can easily call it through entire project.
 * This textField has properties.these properties get from the constructors
**/
class TextFieldInput extends StatelessWidget {
  final TextEditingController textController;
  final TextInputType textType;
  final String hint;

  //used for check pw or not
  final bool isPass;

  const TextFieldInput({
    Key? key,
    required this.textController,
    required this.textType,
    required this.hint,
    this.isPass = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: textController,
      keyboardType: textType,
      obscureText: isPass,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        //prefixIcon: Icon(Icons.account_circle),
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }
}
