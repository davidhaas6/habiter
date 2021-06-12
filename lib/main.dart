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
      child:  MaterialApp(
      title: 'Habiter',
      theme: ThemeData(
        // primarySwatch: Colors.,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RecordView(),
    ),
    ),
  );
}
