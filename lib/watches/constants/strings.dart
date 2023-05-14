import 'dart:io';

import 'package:health/health.dart';

///*************************************************Google Fit ******************************* */

final types = [
  HealthDataType.STEPS,
  HealthDataType.ACTIVE_ENERGY_BURNED,
  HealthDataType.BLOOD_GLUCOSE,
  Platform.isAndroid
      ? HealthDataType.DISTANCE_DELTA
      : HealthDataType.DISTANCE_WALKING_RUNNING,
  HealthDataType.SLEEP_ASLEEP,
  HealthDataType.HEART_RATE,
  Platform.isAndroid
      ? HealthDataType.MOVE_MINUTES
      : HealthDataType.EXERCISE_TIME,
  HealthDataType.WORKOUT
  //HealthDataType.WORKOUT,
  // Uncomment these lines on iOS - only available on iOS
  // HealthDataType.AUDIOGRAM
];
final permissions = [
  HealthDataAccess.READ,
  HealthDataAccess.READ,
  HealthDataAccess.READ,
  HealthDataAccess.READ,
  HealthDataAccess.READ,
  HealthDataAccess.READ,
  HealthDataAccess.READ,
  HealthDataAccess.READ,
];
enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED,
  DATA_ADDED,
  DATA_NOT_ADDED,
  STEPS_READY,
}
