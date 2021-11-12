class Character {
  late int chartId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String statusIfDeadOrLive;
  late List<dynamic> appearanceOfSeasons;
  late String atorName;
  late String categoryForTwoSeries;
  late List<dynamic> betterCallSaulAppearance;

  Character.fromJson(Map<String, dynamic> json) {
    chartId = json["char_id"];
    name = json["name"];
    nickName = json["nickname"];
    image = json["img"];
    jobs = json["occupation"];
    statusIfDeadOrLive = json["status"];
    appearanceOfSeasons = json["appearance"];
    atorName = json["portrayed"];
    categoryForTwoSeries = json["category"];
    betterCallSaulAppearance = json["better_call_saul_appearance"];
  }
}
