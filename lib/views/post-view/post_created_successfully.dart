import 'package:flutter/material.dart';

class PostCreatedSuccessfully extends StatelessWidget {
  final String title;
  const PostCreatedSuccessfully(
      {Key key, this.title = 'Paylaşımınız Oluşturulmuştur'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/gifs/success.gif'),
            Text(this.title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    padding: const EdgeInsets.all(20)),
                child: Text(
                  'Ana Sayfa',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.white),
                ),
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('/home'))
          ],
        ),
      )),
    );
  }
}
