import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom_widgets/custom_appbar.dart';
import '../custom_widgets/custom_color.dart';
import 'screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> habits = [
    'Drink Water',
    'Exercise',
    'Read',
    'Meditate',
    'Sleep 8 hours'
  ];
  List<bool> isChecked = [false, false, false, false, false];
  int streak = 0;

  @override
  void initState() {
    super.initState();
    loadStreak();
  }

  Future<void> loadStreak() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      streak = prefs.getInt('streak') ?? 0;
    });
  }

  Future<void> resetStreak() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('streak', 0);
    setState(() {
      streak = 0;
      isChecked = [false, false, false, false, false];
    });
  }

  void onHabitChecked(int index, bool? value) {
    setState(() {
      isChecked[index] = value ?? false;
    });
  }

  Future<void> updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    int newStreak = streak += 1;
    await prefs.setInt('streak', newStreak);
    setState(() {
      streak = newStreak;
    });
  }

  void onCompleteDay() {
    if (isChecked.every((element) => element)) {
      updateStreak().then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProgressScreen(isChecked, streak)),
        );
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProgressScreen(isChecked, streak)),
      );
    }
  }


  TextStyle customTextStyle() {
    return TextStyle(
      color: CustomColors.blackColor,
      fontSize: 22,
      fontFamily: 'PoppinsRegular',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        text: 'Habit Tracker',
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      habits[index],
                      style: customTextStyle(),
                    ),
                    value: isChecked[index],
                    onChanged: (bool? value) {
                      onHabitChecked(index, value);
                    },
                    activeColor: CustomColors.screenColor,
                  );
                },
              ),
            ),
            // Text('Streak: $streak days', style:customTextStyle()),
            Padding(
              padding: const EdgeInsets.only(bottom: 300),
              child: ElevatedButton(
                onPressed: onCompleteDay,
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.screenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: const Size(300, 50)),
                child: Text(
                  'View Your Progress',
                  style: customTextStyle(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40, right: 20),
        child: FloatingActionButton(
          backgroundColor: CustomColors.screenColor,
          onPressed: resetStreak,
          child: Icon(
            Icons.restart_alt_outlined,
            color: CustomColors.blackColor,
          ),
        ),
      ),
    );
  }
}
