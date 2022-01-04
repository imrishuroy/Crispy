import '/screens/influencer/influencer_profile.dart';

import '/config/contants.dart';
import '/models/video.dart';
import 'package:flutter/material.dart';

class VideoDescription extends StatelessWidget {
  final Video? video;
  // The size of the profile image in the follow Action
  static const double profileImageSize = 50.0;

  const VideoDescription({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 130.0,
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  radius: 17.3,
                  child: CircleAvatar(
                    radius: 16.5,
                    backgroundImage: NetworkImage(
                      video?.influencer?.profilePic ?? errorImage,
                    ),
                  ),
                ),

                // Container(
                //   padding: const EdgeInsets.all(1.0),

                //   height: 32.0,
                //   width: 32.0,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(profileImageSize / 2),
                //   ),
                //   // import 'package:cached_network_image/cached_network_image.dart'; at the top to use CachedNetworkImage
                //   child: CachedNetworkImage(
                //     imageUrl: video?.influencer?.profilePic ?? errorImage,
                //     // imageUrl:
                //     //     '',
                //     //  placeholder: (context, url) => const CircularProgressIndicator(),
                //     // errorWidget: (context, url, error) => const Icon(Icons.error),
                //   ),
                //  ),
                const SizedBox(width: 5.0),
                Column(
                  children: [
                    Text(
                      '@${video?.influencer?.name ?? ''}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4.0),
                    SizedBox(
                      height: 20.0,
                      width: 90.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        onPressed: () => Navigator.of(context).pushNamed(
                          InfluencerProfile.routeName,
                          arguments: InfluencerProfileArgs(
                              influencer: video?.influencer),
                        ),
                        child: const Text(
                          'Visit Profile',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    // InkWell(
                    //   onTap: () {},
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 4.5,
                    //       vertical: 2.0,
                    //     ),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(6.0),
                    //       border: Border.all(color: Colors.black87),
                    //     ),
                    //     child: const Text(
                    //       'Visit Profile',
                    //       style: TextStyle(
                    //         fontSize: 12.0,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 7.0),

            Text(
              video?.outlet?.name ?? 'N/A',
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
              ),
            ),
            //const SizedBox(height: 2.0),
            // we can user expandable_text: ^2.2.0 for exanding text
            SizedBox(
              height: 50.0,
              child: SingleChildScrollView(
                child: Text(video?.outlet?.about ?? 'N/A'),
              ),
            ),
            const SizedBox(height: 10.0),

            // const Text('Video title and some other stuff'),
            // Row(
            //   children: const [
            //     Icon(
            //       Icons.music_note,
            //       size: 15.0,
            //       color: Colors.white,
            //     ),
            //     Text('Artist name - Album name - song',
            //         style: TextStyle(fontSize: 12.0))
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
