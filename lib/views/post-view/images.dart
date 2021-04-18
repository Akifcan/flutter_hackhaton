import 'package:flutter/material.dart';
import 'package:help_together/views/post-view/map_view.dart';

class Images extends StatelessWidget {
  final List imageList;
  final double lat, long;
  const Images({Key key, this.imageList, this.lat, this.long})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: this.imageList.length + 1,
        itemBuilder: (_, index) => index < this.imageList.length
            ? Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(this.imageList[index]),
                        fit: BoxFit.cover)),
              )
            : MapView(long: this.long, lat: this.lat),
      ),
    );
  }
}
