class BriefModel {
  String? id;
  String? titre;
  String? contexte;
  String? deadline;
  String? date;
  String? image;

  BriefModel({
    this.id,
    this.titre,
    this.contexte,
    this.deadline,
    this.date,
    this.image,
  });

  factory BriefModel.fromJson(Map<String, dynamic> json) => BriefModel(
        id: json["id"],
        titre: json["titre"],
        contexte: json["contexte"],
        deadline: json["deadline"],
        date: json["date"],
        image: json["image"],
      );
}
