import '/blocs/auth/auth_bloc.dart';
import '/screens/home/home_screen.dart';
import '/screens/login/login_screen.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatelessWidget {
  static const String routeName = '/auth';

  const AuthWrapper({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (context, _, __) => const AuthWrapper(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(LoginScreen.routeName);
        } else if (state.status == AuthStatus.authenticated) {
          print(
              'State of user after authentication ----------${state.user?.uid}');
          //   Navigator.of(context).pushNamed(FilteredTodos.routeName);
          // Navigator.of(context)
          //     .pushNamed(ProfileScreen.routeName, arguments: state.user?.uid);
          Navigator.of(context)
              .pushNamed(HomeScreen.routeName, arguments: state.user?.uid);
        }
      },
      child: const Scaffold(
        body: LoadingIndicator(),
      ),
    );
  }
}
