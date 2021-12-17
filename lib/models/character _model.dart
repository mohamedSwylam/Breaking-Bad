class CharacterModel {
   int charId;
   String name;
   String nickName;
   String birthday;
   String image;
   List<dynamic> jobs;
   String statusIfDeadOrAlive;
   List<dynamic> appearanceOfSeasons;
   String actorName;
   String categoryForTwoSeries;
   List<dynamic> betterCallSaulAppearance;
   CharacterModel({
     this.name,
     this.image,
     this.actorName,
     this.birthday,
     this.appearanceOfSeasons,
     this.betterCallSaulAppearance,
     this.categoryForTwoSeries,
     this.charId,
     this.jobs,
     this.nickName,
     this.statusIfDeadOrAlive,
   });
   CharacterModel.fromJson(Map<String, dynamic> json) {
    charId = json["char_id"];
    name = json["name"];
    birthday = json["birthday"];
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