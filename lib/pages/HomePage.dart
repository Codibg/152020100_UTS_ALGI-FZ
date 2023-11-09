import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twittclose/components/my_textfield.dart';
import '../components/drawer.dart';
import '../components/wall_post.dart';
import 'profile_page.dart'; // Sesuaikan nama file dengan nama file sebenarnya

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();

  // keluar pengguna
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // kirim pesan
  void postMessage() {
    // hanya posting textfield
    if (textController.text.isNotEmpty) {
      // simpan di firebase
      FirebaseFirestore.instance.collection("UserPosts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
      });
    }

    //clear text
    textController.clear();
  }

  //navigate
  void goToProfilePage(BuildContext context) {
    //pop menu
    Navigator.pop(context);

    //go to profile
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Beranda'),
        backgroundColor: Colors.black,
      ),
      drawer: MyDrawer(
        onProfileTap: () => goToProfilePage(context),
        onSignOut: signUserOut,
      ),
      body: Center(
        child: Column(
          children: [
            // beranda
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("UserPosts")
                    .orderBy(
                      "TimeStamp",
                      descending: false,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        // dapatkan pesan
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),

            // posting
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: 'Tulis sesuatu di dinding...',
                      obscureText: false,
                    ),
                  ),

                  // tombol posting
                  IconButton(
                    onPressed: postMessage,
                    icon: const Icon(Icons.arrow_circle_up),
                  )
                ],
              ),
            ),

            // masuk sebagai
            Text(
              "Masuk sebagai: ${currentUser.email!}",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
