import 'package:flutter/material.dart';

class AppDonateInfo extends StatelessWidget {
  final int goal, available;
  const AppDonateInfo({Key key, this.goal, this.available}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Hedef: ',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.normal),
          ),
          Text(
            this.goal.toString() + '₺',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Mevcut: ',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.normal),
          ),
          Text(
            this.available.toString() + '₺',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
