import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF325372),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text('Khushi Sanghavi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 22),
                          _buildInfoRow(Icons.business, 'Software Development'),
                          const SizedBox(height: 8),
                          _buildInfoRow(Icons.phone, '+91 9876543210'),
                          const SizedBox(height: 8),
                          _buildInfoRow(Icons.badge, 'SAP ID: EMP123456'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Committees', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _buildCommitteeCard(Icons.code, 'Tech Club', 'A club for coding enthusiasts.', '120 Members'),
                  const SizedBox(height: 12),
                  _buildCommitteeCard(Icons.brush, 'Design Club', 'A place for designers to grow.', '90 Members'),
                  const SizedBox(height: 12),
                  _buildCommitteeCard(Icons.sports_esports, 'Gaming Club', 'For all gaming lovers.', '150 Members'),
                  const SizedBox(height: 20),
                  _buildButton('Change Password', Icons.lock, Color(0xFF4C9ACC), () {}),
                  const SizedBox(height: 12),
                  _buildButton('Upload Resume', Icons.upload, Color(0xFFE4E3E8), _pickFile),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }

  Widget _buildCommitteeCard(IconData icon, String title, String description, String members) {
    return Card(
      color: Color(0xFFE4E3E8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF325372)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            Text(members, style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 8),
            Text(text, style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      print('File selected: ${result.files.single.name}');
    } else {
      print('No file selected');
    }
  }
}
