import 'package:flutter/cupertino.dart';

void showAlertDialog(context,
    {String? title,
    String? description,
    Function()? onOk,
    bool canDissmisable = true}) {
  showCupertinoModalPopup<void>(
    context: context,
    barrierDismissible: canDissmisable,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title ?? 'Alert'),
      content: Text(description ?? 'Proceed with destructive action?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Tidak'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: onOk,
          child: const Text('Ya'),
        ),
      ],
    ),
  );
}

void showAlertDialogUpdate(context,
    {String? title,
    String? description,
    Function()? onOk,
    bool canDissmisable = true}) {
  showCupertinoModalPopup<void>(
    context: context,
    barrierDismissible: canDissmisable,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title ?? 'Alert'),
      content: Text(description ?? 'Proceed with destructive action?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: onOk,
          child: const Text('Download'),
        ),
      ],
    ),
  );
}
