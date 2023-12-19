import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/models/user.dart';
import 'package:flutter_1/pages/single-post-view.dart';
import 'package:flutter_1/providers/user_provider.dart';
import 'package:flutter_1/resources/firestore_methods.dart';
import 'package:flutter_1/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ModelUser? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        body: Profile(user: user!));
  }
}

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.user,
  });

  final ModelUser user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('uid', isEqualTo: user.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.username,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditProfilePopup();
                                }),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(user.photoUrl),
                              radius: 40,
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              TextStack(
                                amount: 20,
                                criteria: 'Posts',
                              ),
                              TextStack(
                                amount: 20,
                                criteria: 'Followers',
                              ),
                              TextStack(
                                amount: 20,
                                criteria: 'Following',
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        user.username,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(user.bio),
                    ],
                  ),
                ),
              ),
              SliverGrid.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (_, int index) {
                    Map<String, dynamic> snap =
                        snapshot.data!.docs[index].data();
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SinglePostPage(
                                      postId: snap['postId'],
                                      userName: snap['username'],
                                    )));
                      },
                      child: Image(
                        image: NetworkImage(snap['postUrls'][0]),
                        fit: BoxFit.cover,
                      ),
                    );
                  })
            ],
          );
        });
  }
}

class EditProfilePopup extends StatefulWidget {
  const EditProfilePopup({
    super.key,
  });

  @override
  State<EditProfilePopup> createState() => _EditProfilePopupState();
}

class _EditProfilePopupState extends State<EditProfilePopup> {
  late final TextEditingController _bioController;
  File? _file;
  @override
  void initState() {
   
    _bioController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Edit Profile',
            style: TextStyle(fontSize: 20),
          ),
          GestureDetector(
              onTap: () async {
                XFile? xFile = await pickImage(ImageSource.gallery);
                if (xFile != null) {
                  File file = File(xFile.path);
                  setState(() {
                    _file = file;
                  });
                }
              },
              child: _file != null
                  ? CircleAvatar(backgroundImage: FileImage(_file!,),radius: 50,)
                  : Icon(
                      FontAwesomeIcons.upload,
                      size: 100,
                    )),
          TextFormField(
              controller: _bioController,
              decoration: InputDecoration(
                hintText: 'new bio',
              )),
          ElevatedButton(
              onPressed: () {
                FireStoreMethods().updateProfile(_file, _bioController.text);
                Navigator.of(context).pop();
              },
              child: Text('Submit'))
        ]),
      ),
    );
  }
}

class TextStack extends StatelessWidget {
  const TextStack({super.key, required this.amount, required this.criteria});
  final int amount;
  final String criteria;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              amount.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(criteria)
          ],
        ));
  }
}
