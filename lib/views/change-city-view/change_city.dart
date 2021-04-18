import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help_together/core/storage.dart';
import 'package:help_together/services/language_service.dart';

class ChangeCity extends StatelessWidget {
  final GlobalKey<ScaffoldState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: rootScaffoldMessengerKey,
      backgroundColor: Color(0xffdedede),
      appBar: AppBar(
        title: Text(LanguageService.instance.translateWord('changeCity')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder(
          future: rootBundle.loadString('assets/json/provinces.json'),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                var data = jsonDecode(snapshot.data);
                return index <= 80
                    ? ListTile(
                        title: Text(data[index]),
                        trailing: IconButton(
                          tooltip: 'Bu ili seç',
                          onPressed: () {
                            Storage.saveString('location',
                                (data[index] as String).toLowerCase());
                            rootScaffoldMessengerKey.currentState.showSnackBar(
                                SnackBar(
                                    content: Text(
                                        '${data[index]} ili seçilmiştir')));
                          },
                          icon: Icon(Icons.done),
                        ),
                      )
                    : null;
              },
            );
          },
        ),
      ),
    );
  }
}
