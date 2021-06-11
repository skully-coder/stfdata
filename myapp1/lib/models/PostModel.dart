class PostModel {
  PostModel({
    this.id,
    this.image,
    this.likes,
    this.link,
    this.tags,
    this.text,
    this.userId,
    this.ownerId,
    this.ownerFName,
    this.ownerLName,
    this.publishDate,
  });
  var tags;
  var id;
  var text;
  var link;
  var likes;
  var image;
  var userId;
  var ownerId;
  var ownerFName;
  var ownerLName;
  var publishDate;
  display() {
    print('$id\t$text');
  }
}
