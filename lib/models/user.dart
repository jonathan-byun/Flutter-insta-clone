class ModelUser {
  final String email;
  final String uid;
  final String username;
  final List followers;
  final List following;


  const ModelUser({
    required this.email,
    required this.uid,
    required this.followers,
    required this.following,
    required this.username
  });

  Map<String, dynamic> toJson()=> {
    "email": email,
    "uid": uid,
    "followers": followers,
    "following": following,
    "username": username
  };
}