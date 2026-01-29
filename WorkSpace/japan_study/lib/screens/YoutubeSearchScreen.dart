import 'package:flutter/material.dart';
import 'package:japan_study/Service/Youtube/YoutubeSearcher.dart';
import 'package:japan_study/database/RudDatabase.dart';
import 'package:japan_study/widgets/Youtube/YoutubeResultList.dart';
// ✅ Models 폴더 대소문자 반영 [cite: 2026-01-24]
import 'package:japan_study/Models/VideoInfo.dart';

class YoutubeSearchScreen extends StatefulWidget {
  final String query;

  const YoutubeSearchScreen({super.key, required this.query});

  @override
  State<YoutubeSearchScreen> createState() => _YoutubeSearchScreenState();
}

class _YoutubeSearchScreenState extends State<YoutubeSearchScreen> {
  final YoutubeSearcher _searcher = YoutubeSearcher();
  List<YoutubeVideo> _searchVideos = [];
  bool _isLoading = true;
  late String _currentQuery;

  @override
  void initState() {
    super.initState();
    _currentQuery = widget.query; // 초기 검색어 설정
    _fetchResults();
  }

  /// 유튜브 검색 실행
  Future<void> _fetchResults() async {
    if (!mounted) return;

    // 로딩 상태 동기화
    if (!_isLoading) {
      setState(() => _isLoading = true);
    }

    try {
      final results = await _searcher.searchVideos(_currentQuery);
      if (mounted) {
        setState(() {
          _searchVideos = results;
          _isLoading = false;
        });
      }
    } catch (error) {
      debugPrint("RUD: 검색 결과 로드 실패 - $error");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// 재검색 처리
  void _handleReSearch(String newQuery) {
    if (newQuery.trim().isEmpty) return;

    setState(() {
      _currentQuery = newQuery;
    });
    _fetchResults();
  }

  /// 곡 선택 및 DB 저장 로직
  void _handleSongSelection(YoutubeVideo video) async {
    try {
      // 1. 유튜브 데이터를 VideoInfo 객체로 변환 및 저장
      // RudDatabase 내부에서 로그인 상태에 따라 Drift/Firebase 자동 분기 저장 [cite: 2026-01-24]
      final VideoInfo savedVideo = await RudDatabase().getVideoFromYoutube(
        video,
      );

      // 2. 로그인 상태 확인 후 유저의 '자주 듣는 곡' 목록에 저장 [cite: 2026-01-22]
      if (RudDatabase().isLoggedIn) {
        await RudDatabase().saveFrequentlyVideo(savedVideo);
        debugPrint(
          "RUD: 유저 개인 기록(frequentlyVideos) 저장 완료 - ${savedVideo.title}",
        );
      }

      if (!mounted) return;

      // 2. 저장 위치 확인 로그 (isLoggedIn 게터 활용)
      final String storageType = RudDatabase().isLoggedIn ? '클라우드' : '로컬';
      debugPrint("RUD: $storageType 저장 완료 - ${savedVideo.title}");

      // 3. 저장된 객체를 가지고 이전 화면으로 복귀
      Navigator.pop(context, savedVideo);
    } catch (e) {
      debugPrint("RUD: 곡 저장 중 오류 발생 - $e");
      // 필요 시 사용자 알림(SnackBar 등) 추가 가능
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("'$_currentQuery' 검색 결과"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: YoutubeResultList(
        videos: _searchVideos,
        isLoading: _isLoading,
        query: _currentQuery,
        onSongSelected: _handleSongSelection,
        onSearch: _handleReSearch,
      ),
    );
  }
}
