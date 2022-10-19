import 'dart:async';

import 'package:bloc/bloc.dart';

part 'stopwatch_state.dart';

class StopwatchCubit extends Cubit<StopwatchState> {
  StopwatchCubit()
      : super(
          StopwatchState(
            hours: 0,
            minutes: 0,
            seconds: 0,
            milliseconds: 0,
            laps: [],
            started: false,

            // isButtonDisabled: false,

            lapDifference: [],
            secondHours: 0,
            secondMinutes: 0,
            secondSeconds: 0,
            secondMilliseconds: 0,
          ),
        );

  late Timer timer;

  Future<void> reset() async {
    timer.cancel();
    emit(StopwatchState(
      milliseconds: 0,
      seconds: 0,
      minutes: 0,
      hours: 0,
      laps: [],
      started: false,
      // isButtonDisabled: false,
      lapDifference: [],
      secondHours: 0,
      secondMinutes: 0,
      secondSeconds: 0,
      secondMilliseconds: 0,
    ));
  }

  Future<void> addLaps() async {
    String lap =
        '${state.hours >= 10 ? '${state.hours}' : '0${state.hours}'}:${state.minutes >= 10 ? '${state.minutes}' : '0${state.minutes}'}:${state.seconds >= 10 ? '${state.seconds}' : '0${state.seconds}'},${state.milliseconds >= 10 ? '${state.milliseconds}' : '0${state.milliseconds}'}';

    String differenceBetweenLaps =
        '${state.secondHours}:${state.secondMinutes}:${state.secondSeconds},${state.secondMilliseconds}';

    state.laps.add(lap);
    state.lapDifference.add(differenceBetweenLaps);

    emit(StopwatchState(
      milliseconds: state.milliseconds,
      seconds: state.seconds,
      minutes: state.minutes,
      hours: state.hours,
      laps: state.laps,

      started: state.started,
      // isButtonDisabled: false,

      lapDifference: state.lapDifference,
      secondHours: state.hours,
      secondMinutes: state.minutes,
      secondSeconds: state.seconds,
      secondMilliseconds: state.milliseconds,
    ));
  }

  Future<void> start() async {
    timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (Timer timer) {
        emit(StopwatchState(
          milliseconds: state.milliseconds + 1,
          seconds: state.seconds,
          minutes: state.minutes,
          hours: state.hours,
          laps: state.laps,

          started: true,
          // isButtonDisabled: false,

          lapDifference: state.lapDifference,
          secondHours: state.hours,
          secondMinutes: state.minutes,
          secondSeconds: state.seconds,
          secondMilliseconds: state.milliseconds,
        ));
        if (state.milliseconds >= 100) {
          if (state.seconds >= 59) {
            if (state.minutes >= 59) {
              emit(StopwatchState(
                milliseconds: state.milliseconds = 0,
                seconds: state.seconds = 0,
                minutes: state.minutes = 0,
                hours: state.hours + 1,
                laps: state.laps,

                started: true,
                // isButtonDisabled: false,

                lapDifference: state.lapDifference,
                secondHours: state.hours,
                secondMinutes: state.minutes,
                secondSeconds: state.seconds,
                secondMilliseconds: state.milliseconds,
              ));
            } else {
              emit(StopwatchState(
                milliseconds: state.milliseconds = 0,
                seconds: state.seconds = 0,
                minutes: state.minutes + 1,
                hours: state.hours,
                laps: state.laps,

                started: true,
                // isButtonDisabled: false,

                lapDifference: state.lapDifference,
                secondHours: state.hours,
                secondMinutes: state.minutes,
                secondSeconds: state.seconds,
                secondMilliseconds: state.milliseconds,
              ));
            }
          } else {
            emit(StopwatchState(
              milliseconds: state.milliseconds = 0,
              seconds: state.seconds + 1,
              minutes: state.minutes,
              hours: state.hours,
              laps: state.laps,

              started: true,
              // isButtonDisabled: false,

              lapDifference: state.lapDifference,
              secondHours: state.hours,
              secondMinutes: state.minutes,
              secondSeconds: state.seconds,
              secondMilliseconds: state.milliseconds,
            ));
          }
        }
      },
    );
  }

  Future<void> stop() async {
    timer.cancel();
    state.started = false;
  }
}
