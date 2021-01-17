import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowMessage {
  ShowMessage(BuildContext context, {@required BuildContext ctx, @required String message, Color backgroundColor}) {
    _showMessage(ctx, message, backgroundColor);
  }

  ScaffoldFeatureController _showMessage(
      BuildContext context, String message, Color color) {
    widgetsFinishedBuilding(() {
      return Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: color,
      ));
    });
  }

  void widgetsFinishedBuilding(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
