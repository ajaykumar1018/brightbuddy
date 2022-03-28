import 'package:bright_kid/utils/images.dart';

class HomeSubjectsModel {
  String image, title, topics, number;

  HomeSubjectsModel({this.image, this.title, this.topics, this.number});
}

List<HomeSubjectsModel> homeSubjectList = [
  HomeSubjectsModel(
      image: topicColor1,
      title: "My Bright Picture Book of Counting",
      topics: "10",
      number: '1/6'),
  HomeSubjectsModel(
      image: topicColor2,
      title: "Number Tracing & Writing",
      topics: "18",
      number: '2/6'),
  HomeSubjectsModel(
      image: topicColor3,
      title: "Start with Phonics",
      topics: "15",
      number: '4/6'),
  HomeSubjectsModel(
      image: topicColor4, title: "Drawing", topics: "18", number: '0/6'),
  HomeSubjectsModel(
      image: topicColor5, title: "Reading", topics: "12", number: '6/6'),
  HomeSubjectsModel(
      image: topicColor6, title: "Learning", topics: "15", number: '1/6'),
];
