import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DbResultItem extends StatelessWidget {
  final dynamic title;
  final dynamic magnet;

  const DbResultItem({
    super.key,
    required this.title,
    required this.magnet,
  });

  void onCopyPressed(String magnet) {
    Clipboard.setData(ClipboardData(text: magnet));
    Fluttertoast.showToast(
        msg: "Magnet copied to clipboard",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      magnet,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                        icon: Icon(Icons.copy, size: 20.0),
                        onPressed: () => onCopyPressed(magnet)
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
