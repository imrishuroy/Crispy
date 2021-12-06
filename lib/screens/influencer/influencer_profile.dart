import 'package:crispy/models/influencer.dart';

import '/screens/influencer/bloc/influencer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/video_preview.dart';

class InfluencerProfile extends StatelessWidget {
  final Influencer? influencer;

  const InfluencerProfile({
    Key? key,
    required this.influencer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final _influencerRepo = context.read<InfluencerRepository>();
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     final data = _influencerRepo
        //         .streamInfluencerVideos(influencerId: 'l9AEs8tdIiQGosPg1xZ9')
        //         .map((event) => event);
        //   },
        // ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            const Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                    'https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg'),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  influencer?.name ?? 'N/A',
                  style: const TextStyle(
                    color: Colors.black,
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
                    color: Colors.black,
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
                    color: Colors.grey,
                    size: 20.0,
                  ),
                ),
              ],
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
                      child: GridView.builder(
                        itemCount: videos.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final video = videos[index];

                          return VideoPreview(videoUrl: video?.videoUrl);
                        },
                      ),
                    );
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
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
