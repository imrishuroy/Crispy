// import '/repository/auth/auth_repository.dart';
// import '/widgets/error_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '/widgets/loading_indicator.dart';

// // import '/screens/login/cubit/login_cubit.dart';
// // import '/widgets/erro_dialog.dart';
// import 'otp_verification_screen.dart';

// String defaultFontFamily = 'Roboto-Light.ttf';
// double defaultFontSize = 14;
// double defaultIconSize = 17;

// class PhLoginScreen extends StatefulWidget {
//   static const String routeName = '/ph-login';
//   const PhLoginScreen({Key? key}) : super(key: key);

//   static Route route() {
//     return MaterialPageRoute(
//       settings: const RouteSettings(name: routeName),
//       builder: (context) => const PhLoginScreen(),
//       // builder: (context) => BlocProvider<LoginCubit>(
//       //   create: (_) => LoginCubit(
//       //     authRepository: context.read<AuthRepository>(),
//       //   ),
//       //   child: LoginScreen(),
//       // ),
//     );
//   }

//   @override
//   State<PhLoginScreen> createState() => _PhLoginScreenState();
// }

// class _PhLoginScreenState extends State<PhLoginScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final _phoneNoController = TextEditingController();
//   bool _loading = false;

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
//         setState(() {
//           _loading = true;
//         });

//         final authRepo = context.read<AuthRepository>();

//         final otp = '';
//         //await authRepo.signUpWithPhone(phoneNo: _phoneNoController.text);

//         if (otp != null) {
//           setState(() {
//             _loading = false;
//           });
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (_) => PinCodeVerificationScreen(
//                 phoneNumber: _phoneNoController.text,
//                 otp: otp,
//               ),
//             ),
//           );
//         }

//         //context.read<LoginCubit>().signUpWithCredentials();
//         // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
//         // Navigator.of(context)
//         //     .pushNamedAndRemoveUntil(AuthWrapper.routeName, (route) => false);
//         // Navigator.of(context).push(
//         //   MaterialPageRoute(
//         //     builder: (_) => PinCodeVerificationScreen(
//         //       phoneNumber: context.read<LoginCubit>().state.phoneNumber,
//         //       otp: context.read<LoginCubit>().state.otp,
//         //     ),
//         //   ),
//         // );
//         setState(() {
//           _loading = true;
//         });
//       }
//     } catch (error) {
//       print('Error login ${error.toString()}');
//       setState(() {
//         _loading = true;
//       });
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
//     return _loading
//         ? const Scaffold(body: LoadingIndicator())
//         : GestureDetector(
//             onTap: () => FocusScope.of(context).unfocus(),
//             child: Scaffold(
//               body:

//                   // BlocConsumer<LoginCubit, LoginState>(
//                   //   listener: (context, state) {
//                   //     if (state.status == LoginStatus.error) {
//                   //       print('State ERROR MESSAGE ${state.failure.message}');
//                   //       showDialog(
//                   //         context: context,
//                   //         builder: (context) => ErrorDialog(
//                   //           content: state.failure.message,
//                   //         ),
//                   //       );
//                   //     } else if (state.status == LoginStatus.succuss) {
//                   //       showSnackBar(
//                   //         context: context,
//                   //         title:
//                   //             'Thank you for registering with us. Kindly check your message inbox for OTP',
//                   //       );
//                   //     }
//                   //   },
//                   //   builder: (context, state) {
//                   //     return state.status == LoginStatus.submitting
//                   //         ? const Scaffold(
//                   //             backgroundColor: Colors.white,
//                   //             body: Center(child: CircularProgressIndicator()),
//                   //           )
//                   //         :

//                   Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     //crossAxisAlignment: CrossAxisAlignment.stretch,
//                     //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const SizedBox(height: 25.0),

//                       const SafeArea(
//                         child: SizedBox(
//                           height: 220.0,
//                           width: double.infinity,
//                           // child: Image.asset('assets/scrapxo.png'),
//                         ),
//                       ),
//                       // Stack(
//                       //   children: [
//                       //     Container(
//                       //       height: 220.0,
//                       //       width: double.infinity,
//                       //       child: Image.asset('assets/scrapxo.png'),
//                       //       //  Image.network(
//                       //       //   'https://www.coremarkmetals.com/files/image/medium/STAINLESS_303_BAR_ROUND_OMS.jpg',
//                       //       //   fit: BoxFit.cover,
//                       //       // ),
//                       //     ),
//                       //     // Container(
//                       //     //   height: 220.0,
//                       //     //   width: double.infinity,
//                       //     //   color: Colors.black45,
//                       //     // ),
//                       //     // Positioned(
//                       //     //   top: 40.0,
//                       //     //   left: 20.0,
//                       //     //   child: Text(
//                       //     //     'Scrapxo',
//                       //     //     style: GoogleFonts.roboto(
//                       //     //       fontSize: 30.0,
//                       //     //       letterSpacing: 1.5,
//                       //     //       //color: Colors.white,
//                       //     //       fontWeight: FontWeight.w600,
//                       //     //     ),
//                       //     //   ),
//                       //     // ),
//                       //   ],
//                       // ),
//                       const SizedBox(height: 150.0),

//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                           ],
//                           // onChanged: (value) => context
//                           //     .read<LoginCubit>()
//                           //     .phoneNumberChanged(value),
//                           validator: (value) {
//                             if (value!.length != 10) {
//                               return 'Invalid Number';
//                             } else {
//                               return null;
//                             }
//                           },
//                           controller: _phoneNoController,
//                           decoration: InputDecoration(
//                             hintText: 'Enter phone number eg 8540928389',
//                             filled: true,
//                             prefixIcon: Icon(
//                               Icons.phone,
//                               color: const Color(0xFF666666),
//                               size: defaultIconSize,
//                             ),
//                             fillColor: const Color(0xFFF2F3F5),
//                             hintStyle: TextStyle(
//                               color: const Color(0xFF666666),
//                               fontFamily: defaultFontFamily,
//                               fontSize: defaultFontSize,
//                             ),
//                             border: const OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                       // Spacer(),
//                       const SizedBox(height: 90.0),
//                       SizedBox(
//                         width: 200.0,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30.0),
//                               ),
//                               padding: const EdgeInsets.all(15.0)),
//                           onPressed: _submit,
//                           //   () => _submit(
//                           //    // context,
//                           //  //   state.status == LoginStatus.submitting,
//                           //   ),
//                           child: const Text(
//                             'GET OTP',
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                         ),
//                       ),
//                       //  const SizedBox(height: 100.0),
//                       //const Spacer(),
//                       //SizedBox(height: 10.0),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//   }
// }
