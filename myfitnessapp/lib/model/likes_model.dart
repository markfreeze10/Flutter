import 'package:json_annotation/json_annotation.dart';

part 'likes_model.g.dart';

@JsonSerializable()
class LikeData {
  final String? identifier;
  bool? liked;

  LikeData({this.identifier, this.liked});

  factory LikeData.fromJson(Map<String, dynamic> json) =>
      _$LikeDataFromJson(json);

  Map<String, dynamic> toJson() => _$LikeDataToJson(this);
}
