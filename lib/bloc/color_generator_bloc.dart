import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'dart:math';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bg_color/constants.dart';

part 'color_generator_event.dart';
part 'color_generator_state.dart';

class ColorGeneratorBloc
    extends Bloc<ColorGeneratorEvent, ColorGeneratorState> {
  StreamSubscription automaticColorChangeSub;

  ColorGeneratorBloc() : super(ColorGeneratorState()) {
    automaticColorChangeSub = this
        .map((state) => state.automatic)
        .distinct()
        .switchMap(
          (automatic) => automatic
              ? Stream.periodic(
                  Duration(milliseconds: AUTO_COLOR_CHANGE_INTERVAL))
              : Stream.empty(),
        )
        .listen((_) {
      add(GenerateRandomColorEvent());
    });
  }

  @override
  Stream<ColorGeneratorState> mapEventToState(
    ColorGeneratorEvent event,
  ) async* {
    if (event is GenerateRandomColorEvent) {
      yield* mapGenerateRandomColorToState();
    } else if (event is ToogleAutoRandomColorGeneratorEvent) {
      yield* mapToogleAutoRandomColorGeneratorToState();
    }
  }

  Stream<ColorGeneratorState> mapGenerateRandomColorToState() async* {
    final random = Random();
    final color = HSLColor.fromColor(Color.fromARGB(
      255,
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
    ))
        .withSaturation(COLOR_SATURATION) // Gives a pastel look to the color
        .toColor();
    yield state.copyWith(
      color: color,
    );
  }

  Stream<ColorGeneratorState>
      mapToogleAutoRandomColorGeneratorToState() async* {
    yield state.copyWith(
      automatic: !state.automatic,
    );
  }

  @override
  Future<void> close() {
    automaticColorChangeSub.cancel();
    return super.close();
  }
}
