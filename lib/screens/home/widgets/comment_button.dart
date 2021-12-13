import '/models/video.dart';
import '/repository/video/video_repository.dart';
import '/screens/comments/comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentButton extends StatefulWidget {
  final Video? video;

  const CommentButton({Key? key, required this.video}) : super(key: key);

  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  @override
  Widget build(BuildContext context) {
    final _videoRepo = context.read<VideoRepository>();
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      // width: 70.0,
      // height: 70.0,
      child: FutureBuilder<int>(
        future: _videoRepo.getCommentsCount(videoId: widget.video?.videoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return SpinKitThreeBounce(
            //   color: Colors.grey.shade400,
            //   size: 20.0,
            // );
          }
          return Column(
            children: [
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.commentDots,
                  size: 35.0,
                ),
                onPressed: () async {
                  if (widget.video != null) {
                    final result = await Navigator.of(context).pushNamed(
                      CommentsScreen.routeName,
                      arguments: CommentsScreenArgs(video: widget.video!),
                    );

                    if (result == true) {
                      setState(() {});
                    }
                  }

                  // showModalBottomSheet<void>(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return Container(
                  //       height: 200,
                  //       color: Colors.amber,
                  //       child: Center(
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: <Widget>[
                  //             const Text('Modal BottomSheet'),
                  //             ElevatedButton(
                  //               child: const Text('Close BottomSheet'),
                  //               onPressed: () => Navigator.pop(context),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //},
                  //  );
                },
              ),

              // Icon(icon, size: isShare ? 25.0 : 35.0, color: Colors.grey[300]),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text('${snapshot.data}',
                    style: const TextStyle(fontSize: 10.0)),
              )
            ],
          );
        },
      ),
    );
  }
}
