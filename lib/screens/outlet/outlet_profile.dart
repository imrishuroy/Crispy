import 'package:crispy/screens/home/home_screen.dart';

import '/repository/outlet/outlet_repository.dart';
import '/config/contants.dart';
import '/widgets/video_thumbnail.dart';
import '/models/outlet.dart';
import '/screens/outlet/bloc/outletprofile_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/outlet_list_videos.dart';

class OutletProfileArgs {
  final Outlet? outlet;

  const OutletProfileArgs({required this.outlet});
}

class OutletProfile extends StatelessWidget {
  static const String routeName = '/outlet-profile';
  final Outlet? outlet;

  const OutletProfile({
    Key? key,
    required this.outlet,
  }) : super(key: key);

  static Route route({required OutletProfileArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => MultiBlocProvider(
        providers: [
          // BlocProvider<OutletPageviewCubit>(
          //   create: (context) => OutletPageviewCubit(),
          // ),
          BlocProvider(
            create: (context) => OutletProfileBloc(
                outletRepo: context.read<OutletRepository>(),
                outletId: args.outlet?.outletId),
          )
        ],
        child: OutletProfile(outlet: args.outlet),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Outlet Id ${outlet?.outletId}');

    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, right: 2.0),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            mini: true,
            onPressed: () =>
                //Navigator.of(context).pop(),

                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreen.routeName, (route) => false),
            child: const Icon(
              Icons.home,
              color: Colors.black87,
            ),
          ),
        ),
        body: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30.0),
              Center(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.deepOrange,
                  child: CircleAvatar(
                    radius: 57.0,
                    backgroundImage:
                        NetworkImage(outlet?.outletImg ?? errorImage),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    outlet?.name ?? 'N/A',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                      fontSize: 17.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    height: 12.0,
                    width: 1.2,
                    color: Colors.grey.shade800,
                  ),
                  const SizedBox(width: 10.0),
                  const Text(
                    '3.5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                  const SizedBox(width: 3.0),
                  const Text(
                    '✮',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 17.0,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Container(
                    height: 12.0,
                    width: 1.2,
                    color: Colors.grey.shade800,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.location_on_sharp,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SizedBox(
                  height: 50.0,
                  child: SingleChildScrollView(
                    child: Text(
                      outlet?.about ?? 'N/A',
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              BlocConsumer<OutletProfileBloc, OutletProfileState>(
                listener: (context, state) {},
                builder: (context, state) {
                  switch (state.status) {
                    case OutletProfileStatus.succuss:
                      final videos = state.outletVideos;
                      print('Length ${videos.length}');

                      return Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                          ),
                          child: GridView.builder(
                            itemCount: videos.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, index) {
                              final video = videos[index];

                              return InkWell(
                                  onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => OutletListVideos(
                                            videos: videos,
                                            openIndex: index,
                                          ),
                                        ),
                                      ),

                                  // Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //         builder: (_) =>
                                  //             BlocProvider<OutletPageviewCubit>(
                                  //           create: (context) =>
                                  //               OutletPageviewCubit(),
                                  //           child: ViewOutletVideos(
                                  //             videos: videos,
                                  //             openIndex: index,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  // onTap: () => Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //         builder: (_) =>
                                  //             VideoPreview(video: video),
                                  //       ),
                                  //     ),
                                  child: VideoThumbNail(
                                      videoUrl: video?.videoUrl));
                            },
                          ),
                        ),
                      );
                    default:
                      return const SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: SpinKitChasingDots(
                          color: Colors.blue,
                          size: 50.0,
                        ),
                      );
                    //return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            ],
          ),
        )

        // FutureBuilder<Influencer?>(
        //   future: _influencerRepo.getInfluencer(influencerId: influencerId),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     }

        //     final influencer = snapshot.data;

        //     return
        //   },
        // ),
        );
  }
}

/*
SizedBox(
                height: 100.0,
                child: StreamBuilder<List<Future<Video?>>>(
                  stream: _influencerRepo.streamInfluencerVideos(
                      influencerId: 'l9AEs8tdIiQGosPg1xZ9'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final videos = snapshot.data;

                    return ListView.builder(
                      itemCount: videos?.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<Video?>(
                          future: videos?[index],
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final data = snapshot.data;
                            return Text(
                              '${data?.videoUrl}',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
*/
