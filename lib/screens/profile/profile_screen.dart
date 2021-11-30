import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const Text(
                'Rishu Kumar',
                style: TextStyle(
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
          Expanded(
            child: GridView.builder(
              itemCount: 15,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.red,
                    height: 250.0,
                    width: 100.0,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
