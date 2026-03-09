import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';

class ExploreScreen extends StatefulWidget {
  final int initialTabIndex;

  const ExploreScreen({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void didUpdateWidget(ExploreScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTabIndex != oldWidget.initialTabIndex) {
      _tabController.animateTo(widget.initialTabIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konular'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tümü'),
            Tab(text: 'TYT'),
            Tab(text: 'AYT'),
          ],
        ),
      ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Konu ara...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTopicGrid(_getFilteredTopics('All')),
                  _buildTopicGrid(_getFilteredTopics('TYT')),
                  _buildTopicGrid(_getFilteredTopics('AYT')),
                ],
              ),
            ),
          ],
        ),
      );
  }

  List<Map<String, dynamic>> _getFilteredTopics(String type) {
    final searchFiltered = _sampleTopics.where((topic) =>
        (topic['title'] as String)
            .toLowerCase()
            .startsWith(_searchQuery.toLowerCase()));

    if (type == 'TYT') {
      return searchFiltered
          .where((t) => t['grade'].toString().startsWith('9') || t['grade'].toString().startsWith('10'))
          .toList();
    } else if (type == 'AYT') {
      return searchFiltered
          .where((t) => t['grade'].toString().startsWith('11') || t['grade'].toString().startsWith('12'))
          .toList();
    }

    return searchFiltered.toList(); // For 'All'
  }

  Widget _buildTopicGrid(List<Map<String, dynamic>> topics) {
    if (topics.isEmpty) {
      return const Center(child: Text('Aradığınız kriterlere uygun konu bulunamadı.'));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
      ),
      itemCount: topics.length,
      itemBuilder: (context, i) {
        final topic = topics[i];
        return _TopicCard(topic: topic);
      },
    );
  }
}

class _TopicCard extends StatelessWidget {
  final Map<String, dynamic> topic;

  const _TopicCard({required this.topic});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/topic/${topic['id']}');
      },
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(
                topic['icon'] as IconData,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              topic['title'] as String,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              topic['grade'] as String,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            LinearProgressIndicator(
              value: topic['progress'] as double,
              backgroundColor: AppColors.surfaceVariant,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '%${((topic['progress'] as double) * 100).round()} tamamlandı',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _sampleTopics = [
  {
    'id': 'hucre-yapisi',
    'title': 'Hücre',
    'grade': '9. Sınıf',
    'icon': Icons.circle_outlined,
    'progress': 0.75,
  },
  {
    'id': 'hucre-zari',
    'title': 'Hücre Zarı',
    'grade': '10. Sınıf',
    'icon': Icons.panorama_fish_eye,
    'progress': 0.60,
  },
  {
    'id': 'mitoz-bolunme',
    'title': 'Mitoz',
    'grade': '10. Sınıf',
    'icon': Icons.cell_tower,
    'progress': 0.30,
  },
  {
    'id': 'mayoz-bolunme',
    'title': 'Mayoz',
    'grade': '11. Sınıf',
    'icon': Icons.merge,
    'progress': 0.0,
  },
  {
    'id': 'sindirim-sistemi',
    'title': 'Sindirim',
    'grade': '11. Sınıf',
    'icon': Icons.restaurant,
    'progress': 0.0,
  },
  {
    'id': 'dolasim-sistemi',
    'title': 'Dolaşım',
    'grade': '11. Sınıf',
    'icon': Icons.favorite_outline,
    'progress': 0.0,
  },
];
