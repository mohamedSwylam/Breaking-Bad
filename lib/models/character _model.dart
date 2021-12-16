class Character {
   int charId;
   String name;
   String nickName;
   String image;
   List<dynamic> jobs;
   String statusIfDeadOrAlive;
   List<dynamic> appearanceOfSeasons;
   String actorName;
   String categoryForTwoSeries;
   List<dynamic> betterCallSaulAppearance;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json["char_id"];
    name = json["name"];
    nickName = json["nickname"];
    image = json["img"];
    jobs = json["occupation"];
    statusIfDeadOrAlive = json["status"];
    appearanceOfSeasons = json["appearance"];
    actorName = json["portrayed"];
    categoryForTwoSeries = json["category"];
    betterCallSaulAppearance = json["better_call_saul_appearance"];
  }
}