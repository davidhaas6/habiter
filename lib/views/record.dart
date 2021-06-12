import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:habit_log/components/clay_checkbox.dart';
import 'package:habit_log/components/habit_button.dart';
import 'package:habit_log/controllers/app_context.dart';
import 'package:habit_log/models/habit.dart';
import 'package:habit_log/components/parent_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:clay_containers/clay_containers.dart';

class RecordView extends StatefulWidget {
  const RecordView({Key? key}) : super(key: key);

  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> with TickerProviderStateMixin {
  final double topPadding = 24;
  final double sidePadding = 16;

  Map<Habit, bool>? checked;
  List<Habit> habits = [
    Habit('Read', ''),
    Habit('Eat Right', ''),
    Habit('Workout', ''),
    Habit('Write', ''),
    Habit('Meditate', ''),
    Habit('Guitar', '1'),
    Habit('Math', '1'),
    Habit('Morning routine', '1'),
  ];

  bool _isChecked(habit) => checked != null ? checked![habit]! : false;

  double? _cachedBarHeight;
  double get statusBarHeight {
    if (_cachedBarHeight == null) _updateScreenSize();
    return _cachedBarHeight!;
  }

  double? _cachedHeight;
  double get canvasHeight {
    if (_cachedHeight == null) _updateScreenSize();
    return _cachedHeight!;
  }

  double? _cachedWidth;
  double get canvasWidth {
    if (_cachedWidth == null) _updateScreenSize();
    return _cachedWidth!;
  }

  void _updateScreenSize() {
    MediaQueryData screen = MediaQuery.of(context);

    _cachedBarHeight = screen.padding.top;
    _cachedHeight = screen.size.height;
    _cachedWidth = screen.size.width;
  }

  @override
  void initState() {
    super.initState();
    print('hello');

    checked = {for (var habit in habits) habit: false};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            top: 0), // TODO: when do you need statusBarHeight here?
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildHabitList(),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildSaveButton(),
        )
      ],
    );
  }

  Widget _buildHeading() {
    var weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    String weekday = weekdays[DateTime.now().weekday - 1];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NeumorphicText(
            weekday,
            style: NeumorphicStyle(
              depth: 10,
              intensity: .75,
              color: _textColor(context),
            ),
            textStyle: NeumorphicTextStyle(fontSize: 72),
            // n
          ),
          NeumorphicText(
            'Habit Log',
            style: NeumorphicStyle(
              intensity: .75,
              color: _textColor(context),
            ),
            textStyle: NeumorphicTextStyle(fontSize: 42),
            // n
          ),
        ],
      ),
    );
  }

  Widget _buildHabitList() {
    //habits.map<Widget>(buildHabitTile).toList(),
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        _buildHeading(),
        for (var habit in habits) _buildHabitTile(habit),
        Padding(padding: EdgeInsets.only(top: 64)),
      ],
    );
  }

  Widget _buildHabitTile(Habit habit) {
    print('is check null? ${checked == null}');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: SizedBox(
          width: .7 * canvasWidth,
          height: 60,
          child: HabitButton(
            habit: habit,
            value: _isChecked(habit),
            vsyncProvider: this,
            onClick: (value) {
              if (checked != null) {
                setState(() {
                  checked![habit] = !checked![habit]!;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: NeumorphicButton(
        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 24),
        drawSurfaceAboveChild: false,
        onPressed: () {
          print('press');
        },
        style: NeumorphicStyle(color: Colors.blueAccent),
        child: ClayText(
          'Save Log',
          size: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  Color _textColor(BuildContext context) {
    return Colors.black;
  }
}
