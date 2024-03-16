import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:socialseed/app/cubits/auth/auth_cubit.dart';
import 'package:socialseed/app/cubits/credential/credential_cubit.dart';
import 'package:socialseed/app/screens/home_screen.dart';
import 'package:socialseed/domain/entities/user_entity.dart';
import 'package:socialseed/utils/constants/color_const.dart';
import 'package:socialseed/utils/constants/page_const.dart';
import 'package:socialseed/utils/constants/text_const.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // local variables
  bool isPressed = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  // bool _isSigningUp = false;
  bool _isUploading = false;

  String _dobController = "Date of Birth";
  File? _image;

  // upload

  Future selectImage() async {
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

  // UI Methods

  Widget getTextField(
      TextEditingController controller, String label, TextInputType key) {
    return Container(
      height: 66,
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.greyColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: key,
        validator: (value) {
          // Add your validation logic here
          if (value!.isEmpty) {
            return 'Please enter $label';
          }

          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
        ),
      ),
    );
  }

  Widget getTextFieldWithPassword(
      TextEditingController controller, String label, bool isPressed) {
    // Assuming you have this boolean in your class

    return Container(
      height: 66,
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.greyColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: TextFormField(
              controller: controller,
              obscureText:
                  !isPressed, // Invert the value for password visibility
              validator: (value) {
                // Add your validation logic here
                if (value!.isEmpty) {
                  return 'Please enter $label';
                }
                // You can add more complex validation rules as needed
                return null; // Return null if the input is valid
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(isPressed ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                // Toggling the visibility of the password
                setState(() {
                  isPressed = !isPressed;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250, // Fixed height to avoid intrinsic dimensions error
          child: Column(
            children: [
              Expanded(
                child: ScrollDatePicker(
                  selectedDate: _selectedDate,
                  onDateTimeChanged: (value) {
                    setState(() {
                      _selectedDate = value;
                    });

                    _dobController = _selectedDate.toString();
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('SET'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _signUp() {
    BlocProvider.of<CredentialCubit>(context)
        .signUpUser(
            user: UserEntity(
      username: _nameController.text,
      fullname: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      bio: "",
      imageUrl: "",
      friends: [],
      milestones: [],
      likedPages: [],
      posts: [],
      joinedDate: DateTime.now(),
      isVerified: true,
      badges: [],
      followerCount: 0,
      followingCount: 0,
      stories: [],
    ))
        .then((val) {
      setState(() {
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        // _isSigningUp = false;
      });
    });
  }

  _bodyWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Image.asset('assets/SOCIALSEED.png'),

            // JOIN NOW
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Join Now',
                style: TextConst.MediumStyle(49, AppColor.blackColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Let's get started by filling out the form below.",
                style: TextConst.RegularStyle(15, AppColor.textGreyColor),
              ),
            ),

            sizeVar(15),
            // Upload Image
            GestureDetector(
              onTap: selectImage,
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppColor.greyColor,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset('assets/icons/user.png'),
                ),
              ),
            ),

            sizeVar(15),
            // Form Fields
            getTextField(_nameController, 'Name', TextInputType.name),
            getTextField(_emailController, 'Email', TextInputType.emailAddress),
            getTextFieldWithPassword(_passwordController, 'Password', false),
            getTextFieldWithPassword(
                _confirmPasswordController, "Confirm Password", false),

            // dob

            Container(
              height: 66,
              width: double.infinity,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColor.greyColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _showDatePicker(context);
                        });
                      },
                      child: Text('SET',
                          style: TextConst.headingStyle(15, AppColor.redColor)))
                ],
              ),
            ),

            // Submit Button
            GestureDetector(
              onTap: () {
                _signUp();
              },
              child: Container(
                height: 66,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColor.redColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                    child: Text(
                  "Create Account",
                  style: TextConst.headingStyle(18, AppColor.whiteColor),
                )),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Text(
                    'Do You Have an Account?',
                    style: TextConst.RegularStyle(15, AppColor.textGreyColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConst.loginPage, (route) => false);
                  },
                  child: Text('Login',
                      style: TextConst.headingStyle(15, AppColor.redColor)),
                )
              ],
            ),
            sizeVar(30),
            Center(
              child: Text(
                'Socialseed @2024 Copyright (c)',
                style: TextConst.RegularStyle(18, AppColor.blackColor),
              ),
            ),
            sizeVar(30),
          ],
        ),
      ),
    );
  }

  Future<void> _signUpUser() async {
    setState(() {
      // _isSigningUp = true;
    });
  }

  _clear() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      // _isSigningUp = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, state) {
          if (state is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }

          if (state is CredentialFailure) {
            print("Invalid Information");
          }
        },
        builder: (context, state) {
          if (state is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return HomeScreen(uid: state.uid);
                } else {
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
        },
      ),
    );
  }
}
