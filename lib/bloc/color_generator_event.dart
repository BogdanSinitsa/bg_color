part of 'color_generator_bloc.dart';

@immutable
abstract class ColorGeneratorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GenerateRandomColorEvent extends ColorGeneratorEvent {}

class ToogleAutoRandomColorGeneratorEvent extends ColorGeneratorEvent {}
