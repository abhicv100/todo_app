import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:todo_app/button.dart';
import 'package:todo_app/signup_page.dart';
import 'package:todo_app/task_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

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
                'Welcome to Todo App',
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
                  obscureText: true,
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

                    final user = ParseUser(
                        usernameTextController.text.trim(),
                        passwordTextController.text.trim(), null);

                      user.login().then((response) {
                        if(response.success) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TaskViewPage()));
                        } else {
                          setState(() {
                            showErrorText = true;
                            errorMsg = response.error?.message as String;
                          });
                        }
                      });
                  }
                },
                text: "Login",
              ),
              const SizedBox(
                height: 10.0,
              ),
              PrimaryButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()));
                },
                text: "New user ? Sign up",
              )
            ],
          ),
        ),
      ),
    );
  }
}
