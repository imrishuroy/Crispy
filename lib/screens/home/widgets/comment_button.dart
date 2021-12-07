import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentButton extends StatelessWidget {
  const CommentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      // width: 70.0,
      // height: 70.0,
      child: Column(
        children: [
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.commentDots,
              size: 35.0,
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    color: Colors.amber,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Modal BottomSheet'),
                          ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // Icon(icon, size: isShare ? 25.0 : 35.0, color: Colors.grey[300]),
          const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('40', style: TextStyle(fontSize: 10.0)),
          )
        ],
      ),
    );
  }
}
