import 'package:flutter/rendering.dart';

class Strings {
  // Fitbit Client ID
  static const String fitbitClientID = '2385D9';

  // Fitbit Client Secret
  static const String fitbitClientSecret = 'eb0501be3214e44ad96250ee47cb356f';

  /// Auth Uri
  static const String fitbitRedirectUri = 'weightchoper://fitbit/auth';

  /// Callback scheme
  static const String fitbitCallbackScheme = 'weightchoper';

  /// Withings Client Id
  static const String withingClientID =
      'cf0a9444ee785001ab027f94dbe7bc501bc30f6c86cbe8c27415ad7c7f543fa1';

  // Withings Client Secret
  static const String withingClientSecret =
      'a63db61dce2fc519566a8fc51848ea4a1e28671b10359f3e873bceef019f69ba';

  /// Auth Uri
  static const String withingRedirectUri = 'weightchoper://withings/auth';

  /// Callback scheme
  static const String withingCallbackScheme = 'weightchoper';

  static const String withingBaseUrl = 'https://wbsapi.withings.net';
  static const String withingSleepDataFields =
      "nb_rem_episodes,sleep_efficiency,sleep_latency,total_sleep_time,total_timeinbed,wakeup_latency,waso,apnea_hypopnea_index,breathing_disturbances_intensity,asleepduration,deepsleepduration,durationtosleep,durationtowakeup,hr_average,hr_max,hr_min,lightsleepduration,night_events,out_of_bed_count,remsleepduration,rr_average,rr_max,rr_min,sleep_score,snoring,snoringepisodecount,wakeupcount,wakeupduration";
}
