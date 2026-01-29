// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // 패키지 추가
import 'package:japan_study/screens/main_screen.dart'; // 경로 확인 필요
import 'package:japan_study/database/RudDatabase.dart';
//import 'package:flutter_gemma/flutter_gemma.dart';

// 이제 전역 변수 database 대신 AppDatabase()를 직접 호출하면 됩니다. [cite: 2026-01-12]

void main() async {
  // 1. 플러터 프레임워크와 네이티브(SQLite) 연결 보장 [cite: 2026-01-12]
  WidgetsFlutterBinding.ensureInitialized();

  // 파이어베이스 시스템 자체를 먼저 가동 [cite: 2026-01-12]
  await Firebase.initializeApp();

  // ✅ RudDatabase가 로그인 여부 확인 및 각 DB(Firebase/Drift) 세팅을 완료할 때까지 대기
  await RudDatabase().saveInitialize();

  runApp(const MyJapanSongApp());
}

class MyJapanSongApp extends StatelessWidget {
  const MyJapanSongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainScreen(),
    );
  }
}
