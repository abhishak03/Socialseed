import 'package:flutter/material.dart';
import 'package:socialseed/app/widgets/text_field_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/SOCIALSEED.png'),
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
              Center(
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
              getTextField(_nameController, 'Name', TextInputType.name),
              getTextField(
                  _emailController, 'Email', TextInputType.emailAddress),
              getTextField(
                  _passwordController, 'Password', TextInputType.emailAddress),
              getTextField(_confirmPasswordController, 'Confirm Password',
                  TextInputType.emailAddress),
              Container(
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
                  ),
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
                    onPressed: () {},
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
      ),
    );
  }
}
