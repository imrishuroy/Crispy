import 'dart:async';
import '/config/shared_prefs.dart';
import '/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import '/screens/login/login_screen.dart';
import '/widgets/display_message.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class GiveAccessScreen extends StatefulWidget {
  static const String routeName = '/give-access';
  const GiveAccessScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const GiveAccessScreen(),
    );
  }

  // final String verificationId;
  // final String phoneNo;

  // const GiveAccessScreen({
  //   Key? key,
  //   required this.verificationId,
  //   required this.phoneNo,
  // }) : super(key: key);

  // final String? phoneNumber;
  // final String? otp;

  // const PinCodeVerificationScreen(
  //     {Key? key, this.phoneNumber, required this.otp})
  //     : super(key: key);

  @override
  _GiveAccessScreenState createState() => _GiveAccessScreenState();
}

class _GiveAccessScreenState extends State<GiveAccessScreen> {
  final _otpController = TextEditingController();
  // ..text = "123456";

  // ignore:   close_sinks
  StreamController<ErrorAnimationType>? _errorController;

  bool hasError = false;
  String _currentText = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _errorController = StreamController<ErrorAnimationType>();
    // _setOtp();

    super.initState();
  }

  // void _setOtp() {
  //   // if (widget.otp != null) {
  //   //   _otpController.text = widget.otp!;
  //   //   setState(() {
  //   //     _currentText = widget.otp!;
  //   //   });
  //   // }
  // }

  @override
  void dispose() {
    _errorController?.close();

    super.dispose();
  }

  Future<void> _verifyOtp() async {
    // _formKey.currentState!.validate();
    // // conditions for validating
    // if (currentText.length != 6 || currentText != widget.otp) {
    //   errorController!.add(
    //     ErrorAnimationType.shake,
    //   ); // Triggering error shake animation
    //   setState(() => hasError = true);
    // } else {
    //   setState(
    //     () {
    //       hasError = false;
    //       snackBar("OTP Verified!!");
    //       Navigator.of(context).pushNamed(NavScreen.routeName);
    //     },
    //   );
    // }

    try {
      if (_formKey.currentState!.validate()) {
        // if (currentText.length != 6 || currentText != widget.otp) {
        if (_currentText.length != 4) {
          _errorController!.add(
            ErrorAnimationType.shake,
          ); // Triggering error shake animation
          setState(() => hasError = true);
        } else {
          if (_otpController.text == '2025') {
            SharedPrefs().setFirstTime();
            setState(() {
              hasError = false;
              DisplayMessage.succussMessage(context, title: 'Pin Verified !');
            });

            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (route) => false);
          } else {
            DisplayMessage.erroMessage(context, title: 'Wrong Pin !');
          }

          // final authRepo = context.read<AuthRepository>();
          // print('Otp ${_otpController.text}');

          // final bool result = await authRepo.verifyOtp(
          //     otp: _otpController.text, verificationId: '');

          // // await authRepo.verifyOtp(
          // //     phNumber: widget.phoneNumber, otp: _otpController.text);

          // if (result) {
          //   setState(
          //     () {
          //       hasError = false;
          //       DisplayMessage.succussMessage(context, title: 'Pin Verified !');

          //       // Navigator.of(context).pushNamedAndRemoveUntil(
          //       //     AuthWrapper.routeName, (route) => false);
          //       // Navigator.of(context).pushNamedAndRemoveUntil(
          //       //     NavScreen.routeName, (route) => false);
          //     },
          //   );
          // }
        }
      }
    } catch (error) {
      print('Error verifying otp ${error.toString}}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('Phone Number - ${widget.phoneNumber}');
    // print('Otp - ${widget.otp}');
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // backgroundColor: Constants.primaryColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 30),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/images/otp.gif'),
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Enter the unique pin',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
              //   child: RichText(
              //     text: const TextSpan(
              //       text: 'Enter the code sent to ',
              //       children: [
              //         TextSpan(
              //           text: '+918540928489',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 15,
              //           ),
              //         ),
              //       ],
              //       style: TextStyle(
              //         color: Colors.black54,
              //         fontSize: 15,
              //       ),
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              const SizedBox(height: 20.0),
              Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    // obscureText: true,
                    //  obscuringCharacter: '*',
                    // obscuringWidget: const FlutterLogo(
                    //   size: 24,
                    // ),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 3) {
                        return 'I\'m from validator';
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    animationDuration: const Duration(milliseconds: 300),
                    // enableActiveFill: true,
                    errorAnimationController: _errorController,
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      print('Completed');
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print('Allowing to paste $text');
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? '*Please fill up all the cells properly' : '',
                  style: const TextStyle(
                    color: Colors.white10,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text(
              //       "Didn't receive the code? ",
              //       style: TextStyle(color: Colors.black54, fontSize: 15),
              //     ),
              //     TextButton(
              //       onPressed: () => snackBar("OTP resend!!"),
              //       child: const Text(
              //         "RESEND",
              //         style: TextStyle(
              //             color: Color(0xFF91D3B3),
              //             fontWeight: FontWeight.bold,
              //             fontSize: 16),
              //       ),
              //     )
              //   ],
              // ),
              const SizedBox(height: 14.0),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  buttonColor: const Color(0xff88E0EF),
                  height: 50,
                  child: TextButton(
                    // style:
                    //     TextButton.styleFrom(primary: const Color(0xff88E0EF)),
                    onPressed: _verifyOtp,
                    child: const Center(
                      child: Text(
                        'VERIFY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.3,
                        ),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff3DB2FF),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: const Color(0xffF1F1F1),
                      ),
                      child: const Text('Clear'),
                      onPressed: () {
                        _otpController.clear();
                      },
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          primary: const Color(0xffF1F1F1),
                        ),
                        child: const Text('Go Back'),
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                LoginScreen.routeName, (route) => false)),
                  ),
                  // Flexible(
                  //   child: TextButton(
                  //     child: const Text('Set Text'),
                  //     onPressed: () {
                  //       setState(
                  //         () {
                  //           _otpController.text = '123456';
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
