import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../custom_widgets/custom_appbar.dart';
import '../custom_widgets/custom_color.dart';

class ProgressScreen extends StatelessWidget {
  final List<bool> isChecked;
  final int streak;

  ProgressScreen(this.isChecked, this.streak);

  @override
  Widget build(BuildContext context) {
    int completedCount = isChecked.where((completed) => completed).length;

    final data = [
      HabitProgress('Completed', completedCount),
      HabitProgress('Remaining', isChecked.length - completedCount),
    ];
    TextStyle commonTextStyle(){
      return TextStyle(
        color: CustomColors.blackColor,
        fontSize: 22,
        fontFamily: 'PoppinsRegular',
      );
    }
    return Scaffold(
      appBar: const CustomAppbar(text: 'Daily Progress',),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Completed Habits: $completedCount / ${isChecked.length}', style:commonTextStyle() ),
            SizedBox(
              height: 200,
              child: SfCircularChart(
                legend: const Legend(isVisible: true),
                series: <CircularSeries>[
                  PieSeries<HabitProgress, String>(
                    dataSource: data,
                    xValueMapper: (HabitProgress progress, _) => progress.habitStatus,
                    yValueMapper: (HabitProgress progress, _) => progress.count,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    explode: true,
                    explodeIndex: 0,
                  )
                ],
              ),
            ),
            // Text('Streak: $streak days', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.screenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: const Size(250, 50)),
              child: Text('Back to Home',style: commonTextStyle(),),
            ),
          ],
        ),
      ),
    );
  }
}

class HabitProgress {
  final String habitStatus;
  final int count;

  HabitProgress(this.habitStatus, this.count);
}
