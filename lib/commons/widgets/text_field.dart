import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:provider/provider.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final Widget trailling;
  final TextEditingController controller;
  final EdgeInsetsGeometry contentPadding;
  final Color color;
  final TextInputType keyboardType;
  final List<BoxShadow> shadow;
  final Widget prefixIcon;
  final ValueChanged<String> onChanged;
  final VoidCallback onTap;
  final bool readOnly, obscureText;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final VoidCallback onTapTrailling;
  final TextDirection textDirection;
  final String helperText;
  final double paddingRight;
  final Widget suffix;
  MyTextField(this.hintText,
      {this.contentPadding,
      this.trailling,
      this.suffix,
      this.helperText,
      this.textDirection,
      this.onTapTrailling,
      this.obscureText = false,
      this.controller,
      this.inputFormatters,
      this.paddingRight,
      this.onTap,
      this.onChanged,
      this.keyboardType,
      this.color = const Color(0xfff3f3f4),
      this.shadow,
      this.validator,
      this.readOnly = false,
      this.prefixIcon});
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screen.heightConverter(10)),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: shadow,
            borderRadius: BorderRadius.all(
                Radius.circular(screen.aspectRatioConverter(10)))),
        child: Stack(
          //  fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Colors.transparent,
              child: TextFormField(
                  textDirection: this.textDirection,
                  // toolbarOptions: ToolbarOptions(),
                  obscureText: this.obscureText,
                  textAlignVertical: TextAlignVertical.center,
                  controller: this.controller,
                  inputFormatters: this.inputFormatters,
                  keyboardType: this.keyboardType,
                  onChanged: this.onChanged,
                  validator: (text) {
                    if (text.isEmpty) {
                      return Localization.of(context).auth[9];
                    }
                    if (this.validator != null) {
                      return this.validator(text);
                    }
                    return null;
                  },
                  onTap: onTap,
                  toolbarOptions: ToolbarOptions(),
                  // scrollPadding: this.contentPadding,
                  readOnly: readOnly,
                  decoration: InputDecoration(
                    suffix: this.suffix,
                    // errorBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(color: Colors.red),
                    //     borderRadius: BorderRadius.all(
                    //         Radius.circular(screen.aspectRatioConverter(10)))),
                    helperText: this.helperText,
                    prefixIcon: prefixIcon,
                    errorStyle: textTheme.subtitle,
                    contentPadding: this.contentPadding,

                    hintText: this.hintText,
                    fillColor: this.color,
                    filled: true,
                    hintStyle: textTheme.body1.copyWith(
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8B8C98),
                        fontSize: ScreenUtil().setSp(14)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                            Radius.circular(screen.aspectRatioConverter(10)))),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
// Positioned.fill(
//   child: Align(
//     alignment: Localization.of(context).locale.languageCode == 'ar'
//         ? Alignment.topLeft
//         : Alignment.topRight,
//     child: GestureDetector(
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             vertical: contentPadding.vertical /
//                     screen.heightConverter(1.33) ??
//                 0,
//             horizontal: screen.widthConverter(20)),
//         child: trailling,
//       ),
//       onTap: onTapTrailling,
//     ),
//   ),
// )
/*
          Positioned.fill(
              child: Align(
                  alignment:
                      Localization.of(context).locale.languageCode == 'ar'
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                  child: trailling),
            )
             Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: contentPadding.horizontal *
                          screen.widthConverter(0.),
                      vertical: contentPadding.vertical *
                          screen.heightConverter(0.4)),
                  child: GestureDetector(
                    child: trailling,
                    onTap: onTapTrailling,
                  ),
                ),
              ),
            )
*/
