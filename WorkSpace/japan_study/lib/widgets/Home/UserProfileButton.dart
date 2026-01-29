import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:japan_study/Service/User_Auth/AuthService.dart';
import 'package:japan_study/utils/app_size.dart';

class UserProfileButton extends StatelessWidget {
  final VoidCallback onLogoutRequested;

  const UserProfileButton({super.key, required this.onLogoutRequested});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        return GestureDetector(
          onTap: () async {
            if (user == null) {
              // ✅ AuthService를 통한 구글 로그인 실행
              await AuthService().signInWithGoogle();
            } else {
              // ✅ 로그아웃 확인 창 트리거 [cite: 2026-01-22]
              onLogoutRequested();
            }
          },
          child: CircleAvatar(
            radius: 18.w,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: (user?.photoURL != null)
                ? NetworkImage(user!.photoURL!)
                : null,
            child: (user == null)
                ? Icon(Icons.account_circle, size: 30.w, color: Colors.grey)
                : null,
          ),
        );
      },
    );
  }
}
