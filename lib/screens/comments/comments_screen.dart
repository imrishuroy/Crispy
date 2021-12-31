import '/blocs/auth/auth_bloc.dart';
import '/models/video.dart';
import '/repository/video/video_repository.dart';
import '/screens/comments/bloc/commnets_bloc.dart';
import '/widgets/error_dialog.dart';
import '/widgets/user_profle_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CommentsScreenArgs {
  final Video video;

  const CommentsScreenArgs({required this.video});
}

class CommentsScreen extends StatefulWidget {
  static const String routeName = '/comments';
  const CommentsScreen({Key? key}) : super(key: key);

  static Route route({required CommentsScreenArgs? args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return BlocProvider(
          create: (_) => CommentsBloc(
            videoRepository: context.read<VideoRepository>(),
            authBloc: context.read<AuthBloc>(),
          )..add(CommentsFetchComments(video: args!.video)),
          child: const CommentsScreen(),
        );
      },
    );
  }

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsBloc, CommentsState>(
      listener: (context, state) {
        if (state.status == CommentsStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(content: state.failure.message),
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop(true);
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.grey.shade900,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(true),
              ),
              backgroundColor: Colors.grey.shade900,
              elevation: 0.0,
              title: const Text('Comments'),
              // actions: const [
              //   Icon(FontAwesomeIcons.telegramPlane, size: 20.0),
              //   SizedBox(width: 15.0),
              // ],
            ),
            //appBar: AppBar(title: const Text('Comments')),
            body: ListView.builder(
              padding: const EdgeInsets.only(bottom: 60.0),
              itemCount: state.comments.length,
              itemBuilder: (BuildContext context, int index) {
                final comment = state.comments[index];
                return ListTile(
                  leading: UserProfileImage(
                    radius: 22.0,
                    profileImageUrl: comment?.author?.imageUrl,
                  ),
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: comment?.author?.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(text: comment?.content),
                      ],
                    ),
                  ),
                  subtitle: Text(
                    (comment?.date != null)
                        ? DateFormat.yMd().add_jm().format(comment!.date)
                        : 'N/A',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(
                    //   ProfileScreen.routeName,
                    //   arguments: ProfileScreenArgs(userId: comment.author!.id!),
                    // );
                  },
                );
              },
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.status == CommentsStatus.submitting)
                    const LinearProgressIndicator(),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Write a comment...'),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          final content = _commentController.text.trim();
                          if (content.isNotEmpty) {
                            FocusScope.of(context).unfocus();
                            context
                                .read<CommentsBloc>()
                                .add(CommentsPostComment(content: content));
                            _commentController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
