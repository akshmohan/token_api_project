import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_api_project/controllers/auth_controller.dart';
import 'package:token_api_project/views/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisible = false;

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthController>(
        builder: (context, authController, child) {
          return Container(
            padding: EdgeInsets.all(20),
            height: double.infinity,
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(hintText: "Username"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a valid username";
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: isVisible == true
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter password";
                      }
                    },
                  ),
                  SizedBox(height: 40),
                  InkResponse(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        final user = await authController.login(
                          usernameController.text.trim(),
                          passwordController.text.trim(),
                        );

                        print(user!.firstName);
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(user: user),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      height: 48,
                      width: 250,
                      decoration: BoxDecoration(color: Colors.orange),
                      child: Center(
                        child: Text("Login"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
