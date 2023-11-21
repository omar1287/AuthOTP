import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_auth/Persentation/View/Auth_OTP/Widget/Phone_Body.dart';
import 'package:otp_auth/Persentation/View/Home/Home.dart';
import 'package:pinput/pinput.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  var pinputvalue = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // final defaultPinTheme = PinTheme(
    //   width: 56,
    //   height: 56,
    //   textStyle: const TextStyle(
    //       fontSize: 20,
    //       color: Color.fromRGBO(30, 60, 87, 1),
    //       fontWeight: FontWeight.w600),
    //   decoration: BoxDecoration(
    //     border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    // );

    // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    //   border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
    //   borderRadius: BorderRadius.circular(8),
    // );
    //
    // final submittedPinTheme = defaultPinTheme.copyWith(
    //   decoration: defaultPinTheme.decoration?.copyWith(
    //     color: const Color.fromRGBO(234, 239, 243, 1),
    //   ),
    // );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Pinput(
                  length: 6,
                  validator: (s) {
                    return s == '222222' ? 'correct' : 'Pin is incorrect';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onChanged: (value) {
                    pinputvalue = value;
                  },
                  // ignore: avoid_print
                  onCompleted: (pin) => print(pin),
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
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: PhoneBody.verifiycode,
                                  smsCode: pinputvalue);

                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: "smscode is not correct",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                      },
                      child: const Text(
                        'Verify phone number',
                      ))),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PhoneBody()));
                    },
                    child: const Text('Edit phone number?'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
