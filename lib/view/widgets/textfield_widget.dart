import 'package:flutter/material.dart';



Widget textField(
    {
     required BuildContext context,
      required TextEditingController controller,
      required GlobalKey<FormState> formKey,
      required String lable,
      required EdgeInsetsGeometry edgeInsetsGeometry,
      TextInputType inputType = TextInputType.emailAddress,
      bool obscureText = false,Widget? suffix}) {
  return Padding(
      padding: edgeInsetsGeometry,
      child: Form(
        key: formKey,
        child: TextFormField(
          onTapOutside: (event)=>FocusScope.of(context).unfocus(),
            obscureText: obscureText,
            keyboardType: inputType,
            validator: (value) {
              if (value!.isEmpty) {
                return "this item required";
              } else if (value.length < 4) {
                return "item less than 4 characters ";
              } else {
                return null;
              }
            },
            controller: controller,
            focusNode: FocusNode(),
            decoration: InputDecoration(
                labelText: lable,
                suffix: suffix,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                )
            )
        ),
      ));
}