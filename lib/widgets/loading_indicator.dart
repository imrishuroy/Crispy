import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  const LoadingIndicator({Key? key, this.size = 50.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 50.0,
        width: 50.0,
        child: SpinKitChasingDots(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
  //   return SpinKitFadingCircle(
  //     itemBuilder: (BuildContext context, int index) {
  //       return DecoratedBox(
  //         decoration: BoxDecoration(color: Colors.blue),
  //       );
  //     },
  //   );
  // }
}
