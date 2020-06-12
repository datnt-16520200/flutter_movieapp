import 'dart:async';

class MovieDetailPageBloc {
  StreamController _ratingBarController = new StreamController();
  int _rating = 0;

  MovieDetailPageBloc(){
    _ratingBarController.sink.add(_rating);
  }

  Stream get ratingBarStream => _ratingBarController.stream;

  void iconButtonPress(int value){
    _rating = value;
    _ratingBarController.sink.add(_rating);
    // Gọi api, thêm hoặc sửa dữ liệu vào bảng ratings database
  }

  void dispose(){
    _ratingBarController.close();
  }
}