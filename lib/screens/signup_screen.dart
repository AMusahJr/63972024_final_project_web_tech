import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/screens/widgets/text_field_input.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _yeargroupController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _bestfoodController = TextEditingController();
  final TextEditingController _bestmovieController = TextEditingController();
  final TextEditingController _residenceController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _studentIDController.dispose();
    _dobController.dispose();
    _yeargroupController.dispose();
    _majorController.dispose();
    _bestfoodController.dispose();
    _bestmovieController.dispose();
    _residenceController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        studentID: _studentIDController.text,
        yeargroup: _yeargroupController.text,
        major: _majorController.text,
        dob: _dobController.text,
        residenceStatus: _residenceController.text,
        bestfood: _bestfoodController.text,
        bestmovie: _bestmovieController.text,
        file: _image!);

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                ),
                ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          // svg image
          SvgPicture.asset(
            'assets/ashesi logo.svg',
            height: 49,
          ),
          const SizedBox(height: 64),
          //circular widget to accept and show our selected file
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg'),
                    ),
              Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // text field for email
          TextFieldInput(
            hintText: 'Enter your email',
            textInputType: TextInputType.emailAddress,
            textEditingController: _emailController,
          ),
          const SizedBox(
            height: 20,
          ),
          //text field for password
          TextFieldInput(
            hintText: 'Enter your password',
            textInputType: TextInputType.text,
            textEditingController: _passwordController,
            isPass: true,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: 'Enter your username',
            textInputType: TextInputType.text,
            textEditingController: _usernameController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: 'Enter your student ID',
            textInputType: TextInputType.text,
            textEditingController: _studentIDController,
          ),
          const SizedBox(
            height: 20,
          ),

          TextFieldInput(
            hintText: 'Enter your date of birth',
            textInputType: TextInputType.datetime,
            textEditingController: _dobController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: 'Enter your year group',
            textInputType: TextInputType.number,
            textEditingController: _yeargroupController,
          ),

          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: 'Enter your major',
            textInputType: TextInputType.text,
            textEditingController: _majorController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: 'Do you live on campus?',
            textInputType: TextInputType.text,
            textEditingController: _residenceController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: 'Enter your best food',
            textInputType: TextInputType.text,
            textEditingController: _bestfoodController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: 'Enter your best movie',
            textInputType: TextInputType.text,
            textEditingController: _bestmovieController,
          ),
          const SizedBox(
            height: 20,
          ),

          // login button
          InkWell(
            onTap: signUpUser,
            child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Sign In'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor)),
          ),
          const SizedBox(
            height: 12,
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text("Have an account?"),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
              ),
              GestureDetector(
                onTap: navigateToLogin,
                child: Container(
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    )),
              ),
            ],
          )
          //transitioning to sign up
        ],
      ),
    )));
  }
}
