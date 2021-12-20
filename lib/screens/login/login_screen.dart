import '/repository/auth/auth_repository.dart';
import '/widgets/error_dialog.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:universal_platform/universal_platform.dart';

import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
        create: (_) =>
            LoginCubit(authRepository: context.read<AuthRepository>()),
        child: const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // context.read<AuthRepository>().signOut();
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.error) {
            print('ERROR ${state.failure!.message} ');
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                content: state.failure!.message,
              ),
            );
          }
        },
        builder: (context, state) {
          print('Width - $width');
          //print("Height - $height");
          return Scaffold(
            //backgroundColor: Color(0xff8d93ab),

            // backgroundColor: Colors.grey[100],
            body: state.status == LoginStatus.submitting
                ? const Center(child: LoadingIndicator())
                : Center(
                    child: SizedBox(
                      height: height * 0.5,
                      //color: Colors.red,
                      width: width * 0.9,
                      child: Card(
                        elevation: 10.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Crispy',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(
                              width: 250.0,
                              height: 50.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {
                                  context.read<LoginCubit>().googleLogin();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.zero,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          bottomLeft: Radius.circular(4),
                                        ),
                                      ),
                                      padding: EdgeInsets.zero,
                                      height: 50.0,
                                      width: 50.0,
                                      child: SizedBox(
                                        height: 20.0,
                                        width: 20.0,
                                        child: SvgPicture.asset(
                                          'assets/images/google.svg',
                                          fit: BoxFit.contain,
                                          height: 20.0,
                                          width: 20.0,
                                          // fit: BoxFit.contain,

                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 20.0),
                                    Text(
                                      'Sign in with Google',
                                      style: TextStyle(
                                        fontSize: width < 900 ? 18 : 20.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    // // Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            if (UniversalPlatform.isIOS)
                              SizedBox(
                                width: 250.0,
                                child: SignInWithAppleButton(
                                  onPressed: () {
                                    context.read<LoginCubit>().appleLogin();
                                  },
                                  style: SignInWithAppleButtonStyle.black,
                                ),
                              ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  '" Don\'t be a minimum guy "',
                                  style: TextStyle(
                                    fontSize: width < 900 ? 16.0 : 20.0,
                                    letterSpacing: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}





// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:crispy/screens/login/otp_verification_screen.dart';

// import 'package:flutter/services.dart';

// import '/repository/auth/auth_repository.dart';
// import '/widgets/error_dialog.dart';
// import '/widgets/loading_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'cubit/login_cubit.dart';

// String defaultFontFamily = 'Roboto-Light.ttf';
// double defaultFontSize = 14;
// double defaultIconSize = 17;

// class LoginScreen extends StatefulWidget {
//   static const String routeName = '/login';

//   const LoginScreen({Key? key}) : super(key: key);

//   static Route route() {
//     return PageRouteBuilder(
//       settings: const RouteSettings(name: routeName),
//       transitionDuration: const Duration(seconds: 0),
//       pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
//         create: (_) =>
//             LoginCubit(authRepository: context.read<AuthRepository>()),
//         child: const LoginScreen(),
//       ),
//     );
//   }

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final _phoneNoController = TextEditingController();

//   void showSnackBar({required BuildContext context, required String? title}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: const Duration(seconds: 3),
//         content: Text(
//           '$title',
//           textAlign: TextAlign.center,
//         ),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   void _submit() async {
//     try {
//       FocusScope.of(context).unfocus();
//       if (_formKey.currentState!.validate()) {
//         _formKey.currentState!.save();

//         context.read<LoginCubit>().loginWithPhone();
//       }
//     } catch (error) {
//       print('Error login ${error.toString()}');

//       showDialog(
//         context: context,
//         builder: (context) => ErrorDialog(
//           content: error.toString(),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     //final width = MediaQuery.of(context).size.width;
//     // final height = MediaQuery.of(context).size.height;

//     return WillPopScope(
//       onWillPop: () async => false,
//       child: BlocConsumer<LoginCubit, LoginState>(
//         listener: (context, state) {
//           if (state.status == LoginStatus.error) {
//             print('ERROR ${state.failure!.message} ');
//             showDialog(
//               context: context,
//               builder: (context) => ErrorDialog(
//                 content: state.failure!.message,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           //  print('Width - $width');
//           final _loginCubit = context.read<LoginCubit>();

//           return SafeArea(
//             child: Scaffold(
//               body: state.status == LoginStatus.submitting
//                   ? const Center(child: LoadingIndicator())
//                   // AddOtpPrompt(
//                   //     phoneNumber: _loginCubit.state.phoneNumber ?? '',
//                   //     verificationId: '',
//                   //   )
//                   : SingleChildScrollView(
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             Stack(
//                               children: [
//                                 Image.network(
//                                   'https://image.freepik.com/free-vector/video-upload-concept-illustration_114360-6773.jpg',
//                                   height: 400.0,
//                                 ),
//                                 const Positioned(
//                                   top: 35.0,
//                                   left: 40.0,
//                                   child: Text(
//                                     'Naple',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 24.0,
//                                       color: Colors.black,
//                                       letterSpacing: 1.2,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 70.0),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 20.0),
//                               child: Row(
//                                 children: [
//                                   CountryCodePicker(
//                                     hideSearch: true,

//                                     // backgroundColor: Colors.grey,
//                                     //   barrierColor: Colors.black,
//                                     dialogTextStyle:
//                                         const TextStyle(color: Colors.black),
//                                     //  textStyle: const TextStyle(color: Colors.black),
//                                     onChanged: (code) {
//                                       print('Picked code ${code.dialCode}');
//                                       _loginCubit.state
//                                           .copyWith(countryCode: code.dialCode);
//                                     },
//                                     // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
//                                     initialSelection: 'IN',
//                                     favorite: const ['+91', 'IN'],
//                                     // optional. Shows only country name and flag
//                                     showCountryOnly: false,
//                                     // optional. Shows only country name and flag when popup is closed.
//                                     showOnlyCountryWhenClosed: false,
//                                     // optional. aligns the flag and the Text left
//                                     alignLeft: false,
//                                   ),
//                                   const SizedBox(width: 2.0),
//                                   Expanded(
//                                     child: TextFormField(
//                                       style:
//                                           const TextStyle(color: Colors.black),
//                                       keyboardType: TextInputType.number,
//                                       inputFormatters: [
//                                         FilteringTextInputFormatter.digitsOnly,
//                                       ],
//                                       onChanged: (value) {
//                                         print('Phone number changed $value');
//                                         _loginCubit.phoneNumberChanged(value);
//                                       },
//                                       validator: (value) {
//                                         print('validator $value');
//                                         if (value!.length != 10) {
//                                           return 'Invalid Number';
//                                         } else {
//                                           return null;
//                                         }
//                                       },
//                                       controller: _phoneNoController,
//                                       decoration: InputDecoration(
//                                         hintText:
//                                             'Enter phone number eg 8540928389',
//                                         filled: true,
//                                         prefixIcon: Icon(
//                                           Icons.phone,
//                                           color: const Color(0xFF666666),
//                                           size: defaultIconSize,
//                                         ),
//                                         fillColor: const Color(0xFFF2F3F5),
//                                         hintStyle: TextStyle(
//                                           color: const Color(0xFF666666),
//                                           fontFamily: defaultFontFamily,
//                                           fontSize: defaultFontSize,
//                                         ),
//                                         border: const OutlineInputBorder(),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 50.0),
//                             SizedBox(
//                               width: 200.0,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(30.0),
//                                     ),
//                                     padding: const EdgeInsets.all(15.0)),
//                                 // onPressed: signInWithPhoneNumber,
//                                 onPressed: _submit,
//                                 //   () => _submit(
//                                 //    // context,
//                                 //  //   state.status == LoginStatus.submitting,
//                                 //   ),
//                                 child: const Text(
//                                   'GET OTP',
//                                   style: TextStyle(
//                                     fontSize: 18.0,
//                                     fontWeight: FontWeight.w600,
//                                     letterSpacing: 1.2,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             //const Spacer(),
//                             // const SizedBox(height: 70.0),
//                             // const Text('Build with ❤️ from sixteenbrains.com'),
//                             // const SizedBox(height: 20.0),
//                           ],
//                         ),
//                       ),
//                     ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // #PrinceK9973

// class AddOtpPrompt extends StatelessWidget {
//   final String phoneNumber;
//   final String verificationId;

//   const AddOtpPrompt({
//     Key? key,
//     required this.phoneNumber,
//     required this.verificationId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           const Text(
//             'Automatically verifying otp,\n Sit Back And Relax',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18.0,
//             ),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (_) => const PinCodeVerificationScreen(
//                     verificationId: '', phoneNo: ''),
//               ),
//             ),
//             child: const Text('Enter Opt Manually'),
//           )
//         ],
//       ),
//     );
//   }
// }
