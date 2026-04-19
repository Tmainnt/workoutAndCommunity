import "package:flutter/material.dart";
import "package:woc/widget/auth/custom_textfield.dart";

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LogFormState();
}

class LogFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isObscure = false;

  @override
  Widget build(BuildContext contexct) {
    return Scaffold(
      body: Stack(
        children: [
          // test
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.lightGreen,
          ),

          // ใช้จริง

          /*Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(""),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6,
                    BlendMode.darken)
                  )
                ),
              ),
            ),*/
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 40, 25, 40),
                color: Colors.white,
                child: Column(
                  children: [
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Pedometer & ",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Workout",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "ยินดีต้อนรับสู่แอปสุขภาพและการออกกำลังกาย",
                      style: TextStyle(fontSize: 13),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextfield(
                                topic: "อีเมล",
                                isObscure: false,
                                textInputType: "",
                              ),
                              CustomTextfield(
                                topic: "รหัสผ่าน",
                                isObscure: true,
                                textInputType: "",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
