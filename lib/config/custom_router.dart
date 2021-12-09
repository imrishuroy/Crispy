import '/config/auth_wrapper.dart';
import '/screens/comments/comments_screen.dart';
import '/screens/home/home_screen.dart';
import '../screens/liked-videos/liked_videos_screen.dart';
import '/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const Scaffold());

      case AuthWrapper.routeName:
        return AuthWrapper.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case HomeScreen.routeName:
        return HomeScreen.route();

      case LikedVideos.routeName:
        return LikedVideos.route();

      case CommentsScreen.routeName:
        return CommentsScreen.route(
            args: settings.arguments as CommentsScreenArgs);

      default:
        return ErrorRoute.route();
    }
  }

  // static Route onGenerateNestedRouter(RouteSettings settings) {
  //   print('NestedRoute: ${settings.name}');
  //   switch (settings.name) {
  //     case ProfileScreen.routeName:
  //       return ProfileScreen.route();
  //     // args: settings.arguments as ProfileScreenArgs);
  //     case GalleryScreen.routeName:
  //       return GalleryScreen.route();
  //     case DashBoard.routeName:
  //       return DashBoard.route();
  //     default:
  //       return _errorRoute();
  //   }
  // }

  // static Route _errorRoute() {
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: '/error'),
  //     builder: (_) => Scaffold(
  //       appBar: AppBar(
  //         title: const Text(
  //           'Error',
  //         ),
  //       ),
  //       body: Center(
  //         child: Column(
  //           children: [
  //             Text(
  //               'Something went wrong',
  //               style: TextStyle(
  //                 color: Colors.black,
  //               ),
  //             ),
  //             const SizedBox(height: 6.0),
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pushNamed('/');
  //                 },
  //                 child: Text('Re Try'))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({Key? key}) : super(key: key);

  static const String routeNmae = '/error';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeNmae),
      builder: (_) => const ErrorRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AuthWrapper.routeName, (route) => false);
    return Center(
      child: Column(
        children: [
          const Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6.0),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AuthWrapper.routeName, (route) => false);
              },
              child: const Text('Re Try'))
        ],
      ),
    );
  }
}
