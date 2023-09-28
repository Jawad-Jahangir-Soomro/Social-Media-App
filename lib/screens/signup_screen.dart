import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/utils/colors.dart';
import 'package:social_media_app/utils/utils.dart';
import 'package:social_media_app/widgets/text_field_input.dart';
import 'package:social_media_app/resources/auth_methods.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {

    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    if(res != "success"){
      showSnackBar(res, context);
    }

  }

  void _selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1), // Responsive padding
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // svg Image
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                color: primaryColor,
                height: screenHeight * 0.1,
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              // Circular Widget to accept and show our selected file
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!)
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/736x/66/ff/cb/66ffcb56482c64bdf6b6010687938835.jpg'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: screenWidth * 0.2, // Responsive position
                    child: IconButton(
                      onPressed: _selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              // Text Field Input for Username
              TextFieldInput(
                textEditingController: _usernameController,
                textInputType: TextInputType.text,
                hintText: "Enter Your Username",
                width: screenWidth * 0.8, // Responsive width
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              // Text Field Input for Email
              TextFieldInput(
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
                hintText: "Enter Your Email",
                width: screenWidth * 0.8,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              // Text Field Input for Password
              TextFieldInput(
                isPass: true,
                textEditingController: _passwordController,
                textInputType: TextInputType.text,
                hintText: "Enter Your Password",
                width: screenWidth * 0.8,
              ),
              // LogIn Button
              SizedBox(
                height: screenHeight * 0.02,
              ),
              // Text Field Input for Bio
              TextFieldInput(
                textEditingController: _bioController,
                textInputType: TextInputType.text,
                hintText: "Enter Your Bio",
                width: screenWidth * 0.8,
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: screenWidth * 0.8,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                  child: _isLoading? const Center(child: CircularProgressIndicator(color: primaryColor,),) : const Text("Sign Up"),
                ),
              ),
              // Transitioning to Signup
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account?"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        " SignUp.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
