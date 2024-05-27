import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:libresample_flutter/libresample_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Float32List input = Float32List(0);
  Float32List output = Float32List(0);

  void _runResampling() {
    final input = _generateSine(1, 40, 1);
    const factor = 0.2;
    final output = _resample(input: input, factor: factor, chunkSize: 1024);

    setState(() {
      this.input = input;
      this.output = output;
    });
    debugPrint('Converted: ${input.length} ${output.length}');
  }

  Float32List _generateSine(double length, int sampleRate, double frequency) {
    final sampleCount = (length * sampleRate).ceil();
    final increment = 1 / (sampleRate / frequency) / (pi / 20);

    final input = Float32List(sampleCount);
    for (var i = 0; i < sampleCount; i++) {
      input[i] = sin(increment * i);
    }

    return input;
  }

  Float32List _resample({
    required Float32List input,
    required double factor,
    int chunkSize = 1024,
  }) {
    var resampler = Resampler(true, factor, factor);

    List<double> output = [];
    final length = input.length;

    int position = 0;
    while (position < length) {
      final end = min(length, position + chunkSize);
      final last = end == length;
      final result = resampler.process(factor, input.sublist(position, end), last);
      output.addAll(result);
      position = end;
    }

    resampler.close();

    return Float32List.fromList(output);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Libresample example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Test resampling'),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: _runResampling, child: Text('Run')),
              Text('Input'),
              CustomPaint(
                painter: WavePainter(samples: input),
                child: Container(height: 100),
              ),
              Text('Output'),
              CustomPaint(
                painter: WavePainter(samples: output),
                child: Container(height: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final List<double> samples;

  const WavePainter({required this.samples});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.lightBlue);

    if (samples.isEmpty) return;

    final h2 = size.height / 2;
    final incrementX = size.width / (samples.length - 1);

    final path = Path();
    path.moveTo(0, size.height / 2);

    for (var i = 0; i < samples.length; i++) {
      final sample = samples[i];
      final x = incrementX * i;
      final y = h2 - sample * h2;
      path.lineTo(x, y);
    }
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.red;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
