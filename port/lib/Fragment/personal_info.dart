// personal_info.dart

class PersonalInfo {
  String name;
  String photoUrl;
  String bio;
  String contactDetails;

  PersonalInfo({
    required this.name,
    required this.photoUrl,
    required this.bio,
    required this.contactDetails,
  });

  @override
  String toString() {
    return 'Name: $name\nPhoto URL: $photoUrl\nBio: $bio\nContact Details: $contactDetails';
  }
}
