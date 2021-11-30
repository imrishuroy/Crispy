import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/simple_bloc_observer.dart';
import 'repository/auth/auth_repository.dart';
import 'screens/profile/profile_screen.dart';

// import 'ui/home/home_view.dart';

//void main() => runApp(const MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = kDebugMode;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          // ),
          // for example video player

          theme: ThemeData.dark(),
          // theme: ThemeData(
          //   // Uncomment in phase 3 to apply white to text
          //   textTheme: Theme.of(context)
          //       .textTheme
          //       .apply(bodyColor: Colors.white, displayColor: Colors.white),
          // ),
          //  home: const SplashScreen(),
          // home: const HomeScreen(),
          home: const ProfileScreen(),
          // onGenerateRoute: CustomRouter.onGenerateRoute,
          // initialRoute: AuthWrapper.routeName,
        ),
      ),
    );
  }
}
