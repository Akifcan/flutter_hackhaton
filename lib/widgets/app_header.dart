import 'package:flutter/material.dart';
import 'package:help_together/widgets/app_avatar.dart';

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Container(
          color: Colors.deepOrange,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.translate(
                    offset: Offset(0, 10),
                    child: Text('John Doe',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            fontWeight: FontWeight.w900, color: Colors.white)),
                  ),
                  Transform.translate(offset: Offset(0, 10), child: AppAvatar())
                ],
              ),
              Text('Volunteer',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
