import 'dart:ffi';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:socialseed/app/cubits/auth/auth_cubit.dart';
import 'package:socialseed/app/cubits/credential/credential_cubit.dart';
import 'package:socialseed/app/screens/home_screen.dart';
import 'package:socialseed/app/widgets/text_field_widget.dart';
import 'package:socialseed/domain/entities/user_entity.dart';
import 'package:socialseed/utils/constants/color_const.dart';
import 'package:socialseed/utils/constants/page_const.dart';
import 'package:socialseed/utils/constants/text_const.dart';
import 'package:uuid/uuid.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  File? _image;

  final ImagePicker _picker = ImagePicker();
  TextEditingController _captionController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future _pickMedia() async {
    try {
      final pickedFile = await ImagePicker.platform
          .getImageFromSource(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image");
        }
      });
    } catch (e) {
      print('something went $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/icons/back.png",
            width: 25.0,
            height: 25.0,
          ),
        ),
        centerTitle: false,
        title: Text('Create Post'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Post",
                style: TextStyle(
                    color: Color.fromRGBO(255, 49, 49, 1), fontSize: 20.0),
                selectionColor: Color.fromRGBO(255, 49, 49, 1),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 20),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/user-1.jpg'),
                      radius: 25,
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Username",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 49, 49, 1)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _captionController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "What's on your mind?",
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Divider(
                  height: 5.0,
                  color: Colors.black,
                ),
                Center(
                  child: TextButton.icon(
                    onPressed: _pickMedia,
                    icon: const Icon(
                      Icons.image_outlined,
                      color: Color.fromRGBO(255, 49, 49, 1),
                    ),
                    label: const Text(
                      "Photo/Video",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 49, 49, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Divider(
                  height: 5.0,
                  color: Colors.black,
                ),
                Center(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person_2,
                      color: Color.fromRGBO(255, 49, 49, 1),
                    ),
                    label: const Text(
                      "Tag People",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 49, 49, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Divider(
                  height: 5.0,
                  color: Colors.black,
                ),
                Center(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.location_on,
                      color: Color.fromRGBO(255, 49, 49, 1),
                    ),
                    label: const Text(
                      "Location",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 49, 49, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
