import 'package:flutter/material.dart';

InputDecoration inputtext(String label) => InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 156, 156, 156),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Colors.red),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Colors.orange),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Colors.green),
      ),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
          )),
      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.black)),
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.yellowAccent)),
      labelText: label,
    );

const TextStyle heading1style = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w100,
);
const TextStyle heading2style = TextStyle(
  fontSize: 31,
  fontWeight: FontWeight.w200,
);
const TextStyle heading3style = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w300,
);
const TextStyle heading4style = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w400,
);
const TextStyle bodytextstyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w500,
);
const TextStyle bodyinputstyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w900,
);
