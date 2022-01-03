import '/config/contants.dart';

import '/widgets/video_thumbnail.dart';

import '/repository/influencer/influencer_repository.dart';

import '/models/influencer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/screens/influencer/bloc/influencer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/videos/influencer_video_list.dart';

class InfluencerProfileArgs {
  final Influencer? influencer;

  const InfluencerProfileArgs({required this.influencer});
}

class InfluencerProfile extends StatefulWidget {
  final Influencer? influencer;

  const InfluencerProfile({
    Key? key,
    required this.influencer,
  }) : super(key: key);

  static const String routeName = '/influencer-profile';

  static Route route({required InfluencerProfileArgs? args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return BlocProvider<InfluencerBloc>(
          create: (context) => InfluencerBloc(
            influencerRepo: context.read<InfluencerRepository>(),
            influencerId: args?.influencer?.influencerId,
          ),
          child: InfluencerProfile(influencer: args?.influencer),
        );
      },
    );
  }

  @override
  State<InfluencerProfile> createState() => _InfluencerProfileState();
}

class _InfluencerProfileState extends State<InfluencerProfile> {
  // late BetterPlayerConfiguration? betterPlayerConfiguration;
  // late BetterPlayerListVideoPlayerController? _videoController;

  // @override
  // void initState() {
  //   _videoController = BetterPlayerListVideoPlayerController();
  //   // betterPlayerConfiguration = const BetterPlayerConfiguration(autoPlay: true);
  //   betterPlayerConfiguration =
  //       const BetterPlayerConfiguration(autoPlay: false);

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print(
        'Influencer id  ${widget.influencer?.influencerId}'); //final _influencerRepo = context.read<InfluencerRepository>();
    print('Influencer id  ${widget.influencer?.name}');

    print('Influencer id  ${widget.influencer?.bio}');
    return Scaffold(

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     final data = _influencerRepo
        //         .streamInfluencerVideos(influencerId: 'l9AEs8tdIiQGosPg1xZ9')
        //         .map((event) => event);
        //   },
        // ),
        //  backgroundColor: Colors.white,
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: Colors.white,
        //   elevation: 0.0,
        // ),
        //   title: const Text(
        //     'Profile',
        //     style: TextStyle(
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        body: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50.0),
          Center(
            child: CircleAvatar(
              radius: 60.0,
              backgroundColor: Colors.deepOrange,
              child: CircleAvatar(
                radius: 57.0,
                backgroundImage:
                    NetworkImage(widget.influencer?.profilePic ?? errorImage),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.influencer?.name ?? 'N/A',
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
            child: Text(
              widget.influencer?.bio ?? 'N/A',
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30.0),
          BlocConsumer<InfluencerBloc, InfluencerState>(
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.status) {
                case InfluencerStatus.succuss:
                  final videos = state.influencerVideos;
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
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          return InkWell(
                              onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => InfluencerListVideos(
                                        videos: videos,
                                      ),
                                    ),
                                  ),

                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (_) => ViewInfluencerVideos(
                              //       videos: videos,
                              //       openIndex: index,
                              //       influencer: widget.influencer,
                              //     ),
                              //   ),
                              // ),
                              child: VideoThumbNail(videoUrl: video?.videoUrl));
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
