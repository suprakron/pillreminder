import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:pillreminder/page/login_ui_page.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .06,
              ),
              const SizedBox(
                height: 34,
              ),
              const Text(
                'ลงทะเบียน',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 40,
              ),
           
              const SizedBox(
                height: 14,
              ),
              const TextField(
                decoration: InputDecoration(
                    hintText: 'อีเมลล์',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Color.fromARGB(255, 50, 120, 124),
                    )),
              ),
              const SizedBox(
                height: 14,
              ),
              const TextField(
                decoration: InputDecoration(
                    hintText: 'รหัสผ่าน',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 50, 120, 124),
                    )),
              ),
              const SizedBox(
                height: 14,
              ),
              const TextField(
                decoration: InputDecoration(
                    hintText: 'ยืนยันรหัสผ่าน',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 50, 120, 124),
                    )),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: MaterialButton(
                  color: Color.fromARGB(255, 50, 120, 124),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    'ลงทะเบียน',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: "มีบัญชีแล้ว ?",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
                TextSpan(
                  text: 'เข้าสู่ระบบ',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (c, a1, a2) => const LoginUiPage(),
                          transitionsBuilder: (c, anim, a2, child) =>
                              FadeTransition(opacity: anim, child: child),
                          transitionDuration:
                              const Duration(milliseconds: 1000),
                        ),
                      );
                    },
                  style: const TextStyle(
                      color: Color(0xffee0f37),
                      fontWeight: FontWeight.w700,
                      fontSize: 13),
                )
              ])),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
