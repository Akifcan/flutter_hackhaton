import 'package:flutter/material.dart';

class AppUploadImageButton extends StatelessWidget {
  final VoidCallback voidCallback;
  const AppUploadImageButton({Key key, this.voidCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.deepOrange,
      width: double.infinity,
      child: InkWell(
          child: Center(
              child: Text('Fotoğraf Yükle',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.white))),
          onTap: this.voidCallback),
    );
  }
}
