class FitBitActivity {
  List activities;
  Goals goals;
  Summary summary;

  FitBitActivity({this.activities, this.goals, this.summary});

  FitBitActivity.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = [];
      json['activities'].forEach((v) {
        //activities.add(new Null.fromJson(v));
      });
    }
    goals = json['goals'] != null ? new Goals.fromJson(json['goals']) : null;
    summary =
        json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activities != null) {
      data['activities'] = this.activities.map((v) => v.toJson()).toList();
    }
    if (this.goals != null) {
      data['goals'] = this.goals.toJson();
    }
    if (this.summary != null) {
      data['summary'] = this.summary.toJson();
    }
    return data;
  }
}

class Goals {
  int activeMinutes;
  int caloriesOut;
  double distance;
  int steps;

  Goals({this.activeMinutes, this.caloriesOut, this.distance, this.steps});

  Goals.fromJson(Map<String, dynamic> json) {
    activeMinutes = json['activeMinutes'];
    caloriesOut = json['caloriesOut'];
    distance = json['distance'];
    steps = json['steps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activeMinutes'] = this.activeMinutes;
    data['caloriesOut'] = this.caloriesOut;
    data['distance'] = this.distance;
    data['steps'] = this.steps;
    return data;
  }
}

class Summary {
  int activeScore;
  int activityCalories;
  int caloriesBMR;
  int caloriesOut;
  List<Distances> distances;
  int fairlyActiveMinutes;
  int lightlyActiveMinutes;
  int marginalCalories;
  int sedentaryMinutes;
  int steps;
  int veryActiveMinutes;

  Summary(
      {this.activeScore,
      this.activityCalories,
      this.caloriesBMR,
      this.caloriesOut,
      this.distances,
      this.fairlyActiveMinutes,
      this.lightlyActiveMinutes,
      this.marginalCalories,
      this.sedentaryMinutes,
      this.steps,
      this.veryActiveMinutes});

  Summary.fromJson(Map<String, dynamic> json) {
    activeScore = json['activeScore'];
    activityCalories = json['activityCalories'];
    caloriesBMR = json['caloriesBMR'];
    caloriesOut = json['caloriesOut'];
    if (json['distances'] != null) {
      distances = <Distances>[];
      json['distances'].forEach((v) {
        distances.add(new Distances.fromJson(v));
      });
    }
    fairlyActiveMinutes = json['fairlyActiveMinutes'];
    lightlyActiveMinutes = json['lightlyActiveMinutes'];
    marginalCalories = json['marginalCalories'];
    sedentaryMinutes = json['sedentaryMinutes'];
    steps = json['steps'];
    veryActiveMinutes = json['veryActiveMinutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activeScore'] = this.activeScore;
    data['activityCalories'] = this.activityCalories;
    data['caloriesBMR'] = this.caloriesBMR;
    data['caloriesOut'] = this.caloriesOut;
    if (this.distances != null) {
      data['distances'] = this.distances.map((v) => v.toJson()).toList();
    }
    data['fairlyActiveMinutes'] = this.fairlyActiveMinutes;
    data['lightlyActiveMinutes'] = this.lightlyActiveMinutes;
    data['marginalCalories'] = this.marginalCalories;
    data['sedentaryMinutes'] = this.sedentaryMinutes;
    data['steps'] = this.steps;
    data['veryActiveMinutes'] = this.veryActiveMinutes;
    return data;
  }
}

class Distances {
  var activity;
  var distance;

  Distances({this.activity, this.distance});

  Distances.fromJson(Map<String, dynamic> json) {
    activity = json['activity'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity'] = this.activity;
    data['distance'] = this.distance;
    return data;
  }
}

class FitBitFloors {
  List<ActivitiesFloors> activitiesFloors;

  FitBitFloors({this.activitiesFloors});

  FitBitFloors.fromJson(Map<String, dynamic> json) {
    if (json['activities-floors'] != null) {
      activitiesFloors = <ActivitiesFloors>[];
      json['activities-floors'].forEach((v) {
        activitiesFloors.add(new ActivitiesFloors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activitiesFloors != null) {
      data['activities-floors'] =
          this.activitiesFloors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivitiesFloors {
  String dateTime;
  String value;

  ActivitiesFloors({this.dateTime, this.value});

  ActivitiesFloors.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateTime'] = this.dateTime;
    data['value'] = this.value;
    return data;
  }
}

class FitBitSleep {
  List sleep;
  SleepSummary summary;

  FitBitSleep({this.sleep, this.summary});

  FitBitSleep.fromJson(Map<String, dynamic> json) {
    if (json['sleep'] != null) {
      sleep = [];
      json['sleep'].forEach((v) {
        //sleep.add(new Null.fromJson(v));
      });
    }
    summary = json['summary'] != null
        ? new SleepSummary.fromJson(json['summary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sleep != null) {
      data['sleep'] = this.sleep.map((v) => v.toJson()).toList();
    }
    if (this.summary != null) {
      data['summary'] = this.summary.toJson();
    }
    return data;
  }
}

class SleepSummary {
  int totalMinutesAsleep;
  int totalSleepRecords;
  int totalTimeInBed;

  SleepSummary(
      {this.totalMinutesAsleep, this.totalSleepRecords, this.totalTimeInBed});

  SleepSummary.fromJson(Map<String, dynamic> json) {
    totalMinutesAsleep = json['totalMinutesAsleep'];
    totalSleepRecords = json['totalSleepRecords'];
    totalTimeInBed = json['totalTimeInBed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalMinutesAsleep'] = this.totalMinutesAsleep;
    data['totalSleepRecords'] = this.totalSleepRecords;
    data['totalTimeInBed'] = this.totalTimeInBed;
    return data;
  }
}

class FitBitGoalSleep {
  Consistency consistency;
  Goal goal;

  FitBitGoalSleep({this.consistency, this.goal});

  FitBitGoalSleep.fromJson(Map<String, dynamic> json) {
    consistency = json['consistency'] != null
        ? new Consistency.fromJson(json['consistency'])
        : null;
    goal = json['goal'] != null ? new Goal.fromJson(json['goal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.consistency != null) {
      data['consistency'] = this.consistency.toJson();
    }
    if (this.goal != null) {
      data['goal'] = this.goal.toJson();
    }
    return data;
  }
}

class Consistency {
  int flowId;

  Consistency({this.flowId});

  Consistency.fromJson(Map<String, dynamic> json) {
    flowId = json['flowId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flowId'] = this.flowId;
    return data;
  }
}

class Goal {
  int minDuration;
  String updatedOn;

  Goal({this.minDuration, this.updatedOn});

  Goal.fromJson(Map<String, dynamic> json) {
    minDuration = json['minDuration'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minDuration'] = this.minDuration;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}
