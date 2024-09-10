import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_1/service/user_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phoneController = TextEditingController();
  final otpVerifyController = TextEditingController();
  String verificationID = '';

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(
                "Masuk/Registrasi",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                height: 6.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 3.w, top: 0.5.h),
                  child: TextField(
                    controller: phoneController,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nomor Teleponn',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 6.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 3.w, top: 0.5.h),
                        child: TextField(
                          controller: otpVerifyController,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'OTP',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: SizedBox(
                        height: 6.h,
                        width: 28.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: phoneController.text,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) async {
                                await FirebaseAuth.instance
                                    .signInWithCredential(credential);
                              },
                              verificationFailed: (error) {
                                log(error.message!);
                              },
                              codeSent: (verificationID, forceResendingToken) {
                                setState(() {
                                  this.verificationID = verificationID;
                                });
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationID) {
                                setState(() {
                                  this.verificationID = verificationID;
                                });
                              },
                            );
                          },
                          child: Center(
                            child: Text(
                              'Send OTP',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              GestureDetector(
                onTap: () async {
                  if (otpVerifyController.text.length != 6) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('OTP harus 6 digit'),
                    ));
                    return;
                  }

                  if (verificationID.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('OTP has expired. Please request a new one.'),
                    ));

                    return;
                  }

                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationID,
                    smsCode: otpVerifyController.text,
                  );

                  await FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((value) async {
                    if (value.user != null) {
                      await DatabaseService.createUpdateUser(
                        value.user!.uid,
                        phoneNumber: phoneController.text,
                      );
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      log('Error saat masuk');
                    }
                  });
                },
                child: Container(
                  height: 7.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
