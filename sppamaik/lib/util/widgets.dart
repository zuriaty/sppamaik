import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextStyle SubHeader() {
  return TextStyle(
    color: Colors.blueGrey,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
  );
}

Widget buildSizedBox() {
  return SizedBox(height: 8.0);
}

InputDecoration buildInputDecoration() {
  return InputDecoration(
    contentPadding: EdgeInsets.all(10.0),
    isDense: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black26, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black26, width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
  );
}

TextFormField buildTextFormFieldUpperCase(int length,
    TextEditingController inputName, String inputAlert, String val) {
  return TextFormField(
    initialValue: val,
    controller: inputName,
    decoration: buildInputDecoration(),
    textCapitalization: TextCapitalization.characters,
    style: textStyleInput(),
    inputFormatters: [
      LengthLimitingTextInputFormatter(length),
    ],
    validator: (value) {
      if (inputAlert != '') {
        if (value!.isEmpty) {
          return 'Maklumat $inputAlert diperlukan';
        } else {
          return null;
        }
      }
      return null;
    },
    onSaved: (value) {
      inputName.text = value!;
    },
  ); // OUTPUT : FLUTTER CODE CAMP
}

TextStyle textStyleInput() {
  return TextStyle(fontWeight: FontWeight.normal, fontSize: 12);
}

TextFormField buildTextFormFieldLowerCase(
    int length, TextEditingController inputName, String inputAlert) {
  return TextFormField(
    controller: inputName,
    style: textStyleInput(),
    decoration: buildInputDecoration(),
    textCapitalization: TextCapitalization.none,
    inputFormatters: [
      LengthLimitingTextInputFormatter(length),
    ],
    validator: (value) {
      if (inputAlert != '') {
        if (value!.isEmpty) {
          return 'Maklumat $inputAlert diperlukan';
        } else {
          return null;
        }
      }
      return null;
    },
    onSaved: (value) {
      inputName.text = value!;
    },
  ); // OUTPUT : flutter code camp
}

TextFormField buildTextFormFieldWordCase(
    int length, TextEditingController inputName, String inputAlert) {
  return TextFormField(
    controller: inputName,
    style: textStyleInput(),
    decoration: buildInputDecoration(),
    textCapitalization: TextCapitalization.words,
    inputFormatters: [
      LengthLimitingTextInputFormatter(length),
    ],
    validator: (value) {
      if (inputAlert != '') {
        if (value!.isEmpty) {
          return 'Maklumat $inputAlert diperlukan';
        } else {
          return null;
        }
      }
      return null;
    },
    onSaved: (value) {
      inputName.text = value!;
    },
  ); // OUTPUT : Flutter Code Camp
}

TextFormField buildTextFormFieldSenCase(
    int length, TextEditingController inputName, String inputAlert, Stri) {
  return TextFormField(
    controller: inputName,
    style: textStyleInput(),
    decoration: buildInputDecoration(),
    textCapitalization: TextCapitalization.sentences,
    inputFormatters: [
      LengthLimitingTextInputFormatter(length),
    ],
    validator: (value) {
      if (inputAlert != '') {
        if (value!.isEmpty) {
          return 'Maklumat $inputAlert diperlukan';
        } else {
          return null;
        }
      }
      return null;
    },
    onSaved: (value) {
      inputName.text = value!;
    },
  ); // OUTPUT : Flutter code camp
}

TextFormField buildTextFormFieldNumber(int length,
    TextEditingController inputName, String inputAlert, String val) {
  return TextFormField(
    controller: inputName,
    initialValue: val,
    style: textStyleInput(),
    decoration: buildInputDecoration(),
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(length),
    ],
    validator: (value) {
      if (inputAlert != '') {
        if (value!.isEmpty) {
          return 'Maklumat $inputAlert diperlukan';
        } else {
          return null;
        }
      }
      return null;
    },
    onSaved: (value) {
      inputName.text = value!;
    },
  ); // OUTPUT : Flutter code camp
}

// Only numbers can be entered
@override
// TODO: implement widget
Widget builtText(String text) => Container(
      margin: EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: Text(
        text,
        style: textStyleInput(),
      ),
    );
