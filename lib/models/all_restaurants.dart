class AllRestaurant {
  String imagePath;
  List<Restaurants> restaurants;

  AllRestaurant({this.imagePath, this.restaurants});

  AllRestaurant.fromJson(Map<String, dynamic> json) {
    imagePath = json['ImagePath'];
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImagePath'] = this.imagePath;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurants {
  int id;
  String name;
  String description;
  String image;
  String category;
  String cuisine;
  String createdAt;
  Null modifiedAt;

  Restaurants(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.category,
      this.cuisine,
      this.createdAt,
      this.modifiedAt});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
    image = json['Image'];
    category = json['Category'];
    cuisine = json['Cuisine'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Image'] = this.image;
    data['Category'] = this.category;
    data['Cuisine'] = this.cuisine;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}
