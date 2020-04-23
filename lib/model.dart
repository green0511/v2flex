
class ItemMember {
  final String avatarLarge;
  final String avatarMini;
  final String avatarNormal;
  final String bio;
  final String btc;
  final int created;
  final int id;
  final String github;
  final String location;
  final String psn;
  final String tagline;
  final String twitter;
  final String url;
  final String username;
  final String website;

  ItemMember.fromJSON(Map<String, dynamic> json):
    avatarLarge = json['avatar_large'],
    avatarMini = json['avatar_mini'],
    avatarNormal = json['avatar_normal'],
    bio = json['bio'],
    btc = json['btc'],
    created = json['created'],
    id = json['id'],
    github = json['github'],
    location = json['location'],
    psn = json['psn'],
    tagline = json['tagline'],
    twitter = json['twitter'],
    url = json['url'],
    username = json['username'],
    website = json['website'];
}

class ItemSummary {
  final String title;
  final int id;
  final String content;
  final String contentRendered;
  final int created;
  final int lastModified;
  final int lastTouched;
  final int replies;
  final String url;
  final ItemMember member;

  ItemSummary.fromJSON(Map<String, dynamic> json):
    title = json['title'],
    id = json['id'],
    content = json['content'],
    contentRendered = json['content_rendered'],
    created = json['created'],
    lastModified = json['last_modified'],
    lastTouched = json['last_touched'],
    replies = json['replies'],
    url = json['url'],
    member = ItemMember.fromJSON(json['member']);
}
