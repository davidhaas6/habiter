import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:habit_log/controllers/app_context.dart';
import 'package:habit_log/models/habit.dart';
import 'package:habit_log/views/parent_checkbox.dart';
import 'package:provider/provider.dart';

class RecordView extends StatefulWidget {
  const RecordView({Key? key}) : super(key: key);

  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
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
      floatingActionButton: NeumorphicFloatingActionButton(
        child: Icon(Icons.add, size: 30),
        onPressed: () {},
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Padding(
        padding: EdgeInsets.only(
            top: 0), // TODO: when do you need statusBarHeight here?
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildHabitList(),
        ],
      ),
    );
  }

  Widget buildHeading() {
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

  Widget buildHabitList() {
    //habits.map<Widget>(buildHabitTile).toList(),
    return Expanded(
      // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          buildHeading(),
          for (var habit in habits) buildHabitTile(habit),
          Padding(padding: EdgeInsets.only(top: 64))
        ],
      ),
    );
  }

  Widget buildHabitTile(Habit habit) {
    print('is check null? ${checked == null}');

    Widget child = Column(
      children: [
        NeumorphicText(
          habit.name,
          style: NeumorphicStyle(color: _textColor(context)),
          textStyle: NeumorphicTextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
        NeumorphicText(
          habit.purpose,
          style: NeumorphicStyle(color: _textColor(context)),
          textStyle: NeumorphicTextStyle(fontSize: 12),
          textAlign: TextAlign.left,
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: SizedBox(
          width: .9 * canvasWidth,
          height: 60,
          child: NeumorphicParentCheckbox(
            child: child,
            // curve: Curves.linear,
            style: NeumorphicCheckboxStyle(
              selectedColor: Colors.greenAccent,
              selectedIntensity: .8,
              selectedDepth: .1,
              unselectedDepth: .8,
              unselectedIntensity: .3,
            ),
            duration: Duration(milliseconds: 200),
            value: checked != null ? checked![habit]! : false,
            onChanged: (value) {
              setState(() {
                print('state');
                if (checked != null) {
                  checked![habit] = !checked![habit]!;
                }
              });
            },
          ),
        ),
      ),
    );
  }

  Color _textColor(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
