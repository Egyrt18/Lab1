import 'package:flutter/material.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Generator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageScreen(),
    );
  }
}

class ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final List<String> _imageUrls = [
    'https://picsum.photos/400/200',
    'https://picsum.photos/400/201',
    'https://picsum.photos/400/202',
    'https://picsum.photos/400/203',
  ];

  String _currentImageUrl = 'https://picsum.photos/400/200';

  void _generateNewImage() {
    setState(() {
      _currentImageUrl = _imageUrls[Random().nextInt(_imageUrls.length)];
    });
  }

  Future<void> _launchURL() async {
    if (await canLaunch(_currentImageUrl)) {
      await launch(_currentImageUrl);
    } else {
      throw 'Could not launch $_currentImageUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Генератор картинок'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              _currentImageUrl,
              height: 200,
              width: 400,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              ' $_currentImageUrl',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _launchURL,
                  child: Text('Перейти до картинки'),
                ),
                ElevatedButton(
                  onPressed: _generateNewImage,
                  child: Text('Згенерувати нову картинку'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
