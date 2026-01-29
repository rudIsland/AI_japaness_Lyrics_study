import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/Models/Lyric.dart';
import 'package:japan_study/database/RudDatabase.dart';
import 'package:japan_study/Service/Lyric/LyricAnalysisService.dart';
import 'package:japan_study/Service/Lyric/LyricFetchService.dart';
import 'package:japan_study/widgets/Lyric/LyricAudioPlayerCard.dart';
import 'package:japan_study/widgets/Lyric/LyricControlPanel.dart';
import 'package:japan_study/widgets/Lyric/LyricListArea.dart';
import 'package:japan_study/widgets/Lyric/LyricAppBar.dart';
import 'package:japan_study/widgets/Lyric/Lyric_tile.dart';
import 'package:japan_study/widgets/Lyric/LyricNote.dart';
import 'package:japan_study/utils/app_size.dart';

class LyricDetailScreen extends StatefulWidget {
  final VideoInfo video;
  const LyricDetailScreen({super.key, required this.video});

  @override
  State<LyricDetailScreen> createState() => _LyricDetailScreenState();
}

class _LyricDetailScreenState extends State<LyricDetailScreen> {
  late YoutubePlayerController _controller;
  bool _showFurigana = true;
  bool _showTranslation = true;
  bool _isAutoScrollEnabled = true;
  List<Lyric> _lyrics = [];
  bool _isLoading = true;
  bool _isSearching = false; // 검색 버튼 전용 로딩 상태
  bool _isAnalyzing = false; // AI 분석 버튼 전용 로딩 상태
  bool _isAlreadyCompleted = false;
  int _activeIndex = -1;

  bool _isBookmarked = false; // ✅ DB에서 가져올 상태
  String? _searchedArtist; // ✅ Global DB에서 가져올 마스터 정보
  String? _searchedTitle; // ✅ Global DB에서 가져올 마스터 정보

  final ScrollController _lyricScrollController = ScrollController();
  final List<GlobalKey> _lyricKeys = [];
  final LyricAnalysisService _analysisService = LyricAnalysisService();
  final LyricFetchService _fetchService = LyricFetchService();

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.youtubeVideoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    )..addListener(_onPlayerStateChange);

    _initializeData(); // ✅ 화면 진입 시 모든 정보 로드
  }

  /// 🚀 [초기화] 즐겨찾기 상태 및 공용 마스터 정보를 DB에서 로드
  Future<void> _initializeData() async {
    final videoId = widget.video.youtubeVideoId;

    // 1. 즐겨찾기 리스트(favoriteIds)에 있는지 확인 [cite: 2026-01-22]
    final isFavorite = await RudDatabase().getFavoriteStatus(videoId);

    // 2. 공용 DB(shared_videos)에서 검색했던 원문 정보 가져오기 [cite: 2026-01-26]
    final globalInfo = await RudDatabase().getGlobalVideo(videoId);

    // 3. 오늘 공부 완료 여부 확인
    final completed = await RudDatabase().isVideoCompletedToday(videoId);

    // 4. 가사 데이터 로드
    final lyricsData = await RudDatabase().getLyricsForVideo(videoId);

    if (!mounted) return;
    setState(() {
      _isBookmarked = isFavorite;
      _searchedArtist = globalInfo?.searchedArtist;
      _searchedTitle = globalInfo?.searchedTitle;
      _isAlreadyCompleted = completed;
      _lyrics = lyricsData;
      _isLoading = false;
      _lyricKeys.clear();
      _lyricKeys.addAll(List.generate(lyricsData.length, (_) => GlobalKey()));
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onPlayerStateChange);
    _controller.dispose();
    _lyricScrollController.dispose();
    super.dispose();
  }

  // --- 플레이어 로직 ---
  void _onPlayerStateChange() {
    if (!mounted || _lyrics.isEmpty) return;
    setState(() {});
    final position = _controller.value.position;
    int newIndex = -1;
    for (int i = 0; i < _lyrics.length; i++) {
      final timestamp = _lyrics[i].startTime;
      if (timestamp != null && position >= timestamp)
        newIndex = i;
      else if (timestamp != null && position < timestamp)
        break;
    }
    if (newIndex != _activeIndex) {
      setState(() => _activeIndex = newIndex);
      if (_isAutoScrollEnabled) _scrollToActive();
    }
  }

  void _scrollToActive() {
    if (!mounted || _activeIndex == -1 || _activeIndex >= _lyricKeys.length)
      return;
    final context = _lyricKeys[_activeIndex].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.65,
      );
    }
  }

  // --- 데이터 로딩 및 처리 ---
  Future<void> _loadLyrics() async {
    // 기존 로드 로직
    final data = await RudDatabase().getLyricsForVideo(
      widget.video.youtubeVideoId,
    );

    // ✅ 오늘 공부 완료 여부 확인 추가
    final completed = await RudDatabase().isVideoCompletedToday(
      widget.video.youtubeVideoId,
    );

    if (!mounted) return;
    setState(() {
      _lyrics = data;
      _isAlreadyCompleted = completed; // ✅ 상태 반영
      _lyricKeys.clear();
      _lyricKeys.addAll(List.generate(data.length, (_) => GlobalKey()));
      _isLoading = false;
    });
  }

  Future<void> _runAiAnalysis() async {
    if (_lyrics.isEmpty) return;
    setState(() => _isAnalyzing = true);
    try {
      await _analysisService.analyzeAndSaveFullLyrics(
        youtubeVideoId: widget.video.youtubeVideoId,
        lyrics: _lyrics,
        database: RudDatabase(),
      );
      await _loadLyrics();
    } finally {
      if (mounted) setState(() => _isAnalyzing = false);
    }
  }

  void _showSearchDialog({required String dialogTitle}) {
    final TextEditingController artistController = TextEditingController(
      text: _searchedArtist ?? widget.video.artist,
    );
    final TextEditingController titleController = TextEditingController(
      text: _searchedTitle ?? widget.video.title,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          dialogTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: artistController,
              decoration: const InputDecoration(labelText: "가수 명"),
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "곡 제목"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("취소"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _handleLyricProcessing(
                artist: artistController.text.trim(),
                title: titleController.text.trim(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // 선명한 빨간색 ✅
              foregroundColor: Colors.white, // 흰색 글자 ✅
              elevation: 2, // 입체감 추가 [cite: 2026-01-22]
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "가사 가져오기",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLyricProcessing({
    required String artist,
    required String title,
  }) async {
    setState(() => _isSearching = true);
    try {
      // 1. 가공된 리스트를 가져옴
      List<Lyric>? processed = await _fetchService.fetchAndParseLyrics(
        youtubeVideoId: widget.video.youtubeVideoId,
        title: title,
        artist: artist,
      );

      if (processed != null) {
        // 2. UI 즉시 갱신
        setState(() {
          _lyrics = processed;
          _lyricKeys.clear();
          _lyricKeys.addAll(
            List.generate(processed.length, (_) => GlobalKey()),
          );
        });
        // 3. 가공된 상태 그대로 DB 저장
        await RudDatabase().insertLyricsData(
          widget.video.youtubeVideoId,
          processed,
        );
        await RudDatabase().updateSearchedInfo(
          youtubeVideoId: widget.video.youtubeVideoId,
          searchedArtist: artist,
          searchedTitle: title,
        );
      }
    } finally {
      if (mounted) setState(() => _isSearching = false);
    }
  }

  void _showExplanationDialog(Lyric lyric) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ 원래 로직대로 다이얼로그 상단에 타일을 배치
            LyricTile(
              lyric: lyric,
              showFurigana: _showFurigana,
              showTranslation: _showTranslation,
              isActive: true, // 다이얼로그에선 강조 표시
              onTap: () {}, // 클릭 방지
              onLongPress: null, // 중복 다이얼로그 방지
            ),
            const Divider(color: Colors.red, thickness: 1.5),
            SizedBox(height: 10.h),
            LyricNote(notes: lyric.notes), // 단어장 리스트
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "확인",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: LyricAppBar(
        video: widget.video,
        isSearching: _isSearching,
        isAnalyzing: _isAnalyzing,
        isBookmarked: _isBookmarked,
        hasLyrics: _lyrics.isNotEmpty,
        // ✅ 새로고침 제거, 검색 기능만 남김 [cite: 2026-01-22]
        onSearch: () => _showSearchDialog(dialogTitle: "가사 검색"),
        onAnalysis: _runAiAnalysis,
        onBookmarkToggle: () async {
          await RudDatabase().updateFavoriteStatus(
            widget.video,
            !_isBookmarked,
          );
          setState(() => _isBookmarked = !_isBookmarked);
        },
      ),
      body: Column(
        children: [
          LyricAudioPlayerCard(
            video: widget.video,
            controller: _controller,
            isPlaying: _controller.value.isPlaying,
            onTogglePlay: () => setState(
              () => _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play(),
            ),
          ),
          // ✅ 상태 변수(_showFurigana 등)가 변경될 때 UI가 즉시 반응하도록 setState 연결 [cite: 2026-01-22]
          LyricControlPanel(
            showFurigana: _showFurigana,
            showTranslation: _showTranslation,
            isAutoScrollEnabled: _isAutoScrollEnabled,
            onToggleFurigana: () =>
                setState(() => _showFurigana = !_showFurigana),
            onToggleTranslation: () =>
                setState(() => _showTranslation = !_showTranslation),
            onToggleFocus: () =>
                setState(() => _isAutoScrollEnabled = !_isAutoScrollEnabled),
          ),
          const Divider(height: 1),
          Expanded(
            child: LyricListArea(
              isLoading: _isLoading,
              lyrics: _lyrics,
              scrollController: _lyricScrollController,
              lyricKeys: _lyricKeys,
              activeIndex: _activeIndex,
              showFurigana: _showFurigana, // ✅ 위젯에 상태 전달
              showTranslation: _showTranslation, // ✅ 위젯에 상태 전달
              onSearchPressed: () => _showSearchDialog(dialogTitle: "가사 수동 검색"),
              // ✅ 콜백 중복 방지: 리스트 영역의 탭은 오직 '시간 이동'만 담당 [cite: 2026-01-22]
              onLyricTap: (index) {
                final targetTime = _lyrics[index].startTime;
                if (targetTime != null) {
                  _controller.seekTo(targetTime);
                }
              },
              onLyricLongPress: (lyric) => _showExplanationDialog(lyric),
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        child: ElevatedButton(
          // ✅ 이미 완료했다면 클릭 불가 처리
          onPressed: _isAlreadyCompleted
              ? null
              : () async {
                  final db = RudDatabase();
                  final videoId = widget.video.youtubeVideoId;

                  try {
                    // 1. 오늘의 학습 기록 저장 [cite: 2026-01-22]
                    await db.saveStudyRecord(videoId);

                    if (mounted) {
                      setState(() => _isAlreadyCompleted = true); // 즉시 UI 반영

                      // 성공 알림 (선택 사항)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("오늘의 공부 기록이 저장되었습니다!")),
                      );

                      Navigator.pop(context, true);
                    }
                  } catch (e) {
                    print("RUD: 공부 기록 저장 실패 - $e");
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: _isAlreadyCompleted ? Colors.grey : Colors.red,
            disabledBackgroundColor: Colors.grey.shade300,
            minimumSize: Size(double.infinity, 52.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.w),
            ),
          ),
          child: Text(
            _isAlreadyCompleted ? "오늘의 공부를 완료했습니다" : "오늘의 공부 완료",
            style: TextStyle(
              color: _isAlreadyCompleted ? Colors.grey.shade600 : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
