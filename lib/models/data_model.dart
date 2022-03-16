class DataModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  int? people;
  int? selectedPeople;
  String? img;
  String? location;

  DataModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stars,
    this.people,
    this.selectedPeople,
    this.img,
    this.location,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id : json['id'],
      name : json['name'],
      description : json['description'],
      price : json['price'],
      stars : json['stars'],
      people : json['people'],
      selectedPeople : json['selected_people'],
      img : json['img'],
      location : json['location'],
    );
  }

}
