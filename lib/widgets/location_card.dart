import 'package:flutter/material.dart';
import 'package:help_together/core/storage.dart';
import 'package:help_together/core/string_extensions.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: StadiumBorder(),
      elevation: 9,
      child: ListTile(
        leading: IconButton(
          icon: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
          onPressed: () {},
        ),
        title: Text('Konum'),
        subtitle: Text(
          (Storage.getString('location') as String).capitalize,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon:
              Icon(Icons.change_history, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.of(context).pushNamed('/change-city'),
        ),
      ),
    );
  }
}
