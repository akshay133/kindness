import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindness/controllers/auth_controller.dart';
import 'package:kindness/helpers/validator.dart';
import 'package:kindness/screens/login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0xffffffff),
            Color(0xffdadada),
            Color(0xff729dc3)
          ])),
      child: Stack(
        children: [
          SafeArea(
            child: Container(
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                    ))),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://firebasestorage.googleapis.com/v0/b/kindness-40bbd.appspot.com/o/files%2FappIcon%2Fkindness-app.png?alt=media&token=97186a8f-1bf3-4986-88f7-2f214ed0c6d2",
                        height: Get.height / 7,
                      ),
                      SizedBox(
                        height: Get.height / 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reset Password',
                            style: TextStyle(
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            'Please enter your Email address. We will send you an email with a link to reset your password',
                            style: TextStyle(
                                color: Color(0xffa3a3a3),
                                //fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          TextFormField(
                            controller: authController.emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.deepOrange,
                              ),
                              labelText: "Email ID",
                            ),
                            validator: Validator().email,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                                authController.emailController.text = value!,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height / 8,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            minimumSize: Size(Get.width, Get.height / 20),
                          ),
                          child: Text(
                            'Reset Password',
                            style: TextStyle(
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              authController
                                  .sendPasswordResetEmail(context)
                                  .whenComplete(() {
                                Get.to(() => LoginScreen());
                              });
                            } else {
                              Get.snackbar("Please enter an Email Address ", "",
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: Duration(seconds: 10),
                                  backgroundColor:
                                      Get.theme.snackBarTheme.backgroundColor,
                                  colorText:
                                      Get.theme.snackBarTheme.actionTextColor);
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
