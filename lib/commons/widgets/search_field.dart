import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:provider/provider.dart';

import 'text_field.dart';

class MySearchTextField extends StatelessWidget {
  final bool readOnly;
  final VoidCallback onTap;
  final ValueChanged<String> onChanged;

  final TextEditingController controller;
  final EdgeInsetsGeometry edgeInsetsGeometry;
  MySearchTextField(
      {this.readOnly = true,
      this.onTap,
      this.onChanged,
      this.edgeInsetsGeometry,
      this.controller});

  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);

    return MyTextField(
      'Search',
      controller: this.controller,
      onChanged: this.onChanged,
      onTap: onTap,
      readOnly: readOnly,
      contentPadding: this.edgeInsetsGeometry,
      color: Colors.white,
      shadow: [
        BoxShadow(
            blurRadius: (10), spreadRadius: (0), color: Color(0xffC9D1DC)),
      ],
      prefixIcon: Icon(
        FontAwesomeIcons.search,
        size: screen.heightConverter(12),
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
