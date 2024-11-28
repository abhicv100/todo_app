import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:todo_app/button.dart';
import 'package:todo_app/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  bool showErrorText = false;
  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child: Text(
                'Create Account',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8.0)),
                child: TextField(
                  textAlign: TextAlign.justify,
                  cursorWidth: 5.0,
                  cursorColor: Colors.black87,
                  controller: usernameTextController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Username"),
                  maxLines: 1,
                  textCapitalization: TextCapitalization.characters,
                  style: const TextStyle(
                      decorationThickness: 0.0,
                      fontSize: 20.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8.0)),
                child: TextField(
                  textAlign: TextAlign.justify,
                  cursorWidth: 5.0,
                  cursorColor: Colors.black87,
                  controller: passwordTextController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Password"),
                  maxLines: 1,
                  textCapitalization: TextCapitalization.characters,
                  style: const TextStyle(
                      decorationThickness: 0.0,
                      fontSize: 20.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 16,),
              showErrorText ? Text(errorMsg, style: const TextStyle(color: Colors.red)) : Container(),
              const Spacer(),
              PrimaryButton(
                onPressed: () {
                  if (usernameTextController.text.isNotEmpty &&
                      passwordTextController.text.isNotEmpty) {

                    setState(() {
                      showErrorText = false;
                    });

                    final user = ParseUser.createUser(
                        usernameTextController.text.trim(),
                        passwordTextController.text.trim());

                    user.signUp(allowWithoutEmail: true).then((response) {
                      if (response.success) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      } else {
                          setState(() {
                            showErrorText = true;
                            errorMsg = response.error?.message as String;
                          });
                        }
                    });
                  }
                },
                text: "Signup",
              ),
              const SizedBox(
                height: 10.0,
              ),
              PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Already have an account ? Login",
              )
            ],
          ),
        ),
      ),
    );
  }
}
