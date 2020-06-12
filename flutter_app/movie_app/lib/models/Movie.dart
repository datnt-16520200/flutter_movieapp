class Movie {
  int _id;
  String _title;
  String _overview;
  double _popularity;
  String _posterPath;
  int _budget;
  List<dynamic> _genres;
  List<dynamic> _productionCompanies;
  String _releaseDate;
  int _revenue;
  int _runtime;
  List<String> _casts;
  String _director;
  String _backdropPath;
  double _voteAverage;

  Movie(this._id, this._title, this._overview, this._popularity,
      this._posterPath, this._budget, this._genres, this._productionCompanies,
      this._releaseDate, this._revenue, this._runtime, this._casts,
      this._director, this._backdropPath, this._voteAverage);

  String get director => _director;

  List<String> get casts => _casts;

  int get runtime => _runtime;

  int get revenue => _revenue;

  String get releaseDate => _releaseDate;

  List<dynamic> get productionCompanies => _productionCompanies;

  List<dynamic> get genres => _genres;

  int get budget => _budget;

  String get posterPath => _posterPath;

  double get popularity => _popularity;

  String get overview => _overview;

  String get title => _title;

  int get id => _id;

  String get backdropPath => _backdropPath;

  double get voteAverage => _voteAverage;

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      json['id'],
      json['original_title'],
      json['overview'],
      json['popularity'],
      json['poster_path'],
      json['budget'],
      json['genres'],
      json['production_companies'],
      json['release_date'],
      json['revenue'],
      json['runtime'],
      [],
      "",
      json['backdrop_path'],
      json['vote_average']
    );
  }
}