class FavoriteRestaurant {
  List<Restaurants> restaurants;
  String imagePath;

  FavoriteRestaurant({this.restaurants, this.imagePath});

  FavoriteRestaurant.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurants.fromJson(v));
      });
    }
    imagePath = json['ImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    data['ImagePath'] = this.imagePath;
    return data;
  }
}

class Restaurants {
  int restuarantId;
  String restaurantName;
  String category;
  String cuisine;
  String image;

  Restaurants(
      {this.restuarantId,
      this.restaurantName,
      this.category,
      this.cuisine,
      this.image});

  Restaurants.fromJson(Map<String, dynamic> json) {
    restuarantId = json['RestuarantId'];
    restaurantName = json['RestaurantName'];
    category = json['Category'];
    cuisine = json['Cuisine'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RestuarantId'] = this.restuarantId;
    data['RestaurantName'] = this.restaurantName;
    data['Category'] = this.category;
    data['Cuisine'] = this.cuisine;
    data['Image'] = this.image;
    return data;
  }
}
