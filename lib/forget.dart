import 'package:flutter/material.dart';
import 'package:m/bnv.dart';
import 'package:m/book_flight.dart';
import 'package:m/info.dart';
import 'package:m/screen.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'logic.dart';

class ListWithTitle extends StatelessWidget {
  String title;
  bool containScaffold;
  EdgeInsetsGeometry edgeInsetsGeometry;
  PreferredSize appBar;
  List<Widget> body;
  bool havePadding;
  ListWithTitle(this.title, this.body,
      {this.containScaffold = true, this.appBar, this.havePadding = true});
  @override
  Widget build(BuildContext context) {
    return containScaffold
        ? SafeArea(
            child: Scaffold(appBar: this.appBar, body: MyBody(title, body)))
        : MyBody(title, body);
  }
}

class MyBody extends StatelessWidget {
  String title;
  List<Widget> body;
  bool havePadding;
  MyBody(this.title, this.body, {this.havePadding = true});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    Screen screen = Provider.of<Screen>(context);

    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: screen.heightConverter(45),
        top: screen.heightConverter(45),
        right: havePadding ? screen.widthConverter(20.5) : 0,
        left: screen.widthConverter(20.5),
      ),
      children: [
        Text(
          title,
          style: textTheme.display2,
        ),
        Padding(padding: EdgeInsets.only(bottom: screen.heightConverter(23))),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: body,
        ),
      ],
    );
  }
}

class UserRegistirationRoot extends StatelessWidget {
  Widget body;
  String buttonText;
  Color buttonColor;
  Widget extra;
  VoidCallback buttonAction;
  String title;
  Color textColor;

  bool havePadding;
  UserRegistirationRoot(
      this.title, this.body, this.buttonText, this.buttonAction,
      {this.havePadding = true,
      this.extra,
      this.buttonColor = const Color(0xff005C15),
      this.textColor});
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of<Screen>(context);

    return ListWithTitle(
      title,
      [
        body,
        Padding(
            padding: EdgeInsets.only(
                right: 0,
                top: screen.heightConverter(50),
                bottom: screen.heightConverter(20),
                left: 0),
            child: MyFlatButton(
              onTap: buttonAction,
              color: buttonColor,
              text: buttonText,
              textColor: this.textColor,
            )),
        Center(child: extra ?? SizedBox.shrink())
      ],
      havePadding: this.havePadding,
    );
  }
}

class ForgetPassword extends StatelessWidget {
  static const route = 'forget';
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return UserRegistirationRoot(
      'Reset password',
      Column(
        children: <Widget>[
          MyTextField('Email Address'),
        ],
      ),
      'Reset your password',
      () {},
    );
  }
}
