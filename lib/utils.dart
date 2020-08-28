import 'dart:async';
import 'dart:io';

import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant.dart';

String getShortNotes(String note) =>
    note.substring(0, (note.length > 26) ? 27 : note.length - 1) + "...";
PageRoute routeAnimRoute(Widget target) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => target,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.elasticOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

alertDialogCreate({String msg, Function yesFunct}) => AlertDialog(
      title: Text('Peringatan!'),
      content: Text(msg ?? ''),
      actions: [
        FlatButton(onPressed: () {}, child: Text("Tidak")),
        FlatButton(onPressed: () => yesFunct, child: Text("Ya"))
      ],
    );

emailValidator(String email) {
  if (email.contains('@')) {
    if (email.split('@')[1].contains('.')) {
      return true;
    }
  }
  return false;
}

delayMethod(int delayMillis, Function method) async {
  return Timer(Duration(milliseconds: delayMillis), method);
}

createSnackBar(String msg) => SnackBar(
      content: Container(
        height: 30,
        child: Center(child: Text(msg)),
      ),
      backgroundColor: secondaryBLue.withOpacity(0.9),
    );
createTitle() => Text('Notto',
    style:
        GoogleFonts.rosario(color: Colors.amber, fontWeight: FontWeight.bold));
createTextField(TextEditingController controller, String label, IconData icon,
        {bool isObscure}) =>
    TextFormField(
        controller: controller,
        obscureText: isObscure ?? false,
        decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            border: UnderlineInputBorder(),
            hintText: ' $label'));

bool isTimeOut(SocketException e) =>
    e.osError.message.contains('Connection timed out');
