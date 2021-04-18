import 'package:flutter/material.dart';
import 'package:help_together/core/utils.dart';
import 'package:help_together/services/language_service.dart';
import 'package:help_together/services/post_service.dart';
import 'package:help_together/views/post-view/post_created_successfully.dart';
import 'package:help_together/widgets/app_upload_image_button.dart';
import 'package:location/location.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CreatePost extends StatefulWidget {
  CreatePost({Key key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final GlobalKey<FormState> petForm = GlobalKey<FormState>();
  final GlobalKey<FormState> volunteerForm = GlobalKey<FormState>();
  final GlobalKey<FormState> donateForm = GlobalKey<FormState>();
  final PostService postService = PostService.instance;

  String type = 'pet';
  String gender = 'male';
  List<Asset> images = [];

  String title;
  int age;
  int goal;
  String description;

  chooseImages() async {
    List<Asset> resultList;
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
      );
    } on Exception catch (e) {
      print(e);
    }

    setState(() {
      images = resultList;
    });
  }

  removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  createPost() async {
    if (images.length > 0) {
      if (type == 'pet') {
        if (petForm.currentState.validate()) {
          petForm.currentState.save();
          final location = await getLocation();
          if (location is LocationData) {
            await postService.createPost(
                images,
                {
                  "title": title,
                  "description": description,
                  "gender": gender,
                  "age": age,
                  "lat": location.latitude,
                  "long": location.longitude
                },
                type);
          }
        }
      }
      if (type == 'volunteer') {
        if (volunteerForm.currentState.validate()) {
          volunteerForm.currentState.save();
          final location = await getLocation();
          if (location is LocationData) {
            await postService.createPost(
                images,
                {
                  "title": title,
                  "description": description,
                  "lat": location.latitude,
                  "long": location.longitude
                },
                type);
          }
        }
      }
      if (type == 'donate') {
        if (donateForm.currentState.validate()) {
          donateForm.currentState.save();
          final location = await getLocation();
          if (location is LocationData) {
            await postService.createPost(
                images,
                {
                  "title": title,
                  "available": 0,
                  "goal": goal,
                  "description": description,
                  "lat": location.latitude,
                  "long": location.longitude
                },
                type);
          }
        }
      }
    } else {
      return showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Uyarı'),
                content: Text('Lütfen resim seçin'),
              ));
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => PostCreatedSuccessfully()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Paylaş',
        onPressed: createPost,
        child: Icon(Icons.done),
      ),
      backgroundColor: Color(0xffdedede),
      appBar: AppBar(
        elevation: 0,
        title: Text(LanguageService.instance.translateWord('createPost')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) => setState(() => description = val),
                maxLength: 200,
                maxLines: 5,
                decoration: InputDecoration(
                    filled: true,
                    hintText:
                        LanguageService.instance.translateWord('description')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Radio(
                    value: 'pet',
                    groupValue: type,
                    onChanged: (val) {
                      print(val);
                      setState(() => type = val);
                    },
                  ),
                  Text(LanguageService.instance.translateWord('animals'),
                      style: TextStyle(fontSize: 18)),
                  Radio(
                    value: 'volunteer',
                    groupValue: type,
                    onChanged: (val) {
                      print(val);
                      setState(() => type = val);
                    },
                  ),
                  Text(LanguageService.instance.translateWord('volunteering'),
                      style: TextStyle(fontSize: 18)),
                  Radio(
                    value: 'donate',
                    groupValue: type,
                    onChanged: (val) {
                      print(val);
                      setState(() => type = val);
                    },
                  ),
                  Text(LanguageService.instance.translateWord('donation'),
                      style: TextStyle(fontSize: 18)),
                ],
              ),
              SizedBox(height: 10),
              if (type == 'donate')
                Form(
                  key: donateForm,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (val) => setState(() => title = val),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Lütfen bu alanı doldurun";
                          }
                          if (val.length < 3) {
                            return "Bu başlık çok kısa";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: LanguageService.instance
                                .translateWord('title')),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onSaved: (val) => setState(() => goal = int.parse(val)),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Lütfen bu alanı doldurun";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        decoration: InputDecoration(hintText: 'Hedef Tutar'),
                      ),
                    ],
                  ),
                )
              else if (type == 'volunteer')
                Form(
                  key: volunteerForm,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (val) => setState(() => title = val),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Lütfen bu alanı doldurun";
                          }
                          if (val.length < 3) {
                            return "Bu başlık çok kısa";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: LanguageService.instance
                                .translateWord('annunciation')),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                )
              else if (type == 'pet')
                Form(
                  key: petForm,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (val) => setState(() => title = val),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Lütfen bu alanı doldurun";
                          }
                          if (val.length < 3) {
                            return "Bu başlık çok kısa";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: LanguageService.instance
                                .translateWord('title')),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Radio(
                            value: 'male',
                            groupValue: gender,
                            onChanged: (val) {
                              print(val);
                              setState(() => gender = val);
                            },
                          ),
                          Text(LanguageService.instance.translateWord('male'),
                              style: TextStyle(fontSize: 18)),
                          Radio(
                            value: 'female',
                            groupValue: gender,
                            onChanged: (val) {
                              print(val);
                              setState(() => gender = val);
                            },
                          ),
                          Text(LanguageService.instance.translateWord('female'),
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onSaved: (val) => setState(() => age = int.parse(val)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: LanguageService.instance
                                .translateWord('age/estimated')),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              AppUploadImageButton(voidCallback: () => chooseImages()),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: images.length > 0
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => SizedBox(width: 10),
                        itemCount: images.length,
                        itemBuilder: (_, index) => GestureDetector(
                              onLongPress: () => removeImage(index),
                              child: AssetThumb(
                                  asset: images[index], height: 50, width: 50),
                            ))
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
