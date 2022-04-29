//used to  save the data coming from the stream

class PostModel {
  String date;
  String posterName;
  String posterPicture;
  String posterUid;
  String subject;

  PostModel(
      {this.date = '',
      this.posterName = '',
      this.posterPicture = '',
      this.posterUid = '',
      this.subject = ''});
}
