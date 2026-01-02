import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:fab_m3e/fab_m3e.dart';
import 'package:siteclip/core/constants/colors.dart';

class Project {
  final String id;
  final String title;
  final String client;
  final String thumbnailAsset;

  Project({
    required this.id,
    required this.title,
    required this.client,
    required this.thumbnailAsset,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showSampleData = false;

  final FabMenuController _fabController = FabMenuController();

  final List<Project> _sampleProjects = [
    Project(
      id: '1',
      title: 'EcoSmart: A Sustainable Urban Gardening Initiative',
      client: 'Horizon Ridge Builders',
      thumbnailAsset: 'assets/thumb1.png',
    ),
    Project(
      id: '2',
      title: 'Greenfield Development',
      client: 'Sunset Valley Construction',
      thumbnailAsset: 'assets/thumb2.png',
    ),
    Project(
      id: '3',
      title: 'Riverbend Renovation',
      client: 'Maplewood Estates',
      thumbnailAsset: 'assets/thumb3.png',
    ),
    Project(
      id: '4',
      title: 'Oceanview Plaza',
      client: 'Pinecrest Partners',
      thumbnailAsset: 'assets/thumb5.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final projects = _showSampleData ? _sampleProjects : <Project>[];
    final totalPhotos = _showSampleData ? 683 : 0;

    return Scaffold(
      backgroundColor: AppColors.surfaceBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceBackground,
        title: GestureDetector(
          onTap: () => setState(() => _showSampleData = !_showSampleData),
          child: Text(
            'SiteClip',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                'assets/profile.png',
              ), // Add your profile image
            ),
          ),
        ],
      ),
      body:
          projects.isEmpty
              ? _buildEmptyState()
              : _buildProjectList(projects, totalPhotos),
      floatingActionButton: FabMenuM3E(
        controller: _fabController,
        alignment: Alignment.bottomRight,
        direction: FabMenuDirection.up,
        primaryFab: FabM3E(
          icon: const Icon(Icons.add),
          onPressed: _fabController.toggle,
        ),
        items: [
          FabMenuItem(
            icon: const Icon(Icons.file_download),
            label: const Text('Import'),
            onPressed: () {
              // TODO: Import action
            },
          ),
          FabMenuItem(
            icon: const Icon(Icons.add),
            label: const Text('Create Project'),
            onPressed: () {
              // TODO: Navigate to create project screen
              context.push('/project/create');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Project',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your projects will be shown here',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectList(List<Project> projects, int totalPhotos) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search clip project',
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              filled: true,
              fillColor: AppColors.surfaceCard,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatBadge('${projects.length} projects'),
              _buildStatBadge('$totalPhotos Photos'),
              Icon(Icons.swap_vert, color: AppColors.textPrimary),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return Slidable(
                key: ValueKey(project.id),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      onPressed: (_) {
                        // TODO: Delete project
                      },
                      backgroundColor: AppColors.utilityError,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    // TODO: Navigate to project details
                    context.push('/project/${project.id}');
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      project.thumbnailAsset,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    project.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  subtitle: Text(
                    project.client,
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryAction,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
