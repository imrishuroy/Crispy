import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VideoDescription extends StatelessWidget {
  const VideoDescription({Key? key}) : super(key: key);
  // The size of the profile image in the follow Action
  static const double profileImageSize = 50.0;

  Widget _getProfilePicture() {
    return Positioned(
      // left: (actionWidgetSize / 2) - (profileImageSize / 2),
      left: 10.0,
      child: Container(
        padding:
            const EdgeInsets.all(1.0), // Add 1.0 point padding to create border
        // height: profileImageSize, // ProfileImageSize = 50.0;
        // width: profileImageSize, // ProfileImageSize = 50.0;

        height: 32.0,
        width: 32.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(profileImageSize / 2)),
        // import 'package:cached_network_image/cached_network_image.dart'; at the top to use CachedNetworkImage
        child: CachedNetworkImage(
          imageUrl:
              'https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100.0,
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _getProfilePicture(),
                const SizedBox(width: 5.0),
                const Text(
                  '@firstjonny',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const Text(
              'Jain\'s Basket',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 2.0),
            // we can user expandable_text: ^2.2.0 for exanding text
            const Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.')

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
