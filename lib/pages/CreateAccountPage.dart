import 'package:flutter/material.dart';
import 'package:project/service/auth.dart';
import 'package:project/pages/HomePage.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth
                          .createUserWithEmailAndPassword(_email, _password);
                      if (result == null) {
                        print('Error creating account');
                      } else {
                        print('Account created successfully');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    }
                  },
                  child: Text('Create Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
