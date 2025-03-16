import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainscreen.dart';
import 'sign_page.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _passwordVisible = false;
  //if animation already done so main screen show not dashboard
  void setData()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("alreadyUsed", false);
  }

  Future<void> login(BuildContext context) async {
    var url = "http://192.168.52.125/authen/login.php";
    var response = await http.post(Uri.parse(url), body: {
      "username_or_email": username.text,
      "password": password.text,
    });

    var data = json.decode(response.body);

    if (data['status'] == 1) {
      username.clear();
      password.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainscreen()),
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Invalid Username and Password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
    }
  }

  @override
  void initState() {

    super.initState();
    setData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'القرآن الكريم',
          style: TextStyle(color: Colors.white, fontSize: 28,fontWeight: FontWeight.bold),

        ),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back2.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: Container(

            margin: EdgeInsets.symmetric(horizontal: 16.0), // Set left and right margins
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: 'Username or Email',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(), // Default border
                      focusedBorder: OutlineInputBorder( // Border when focused
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder( // Border when enabled
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username or email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_passwordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await login(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // button background color
                      ),
                      child: Text('Login',style: TextStyle(color: Colors.white),),
                    ),
                  ),
              SizedBox(height: 20,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text('Don\'t have an account? Sign Up',style: TextStyle(color: Colors.black),),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
