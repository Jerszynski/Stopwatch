import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/content/button_content/button.dart';
import 'package:timer/content/homepage_content/cubit/stopwatch_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StopwatchCubit(),
      child: BlocBuilder<StopwatchCubit, StopwatchState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff3be9ff), Color(0xff82c985)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text(' STOPWATCH'),
                centerTitle: true,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text(
                      '${state.hours >= 10 ? '${state.hours}' : '0${state.hours}'}:${state.minutes >= 10 ? '${state.minutes}' : '0${state.minutes}'}:${state.seconds >= 10 ? '${state.seconds}' : '0${state.seconds}'},${state.milliseconds >= 10 ? '${state.milliseconds}' : '0${state.milliseconds}'}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 88,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55.0),
                    child: Container(
                      height: 600,
                      width: 500,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12)),
                      child: ListView.builder(
                        itemCount: state.laps.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      index + 1 >= 10
                                          ? '${index + 1}'
                                          : '0${index + 1}',
                                      // Lap n°
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                    Text(
                                      '+${state.lapDifference[index]}',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Text(
                                      '${state.laps[index]}',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Buttons(
                        title: (!state.started) ? 'Start' : 'Pause',
                        onPressed: () {
                          (!state.started)
                              ? context.read<StopwatchCubit>().start()
                              : context.read<StopwatchCubit>().stop();
                        },
                        isButtonDisabled: false,
                      ),
                      Buttons(
                        title: 'Lap',
                        onPressed: () {
                          context.read<StopwatchCubit>().addLaps();
                        },
                        isButtonDisabled: (!state.started) ? true : false,
                      ),
                      Buttons(
                        title: 'Reset',
                        onPressed: () {
                          context.read<StopwatchCubit>().reset();
                        },
                        isButtonDisabled: (!state.started) ? false : true,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
