part of 'color_generator_bloc.dart';

class ColorGeneratorState extends Equatable {
  final Color color;
  final bool automatic;

  ColorGeneratorState({
    this.color = Colors.white,
    this.automatic = false,
  });

  @override
  List<Object> get props => [color, automatic];

  ColorGeneratorState copyWith({Color color, bool automatic}) {
    return ColorGeneratorState(
      color: color ?? this.color,
      automatic: automatic ?? this.automatic,
    );
  }
}
