import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animated_list_demo/components/ImageViewer.dart';

void main() {
  runApp(
    MaterialApp(
      home: AnimatedListDemo(),
    ),
  );
}

class UserModel {
  UserModel({this.firstName, this.lastName, this.profileImageUrl, this.herotag});
  String firstName;
  String lastName;
  String profileImageUrl;
  String herotag;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          profileImageUrl == other.profileImageUrl &&
          herotag == other.herotag;

  @override
  int get hashCode =>
      firstName.hashCode ^ lastName.hashCode ^ profileImageUrl.hashCode ^ herotag.hashCode;
}

List<UserModel> listData = [
  UserModel(
    firstName: "Nash",
    lastName: "Ramdial",
    herotag: "one",
    profileImageUrl:
        "https://randomuser.me/api/portraits/men/1.jpg",
  ),
  UserModel(
    firstName: "Scott",
    lastName: "Stoll",
    herotag: "two",
    profileImageUrl:
        "https://randomuser.me/api/portraits/women/2.jpg",
  ),
  UserModel(
    firstName: "Simon",
    lastName: "Lightfoot",
    herotag: "three",
    profileImageUrl:
        "https://randomuser.me/api/portraits/men/3.jpg",
  ),
  UserModel(
    firstName: "Jay",
    lastName: "Meijer",
    herotag: "four",
    profileImageUrl:
        "https://randomuser.me/api/portraits/women/4.jpg",
  ),
  UserModel(
    firstName: "Mariano",
    lastName: "Zorrilla",
    profileImageUrl:
        "https://randomuser.me/api/portraits/men/5.jpg",
  ),
];

class AnimatedListDemo extends StatefulWidget {
  _AnimatedListDemoState createState() => _AnimatedListDemoState();
}

class _AnimatedListDemoState extends State<AnimatedListDemo> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  String randomImageGenerator() {
    return new Random().nextInt(99).toString();
  }

  void addUser() {
    int index = listData.length;
    listData.add(
      UserModel(
        firstName: "Norbert",
        lastName: "Kozsir",
        herotag: Random().nextInt(999).toString(),
        profileImageUrl:
            "https://randomuser.me/api/portraits/men/" + randomImageGenerator() + ".jpg",
      ),
    );
    _listKey.currentState
        .insertItem(index, duration: Duration(milliseconds: 300));
  }

  void deleteUser(int index) {
    var user = listData.removeAt(index);
    _listKey.currentState.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
        return /* ScaleTransition(
              scale: CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
              alignment: Alignment.centerRight, */FadeTransition(
          opacity:
              CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
          child: SizeTransition(
            sizeFactor:
                CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
            axisAlignment: 0.0,
            child: _buildItem(user),
          ),
        );
      },
      duration: Duration(milliseconds: 300),
    );
  }

  void showProfileImage(UserModel user) {
     Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new ImageViewer(imageURL: user.profileImageUrl, heroTag: user.herotag)));
  }

  Widget _buildItem(UserModel user, [int index]) {
    return Dismissible(
      key: ValueKey<UserModel>(user),
      background: Container(color: Colors.redAccent),
      onDismissed: (direction) => deleteUser(index),
      child: index != null ? ListTile(
      onTap: user.profileImageUrl != null ? () => showProfileImage(user) : null,
      key: ValueKey<UserModel>(user),
      title: Text(user.firstName),
      subtitle: Text(user.lastName),
      leading: Hero(
        tag: user.herotag,
        child: CircleAvatar(
        backgroundImage: NetworkImage(user.profileImageUrl),
      )),
    ): null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated List Demo"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: addUser,
        ),
      ),
      body: SafeArea(
        child: AnimatedList(
          key: _listKey,
          initialItemCount: listData.length,
          itemBuilder: (BuildContext context, int index, Animation animation) {
            return FadeTransition(
              opacity: animation,
              child: _buildItem(listData[index], index),
            );
            /* return ScaleTransition(
              scale: animation,
              alignment: Alignment.centerRight,
              child: _buildItem(listData[index], index),
            ); */
          },
        ),
      ),
    );
  }
}
