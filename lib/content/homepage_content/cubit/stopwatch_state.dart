part of 'stopwatch_cubit.dart';

class StopwatchState {
  StopwatchState({
    required this.milliseconds,
    required this.seconds,
    required this.minutes,
    required this.hours,
    required this.laps,
    required this.started,
    // required this.isButtonDisabled,

    required this.lapDifference,
    required this.secondHours,
    required this.secondMinutes,
    required this.secondSeconds,
    required this.secondMilliseconds,
  });

  int milliseconds;
  int seconds;
  int minutes;
  int hours;

  List laps;

  bool started;
  // bool isButtonDisabled;

  List lapDifference;
  int secondHours;
  int secondMinutes;
  int secondSeconds;
  int secondMilliseconds;
}
