class waterNotifications {
  List<Water> water;

  waterNotifications({this.water});

  waterNotifications.fromJson(Map<String, dynamic> json) {
    if (json['Water'] != null) {
      water = <Water>[];
      json['Water'].forEach((v) {
        water.add(new Water.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.water != null) {
      data['Water'] = this.water.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Water {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  Water(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  Water.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class sleepNotifications {
  List<Sleep> sleep;

  sleepNotifications({this.sleep});

  sleepNotifications.fromJson(Map<String, dynamic> json) {
    if (json['Sleep'] != null) {
      sleep = <Sleep>[];
      json['Sleep'].forEach((v) {
        sleep.add(new Sleep.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sleep != null) {
      data['Sleep'] = this.sleep.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sleep {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  Sleep(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  Sleep.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class weightNotifications {
  List<Weight> weight;

  weightNotifications({this.weight});

  weightNotifications.fromJson(Map<String, dynamic> json) {
    if (json['Weight'] != null) {
      weight = <Weight>[];
      json['Weight'].forEach((v) {
        weight.add(new Weight.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weight != null) {
      data['Weight'] = this.weight.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weight {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  Weight(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  Weight.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class selfieNotifications {
  List<Selfie> selfie;

  selfieNotifications({this.selfie});

  selfieNotifications.fromJson(Map<String, dynamic> json) {
    if (json['Selfie'] != null) {
      selfie = <Selfie>[];
      json['Selfie'].forEach((v) {
        selfie.add(new Selfie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.selfie != null) {
      data['Selfie'] = this.selfie.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Selfie {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  Selfie(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  Selfie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class mindNotifications {
  List<Mind> mind;

  mindNotifications({this.mind});

  mindNotifications.fromJson(Map<String, dynamic> json) {
    if (json['Mind'] != null) {
      mind = <Mind>[];
      json['Mind'].forEach((v) {
        mind.add(new Mind.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mind != null) {
      data['Mind'] = this.mind.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mind {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  Mind(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  Mind.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class restaurantNotifications {
  List<Restaurant> restaurant;

  restaurantNotifications({this.restaurant});

  restaurantNotifications.fromJson(Map<String, dynamic> json) {
    if (json['Restaurant'] != null) {
      restaurant = <Restaurant>[];
      json['Restaurant'].forEach((v) {
        restaurant.add(new Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurant != null) {
      data['Restaurant'] = this.restaurant.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurant {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  Restaurant(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class snacksNotifications {
  List<Snacks> snacks;

  snacksNotifications({this.snacks});

  snacksNotifications.fromJson(Map<String, dynamic> json) {
    if (json['snacks'] != null) {
      snacks = <Snacks>[];
      json['snacks'].forEach((v) {
        snacks.add(new Snacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.snacks != null) {
      data['snacks'] = this.snacks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Snacks {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  Snacks(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  Snacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class dinnerNotifications {
  List<Dinner> dinner;

  dinnerNotifications({this.dinner});

  dinnerNotifications.fromJson(Map<String, dynamic> json) {
    if (json['Dinner'] != null) {
      dinner = <Dinner>[];
      json['Dinner'].forEach((v) {
        dinner.add(new Dinner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dinner != null) {
      data['Dinner'] = this.dinner.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dinner {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  Dinner(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  Dinner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class afternoonNotifications {
  List<AfterNoon> afterNoon;

  afternoonNotifications({this.afterNoon});

  afternoonNotifications.fromJson(Map<String, dynamic> json) {
    if (json['AfterNoon'] != null) {
      afterNoon = <AfterNoon>[];
      json['AfterNoon'].forEach((v) {
        afterNoon.add(new AfterNoon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.afterNoon != null) {
      data['AfterNoon'] = this.afterNoon.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AfterNoon {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  AfterNoon(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  AfterNoon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class lunchNotifications {
  List<Lunch> lunch;

  lunchNotifications({this.lunch});

  lunchNotifications.fromJson(Map<String, dynamic> json) {
    if (json['Lunch'] != null) {
      lunch = <Lunch>[];
      json['Lunch'].forEach((v) {
        lunch.add(new Lunch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lunch != null) {
      data['Lunch'] = this.lunch.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lunch {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  Lunch(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  Lunch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class earlysnacksNotifications {
  List<EarlySnacks> earlySnacks;

  earlysnacksNotifications({this.earlySnacks});

  earlysnacksNotifications.fromJson(Map<String, dynamic> json) {
    if (json['EarlySnacks'] != null) {
      earlySnacks = <EarlySnacks>[];
      json['EarlySnacks'].forEach((v) {
        earlySnacks.add(new EarlySnacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.earlySnacks != null) {
      data['EarlySnacks'] = this.earlySnacks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EarlySnacks {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  EarlySnacks(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  EarlySnacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class morningsnacksNotifications {
  List<MorningSnacks> morningSnacks;

  morningsnacksNotifications({this.morningSnacks});

  morningsnacksNotifications.fromJson(Map<String, dynamic> json) {
    if (json['MorningSnacks'] != null) {
      morningSnacks = <MorningSnacks>[];
      json['MorningSnacks'].forEach((v) {
        morningSnacks.add(new MorningSnacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.morningSnacks != null) {
      data['MorningSnacks'] =
          this.morningSnacks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MorningSnacks {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  MorningSnacks(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  MorningSnacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class breakfastNotifications {
  List<Breakfast> breakfast;

  breakfastNotifications({this.breakfast});

  breakfastNotifications.fromJson(Map<String, dynamic> json) {
    if (json['Breakfast'] != null) {
      breakfast = <Breakfast>[];
      json['Breakfast'].forEach((v) {
        breakfast.add(new Breakfast.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breakfast != null) {
      data['Breakfast'] = this.breakfast.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Breakfast {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  Breakfast(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  Breakfast.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class exerciseNotifications {
  List<Exercise> exercise;

  exerciseNotifications({this.exercise});

  exerciseNotifications.fromJson(Map<String, dynamic> json) {
    if (json['Exercise'] != null) {
      exercise = <Exercise>[];
      json['Exercise'].forEach((v) {
        exercise.add(new Exercise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exercise != null) {
      data['Exercise'] = this.exercise.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exercise {
  String id;
  String topic;
  String starthours;
  String startmin;
  String endhour;
  String endmin;
  String count;
  String subscribed;

  Exercise(
      {this.id,
      this.topic,
      this.starthours,
      this.startmin,
      this.endhour,
      this.endmin,
      this.count,
      this.subscribed});

  Exercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    starthours = json['starthours'];
    startmin = json['startmin'];
    endhour = json['endhour'];
    endmin = json['endmin'];
    count = json['count'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['starthours'] = this.starthours;
    data['startmin'] = this.startmin;
    data['endhour'] = this.endhour;
    data['endmin'] = this.endmin;
    data['count'] = this.count;
    data['subscribed'] = this.subscribed;
    return data;
  }
}
