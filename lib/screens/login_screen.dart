import 'package:adpatnxt_app/services/auth_service.dart';
import 'package:adpatnxt_app/screens/forgot_password_page.dart';
import 'package:adpatnxt_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email, password;
  final _formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/image1.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 200.0,
              left: 30,
            ),
            child: Text.rich(
                TextSpan(
                    text: 'Sign In ',style: TextStyle(fontSize: 30,color: Colors.white,),
                    children: [
                      TextSpan(
                        text: '\nSign into your account',
                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                      )
                    ]
                )
            ),
            // child: Text(
            //   "Sign In",
            //   style: TextStyle(color: Colors.white, fontSize: 33),
            // ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: MediaQuery.of(context).size.height * 0.33),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Padding(
                    const SizedBox(
                      height: 10,
                    ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: buildInputDecoration("Email Address"),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,

                    validator: (value) {
                      if (value!.isEmpty) return  'Please enter email';
                      RegExp emailPattern = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (value.isNotEmpty && !emailPattern.hasMatch(value)) {
                        return 'please enter valid Email';
                      }
                    },

                  ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(color: Colors.white),
                      decoration: buildInputDecoration("Password"),
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) return  'Please enter password';
                        if (value!.isNotEmpty && value.length < 8) {
                           return 'Password must be more than 7 characters';
                        }

                      },

                    ),                    Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPassword(),));
                        }, child: Text("Forgot password?",style: TextStyle(color: Colors.white),))),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState?.save();
                            setState(() {
                              email = emailController.text;
                              password = passwordController.text;

                            });
                            AuthServices.instance.signIn(email!, password!, context);
                          }

                        },
                        child: const Text("Sign In")),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.white60,
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegistrationScreen(),
                            ));
                          },
                          style: ButtonStyle(),
                          child: const Text(
                            'Sign Up',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        label: Text(hintText),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ));
  }

}
