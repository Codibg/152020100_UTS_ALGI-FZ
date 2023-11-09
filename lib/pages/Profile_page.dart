import 'package:flutter/material.dart';
import '../components/BMIPage.dart';

class ProfilePage extends StatelessWidget {
  void editBio(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BMIPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'PROFILE',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nama: ferdi',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Email: ferdi@mhs.itenas.ac.id',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 30),
            Text(
              'BIO',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'sambo gun shop',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                editBio(context);
              },
              child: Text('BMI PAGE'),
            ),
          ],
        ),
      ),
    );
  }
}
