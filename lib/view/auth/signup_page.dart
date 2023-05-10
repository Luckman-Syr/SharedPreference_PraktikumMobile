import 'package:datafilm_omdb/view/auth/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/textfield_component.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                },
                child: Text('Back', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Signup",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            // TextFormField(
            //   decoration: const InputDecoration(
            //       border: OutlineInputBorder(), labelText: "Username"),
            // ),
            TextFields(
              hintText: "Username",
              controller: _usernameController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            // TextFormField(
            //   obscureText: true,
            //   decoration: const InputDecoration(
            //       border: OutlineInputBorder(), labelText: "Password"),
            // ),
            TextFields(
              hintText: "Password",
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_usernameController.text != null &&
                      _passwordController.text != null) {
                    _register(false);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    }));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => const CupertinoAlertDialog(
                              title: Text("Error"),
                              content: Text("Ada yg kosong"),
                            ));
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _register(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = value;
    prefs.setBool('status', status);
    prefs.setString('username', _usernameController.text);
    prefs.setString('password', _passwordController.text);
    prefs.commit();

    print(prefs.getString('username'));
    print(prefs.getString('password'));
    print(prefs.getBool('status'));
  }
}
