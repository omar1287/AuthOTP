import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_auth/Persentation/View/Auth_OTP/OTP/OTP.dart';

class PhoneBody extends StatefulWidget {
  const PhoneBody({super.key});

  static String verifiycode = "";

  @override
  State<PhoneBody> createState() => _PhoneBodyState();
}

class _PhoneBodyState extends State<PhoneBody> {
  TextEditingController phoneCon = TextEditingController();
  TextEditingController seryalCon = TextEditingController();
  var changeseryal = '';
  var changephone = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seryalCon.text = '+20';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 7, right: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/Welcome.jpg')),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Phone Verification',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'We need to register your phone before getting started !',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 60,
                        child: TextFormField(
                          controller: seryalCon,
                          onChanged: (value) {
                            changeseryal = value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: seryalCon.text,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Text(
                        '|',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          changephone = value;
                        },
                        controller: phoneCon,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Phone'),
                      ))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: changeseryal + changephone,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            PhoneBody.verifiycode = verificationId;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const OTP()));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      },
                      child: const Text(
                        'Send the code',
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
