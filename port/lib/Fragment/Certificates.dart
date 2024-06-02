import 'package:flutter/material.dart';

class Certificates extends StatelessWidget {
  const Certificates({super.key, Key? key1});

  @override
  Widget build(BuildContext context) {
    var myItems = [
      "lib/Assets/images/ssc.jpg",
      "lib/Assets/images/MY PHOTO.jpg",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Certificates"),
        backgroundColor:
            const Color.fromARGB(255, 159, 182, 251), // Set the app bar color
      ),
      body: Container(
        color: const Color.fromARGB(
            255, 163, 173, 237), // Set the background color to black
        child: ListView.builder(
          itemCount: myItems.length,
          itemBuilder: (context, index) {
            return CertificateImage(imagePath: myItems[index]);
          },
        ),
      ),
    );
  }
}

class CertificateImage extends StatelessWidget {
  final String imagePath;

  const CertificateImage({super.key, Key? key1, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4, // Add elevation for a card-like appearance
        child: Column(
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover, // Set the image fit mode
            ),
          ],
        ),
      ),
    );
  }
}
