import '/repository/outlet/outlet_repository.dart';
import '/screens/home/cubit/pageview_cubit.dart';
import 'package:flutter/services.dart';
import '/screens/home/widgets/cubit/likevideo_cubit.dart';
import '/repository/influencer/influencer_repository.dart';
import '/repository/video/video_repository.dart';
import '/screens/home/bloc/video_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/simple_bloc_observer.dart';
import 'config/auth_wrapper.dart';
import 'config/custom_router.dart';
import 'repository/auth/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = kDebugMode;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
        RepositoryProvider<VideoRepository>(
          create: (_) => VideoRepository(),
        ),
        RepositoryProvider<InfluencerRepository>(
          create: (_) => InfluencerRepository(),
        ),
        RepositoryProvider<OutletRepository>(
          create: (_) => OutletRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<LikeVideoCubit>(
            create: (context) => LikeVideoCubit(
              authBloc: context.read<AuthBloc>(),
              videoRepository: context.read<VideoRepository>(),
            ),
          ),
          BlocProvider<PageViewCubit>(create: (_) => PageViewCubit()),
          BlocProvider<VideoBloc>(
            create: (context) => VideoBloc(
              authBloc: context.read<AuthBloc>(),
              likeVideoCubit: context.read<LikeVideoCubit>(),
              videoRepository: context.read<VideoRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: AuthWrapper.routeName,
        ),
      ),
    );
  }
}
