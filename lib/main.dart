import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://badhdlrvgxsurfzsajrt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJhZGhkbHJ2Z3hzdXJmenNhanJ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYzMzk3NzQsImV4cCI6MjA1MTkxNTc3NH0.5z9n_n4i75YB_84-JC8gTyrJLnfM4W-PwovXItcti2I',
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
