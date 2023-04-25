 
import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String description;
  final String uid;
  final String username;
  final  datePublished;
  final String postId;
  final String postUrl;
  final String profImage;
  final likes;


  const Post({
  required this.username,
  required this.uid,
  required this.description,
  required this.datePublished,
  required this.postId,
  required this.postUrl,
  required this.profImage,
  required this.likes,
  });


  Map<String, dynamic> toJson() => {
          'username': username,
          'uid': uid,
          'description': description,
          'datePublished': datePublished,
          'postId': postId,
          'postUrl': postUrl,
          'profimage': profImage,
          'likes': likes,
          
  };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return  Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      datePublished: snapshot['date published'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profimage'],
      likes: snapshot['likes'],
      
    );
  }

}

