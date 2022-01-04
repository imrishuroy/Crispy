import '/config/contants.dart';
import 'package:crispy/models/video.dart';
import 'package:flutter/material.dart';

class OutletVideoDescription extends StatelessWidget {
  final Video? video;
  // The size of the profile image in the follow Action
  static const double profileImageSize = 50.0;

  const OutletVideoDescription({Key? key, required this.video})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120.0,
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
                const SizedBox(width: 5.0),
                Text(
                  '@${video?.influencer?.name ?? ''}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

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
            )

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
