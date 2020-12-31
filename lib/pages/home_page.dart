import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bg_color/widgets/animated_background_color.dart';
import 'package:bg_color/bloc/color_generator_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ColorGeneratorBloc _colorGeneratorBloc;

  @override
  void initState() {
    super.initState();
    _colorGeneratorBloc = ColorGeneratorBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ColorGeneratorBloc, ColorGeneratorState>(
        cubit: _colorGeneratorBloc,
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              _colorGeneratorBloc.add(GenerateRandomColorEvent());
            },
            child: Stack(
              children: [
                AnimatedBackgroundColor(
                  color: state.color,
                  curve: Curves.easeIn,
                  child: Center(
                    child: Text(
                      'Hey there',
                      style: TextStyle(
                        fontSize: 44,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        'Auto',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4),
                      Switch(
                        value: state.automatic,
                        onChanged: (_) {
                          _colorGeneratorBloc
                              .add(ToogleAutoRandomColorGeneratorEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
