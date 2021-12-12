import '/repository/video/video_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavButton extends StatelessWidget {
  final VoidCallback onLike;
  final bool isLiked;
  final String? videoId;

  const FavButton({
    Key? key,
    required this.onLike,
    required this.isLiked,
    required this.videoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _videoRepo = context.read<VideoRepository>();
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          IconButton(
            onPressed: onLike,
            icon: isLiked
                ? const Icon(Icons.favorite,
                    color: Colors.redAccent, size: 36.0)
                : const Icon(Icons.favorite_outline, size: 35.0),
          ),
          SizedBox(
            height: 22.0,
            width: 100.0,
            child: FutureBuilder<int>(
              future: _videoRepo.getLikesCount(videoId: videoId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // return SpinKitThreeBounce(
                  //   color: Colors.grey.shade400,
                  //   size: 20.0,
                  // );
                }
                return Text(
                  '${snapshot.data}',
                  style: const TextStyle(fontSize: 10.0),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}










// import 'package:crispy/repository/auth/auth_repository.dart';
// import 'package:crispy/repository/video/video_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class FavButton extends StatefulWidget {
//   final String? videoId;

//   const FavButton({Key? key, required this.videoId}) : super(key: key);

//   @override
//   State<FavButton> createState() => _FavButtonState();
// }

// class _FavButtonState extends State<FavButton> {
//   @override
//   Widget build(BuildContext context) {
//     final _videoRepo = context.read<VideoRepository>();
//     final _authRepo = context.read<AuthRepository>();
//     return FutureBuilder<bool?>(
//       future: _videoRepo.checkVideoLikeOrNot(
//           userId: _authRepo.userId, videoId: 'jdbSVpdJdKEaEGMv581q'),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         final isLiked = snapshot.data ?? false;

//         print('Is LIked $isLiked');
//         return Container(
//           margin: const EdgeInsets.only(top: 15.0),
//           width: 80.0,
//           height: 80.0,
//           child: Column(
//             children: [
//               IconButton(
//                 onPressed: () async {
//                   // await _videoRepo.checkVideoLikeOrNot(
//                   //     userId: _authRepo.userId,
//                   //     videoId: 'jdbSVpdJdKEaEGMv581q');

//                   setState(() {
//                     final userId = context.read<AuthRepository>().userId;
//                     //await FirebaseAuth.instance.signOut();
//                     //print('Current User Id ${.userId}');
//                     //  print('Video Id ${widget.video?.videoId}');
//                     context.read<VideoRepository>().likeVideo(
//                         userId: userId, videoId: 'CnPywpSfDK2CQ9KnMvSc');
//                   });
//                 },
//                 icon: Icon(
//                   Icons.favorite,
//                   size: 42.0,
//                   color: isLiked ? Colors.red : Colors.white,
//                 ),
//               ),

//               // Icon(icon, size: isShare ? 25.0 : 35.0, color: Colors.grey[300]),
//               const Padding(
//                 padding: EdgeInsets.only(top: 5.0),
//                 child: Text('3.2m', style: TextStyle(fontSize: 10.0)),
//               )
//             ],
//           ),
//         );
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
