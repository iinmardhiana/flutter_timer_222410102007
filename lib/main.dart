// NAMA : I'IN MARDHIANA
// NIM  : 222410102007

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hilangkan banner debug
      debugShowCheckedModeBanner: false,
      title: 'Countdown Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CountdownTimerApp(),
    );
  }
}

class CountdownTimerApp extends StatefulWidget {
  const CountdownTimerApp({Key? key}) : super(key: key);

  @override
  _CountdownTimerAppState createState() => _CountdownTimerAppState();
}

class _CountdownTimerAppState extends State<CountdownTimerApp> {
  // Nilai detik, menit, dan jam
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;

  // Status timer (berjalan atau tidak)
  bool _isRunning = false;

  // Timer
  Timer? _timer;

  // Controller untuk TextField
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  TextEditingController secondController = TextEditingController();

  // Fungsi untuk memulai timer
  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_seconds > 0) {
          setState(() {
            _seconds--;
          });
        } else {
          if (_minutes > 0) {
            setState(() {
              _minutes--;
              _seconds = 59;
            });
          } else {
            if (_hours > 0) {
              setState(() {
                _hours--;
                _minutes = 59;
                _seconds = 59;
              });
            } else {
              // Timer berhenti ketika jam, menit, dan detik semua 0
              _timer?.cancel();
            }
          }
        }
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  // Fungsi untuk menghentikan timer
  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  // Fungsi untuk mengulang timer
  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _seconds = 0;
      _minutes = 0;
      _hours = 0;
    });
  }

  // Fungsi untuk mengatur waktu awal timer berdasarkan input pengguna
  void _setInitialTime() {
    setState(() {
      _hours = int.parse(hourController.text);
      _minutes = int.parse(minuteController.text);
      _seconds = int.parse(secondController.text);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

// textbox untuk input timer oleh pengguna
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input untuk jam
            TextField(
              controller: hourController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jam',
                border: OutlineInputBorder(),
              ),
            ),
            // Input untuk menit
            TextField(
              controller: minuteController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Menit',
                border: OutlineInputBorder(),
              ),
            ),
            // Input untuk detik
            TextField(
              controller: secondController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Detik',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Sisa Waktu:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$_hours:${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRunning ? _stopTimer : () {_setInitialTime(); _startTimer();},
              child: Text(_isRunning ? 'Pause' : 'Start'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _resetTimer,
              child: Text('Reset'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}