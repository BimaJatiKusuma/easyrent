import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:slide_countdown/slide_countdown.dart';

class TestCountDown extends StatefulWidget {
  TestCountDown({
    this.dropOffDate,
    super.key
    });
    late final dropOffDate;

  @override
  State<TestCountDown> createState() => _TestCountDownState();
}

class _TestCountDownState extends State<TestCountDown> {
  @override
  Widget build(BuildContext context) {
    var i = "hallo";
    print(i);
    // print(widget.dropOffDate);
    var j = DateTime.parse(widget.dropOffDate);
    // print(j);
    // print(j.runtimeType);
    // var k = DateTime.now();
    // print(k);
    // print(k.runtimeType);
    // var l = j.difference(DateTime.now()).inDays;
    // print(l);
    // print(l.runtimeType);
    // var m = j.difference(DateTime.now()).inHours;
    // print(m);
    // print(m.runtimeType);
    // var n = j.difference(DateTime.now()).inMinutes;
    // print(n);
    // print(n.runtimeType);
    var o = j.difference(DateTime.now()).inSeconds;
    // print(o);
    // print(o.runtimeType);

    return Scaffold(
      body: Center(
        child: SlideCountdown(
          showZeroValue: true,
          duration: Duration(
            // days: l,
            // hours: m,
            // minutes: n,
            seconds: o
          ),
        ),
      ),
    );
  }
}




















// class TestCountDown extends StatefulWidget {
//   TestCountDown({
//     this.dropOffDate,
//     super.key
//     });
//     late final dropOffDate;
//   @override
//   State<TestCountDown> createState() => _TestCountDownState();
// }

// class _TestCountDownState extends State<TestCountDown> {
//   // Step 2
//   Timer? countdownTimer;
//   Duration myDuration = Duration(days: 5);
//   @override
//   void initState() {
//     super.initState();
//   }
//   /// Timer related methods ///
//   // Step 3
//   void startTimer() {
//     countdownTimer =
//         Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
//   }
//   // Step 4
//   void stopTimer() {
//     setState(() => countdownTimer!.cancel());
//   }
//   // Step 5
//   void resetTimer() {
//     stopTimer();
//     setState(() => myDuration = Duration(days: 5));
//   }
//   // Step 6
//   void setCountDown() {
//     final reduceSecondsBy = 1;
//     setState(() {
//       final seconds = myDuration.inSeconds - reduceSecondsBy;
//       if (seconds < 0) {
//         countdownTimer!.cancel();
//       } else {
//         myDuration = Duration(seconds: seconds);
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     String strDigits(int n) => n.toString().padLeft(2, '0');
//     final days = strDigits(myDuration.inDays);
//     // Step 7
//     final hours = strDigits(myDuration.inHours.remainder(24));
//     final minutes = strDigits(myDuration.inMinutes.remainder(60));
//     final seconds = strDigits(myDuration.inSeconds.remainder(60));
//             Text(
//               '$days:$hours:$minutes:$seconds',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontSize: 50),
//             );
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Text(
//               '$days:$hours:$minutes:$seconds',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontSize: 50),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             // Step 8 
//             // Text(
//             //   '$hours:$minutes:$seconds',
//             //   style: TextStyle(
//             //       fontWeight: FontWeight.bold,
//             //       color: Colors.black,
//             //       fontSize: 50),
//             // ),
//             // SizedBox(height: 20),
//             // // Step 9
//             // ElevatedButton(
//             //   onPressed: startTimer,
//             //   child: Text(
//             //     'Start',
//             //     style: TextStyle(
//             //       fontSize: 30,
//             //     ),
//             //   ),
//             // ),
//             // // Step 10
//             // ElevatedButton(
//             //   onPressed: () {
//             //     if (countdownTimer == null || countdownTimer!.isActive) {
//             //       stopTimer();
//             //     }
//             //   },
//             //   child: Text(
//             //     'Stop',
//             //     style: TextStyle(
//             //       fontSize: 30,
//             //     ),
//             //   ),
//             // ),
//             // // Step 11
//             // ElevatedButton(
//             //     onPressed: () {
//             //       resetTimer();
//             //     },
//             //     child: Text(
//             //       'Reset',
//             //       style: TextStyle(
//             //         fontSize: 30,
//             //       ),
//             //     ))
//           ],
//         ),
//       ),
//     );
//   }
// }