import 'dart:io';
import 'package:eventsync/notifications.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final ImagePicker _picker = ImagePicker();
  String selectedCategory = "All";

  List<Map<String, dynamic>> stories = [
    {"name": "Your Story", "image": null, "isNew": false, "isUser": true},
    {"name": "Sarah K.", "image": null, "isNew": true},
    {"name": "Mike R.", "image": null, "isNew": true},
    {"name": "Alex M.", "image": null, "isNew": false},
    {"name": "Emma T.", "image": null, "isNew": true},
  ];

  void _viewStory(int index) {
    setState(() {
      stories[index]['isNew'] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF325372),
            title: const Text(
              'EventSync',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(stories.length, (index) {
                    return GestureDetector(
                      onTap: () => _viewStory(index),
                      child: storyItem(
                        stories[index]["name"],
                        stories[index]["image"],
                        stories[index]["isNew"],
                        stories[index]["isUser"] ?? false,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    categoryButton("All"),
                    categoryButton("Events"),
                    categoryButton("Recruitment"),
                    categoryButton("Membership"),
                    categoryButton("Networking"),
                    categoryButton("Workshops"),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: [
                    eventCard(
                      logo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx1ifvMfrD9VzaphHBYLhM6wUV-YHR0g28Ow&s',
                      committee: 'Google Developer Groups',
                      category: 'Events',
                      title: 'HackNiche 3.0',
                      description: "Join us for 24 hours of coding, innovation, and fun! Great prizes and networking opportunities await.",
                      image: 'https://cdn.prod.website-files.com/5b3dd54182ecae4d1602962f/609e33e18c5000af6211f094_HR%20Hackathon%20-%20Section%202.jpg',
                      likes: 128,
                      comments: 45,
                    ),
                    eventCard(
                      logo: 'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/00/e5/9f/00e59fff-23f8-ff62-aa96-a7fb5744524b/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/512x512bb.jpg',
                      committee: 'DJCSI',
                      category: 'Memberships',
                      title: 'Membership Drive 2025',
                      description: "Join us for a membership drive and get access to exclusive events and workshops.",
                      image: 'https://www.publicsectorexecutive.com/write/MediaUploads/ThinkstockPhotos-497982910.jpg',
                      likes: 128,
                      comments: 45,
                    ),
                    eventCard(
                      logo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVvB5Rfk1gSK7kFw1jPFAQAc8_gYa24lw-V-jnko9GrQbvC2j-w_EzFj5DgYVFB5A0wYc&usqp=CAU',
                      committee: 'DJSCE Trinity',
                      category: 'Events',
                      title: 'Trinity 2025',
                      description: "3 day fest with a lot of fun and enjoyment.",
                      image: 'https://old.djsce.ac.in/common/uploads/HomeTemplate/19_MImage_trinity.jpg',
                      likes: 128,
                      comments: 45,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const NotificationsScreen(),
      ],
    );
  }

  Widget storyItem(String name, File? imageFile, bool isNew, bool isUser) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: isNew ? const EdgeInsets.all(3) : EdgeInsets.zero,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isNew
                      ? const LinearGradient(
                          colors: [Colors.blue, Colors.blueAccent],
                        )
                      : const LinearGradient(
                          colors: [Colors.grey, Colors.grey],
                        ),
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile)
                      : const AssetImage("assets/default_profile.png") as ImageProvider,
                  child: imageFile == null ? const Icon(Icons.person, size: 40, color: Colors.white) : null,
                ),
              ),
              if (isUser)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add, size: 18, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget categoryButton(String text) {
    bool isSelected = text == selectedCategory;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xFF325372) : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        onPressed: () {
          setState(() {
            selectedCategory = text;
          });
        },
        child: Text(text),
      ),
    );
  }

  Widget eventCard({
  required String logo,
  required String category,
  required String title,
  required String description,
  required String image,
  required int likes,
  required int comments,
  required String committee, // Callback for saving the post
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row with logo, committee, and more icon
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(logo),
                radius: 15,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Committee Name
                    Text(committee, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    // Category in a smaller font
                    Text(category, style: const TextStyle(fontSize: 12, color: Colors.blueGrey)),
                  ],
                ),
              ),
              const Icon(Icons.more_vert, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 10),

          // Event Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(image, height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 10),

          // Title
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),

          // Description
          Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 10),

          // Likes, Comments & Save Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.favorite_border, color: Colors.grey, size: 18),
                  const SizedBox(width: 5),
                  Text('$likes'),
                  const SizedBox(width: 20),
                  const Icon(Icons.chat_bubble_outline, color: Colors.grey, size: 18),
                  const SizedBox(width: 5),
                  Text('$comments'),
                  const SizedBox(width: 225),
                  const Icon(Icons.bookmark_border, color: Colors.blue),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}
