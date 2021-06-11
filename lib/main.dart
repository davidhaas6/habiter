import 'package:flutter/material.dart';
import 'package:habit_log/views/record.dart';
import 'package:provider/provider.dart';
import 'controllers/app_context.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppContext(context),
      child: NeumorphicApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.light,
        theme: NeumorphicThemeData(
          baseColor: Color(0xFFFFFFFF),
          lightSource: LightSource.topLeft,
          depth: 10,
        ),
        darkTheme: NeumorphicThemeData(
          baseColor: Color(0xFF3E3E3E),
          lightSource: LightSource.topLeft,
          depth: 6,
        ),
        home: RecordView(),
      ),
    ),
  );
}
