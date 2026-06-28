import 'package:flutter/material.dart';
import 'package:thala_aware/data/app_data.dart';
import 'package:thala_aware/screens/details/article_detail_screen.dart';
import 'package:thala_aware/screens/details/directory_screen.dart';

class EducationTab extends StatelessWidget {
  const EducationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Item 1: Link ke Direktori Lokasi
        _buildEduCard(
          context,
          icon: Icons.location_on,
          title: 'Cari Lokasi Skrining',
          subtitle: 'Temukan laboratorium & PMI terdekat.',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DirectoryScreen()),
            );
          },
        ),

        // Item 2: Artikel Mitos vs Fakta
        _buildEduCard(
          context,
          icon: Icons.quiz,
          title: 'Mitos vs. Fakta',
          subtitle: 'Pisahkan fakta dari misinformasi.',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailScreen(
                  title: 'Mitos vs. Fakta',
                  content: AppData.getArticleContent('mitos_fakta'),
                ),
              ),
            );
          },
        ),

        // Item 3: Artikel Perbedaan Major/Minor
        _buildEduCard(
          context,
          icon: Icons.bloodtype,
          title: 'Major vs. Minor (Pembawa Sifat)',
          subtitle: 'Pahami perbedaan utamanya.',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailScreen(
                  title: 'Major vs. Minor',
                  content: AppData.getArticleContent('major_minor'),
                ),
              ),
            );
          },
        ),

        // Item 4: Artikel Proses Skrining
         _buildEduCard(
          context,
          icon: Icons.science,
          title: 'Bagaimana Proses Skrining?',
          subtitle: 'Apa yang terjadi saat tes darah?',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailScreen(
                  title: 'Proses Skrining',
                  content: AppData.getArticleContent('proses_skrining'),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Widget helper untuk membuat card yang seragam
  Widget _buildEduCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.teal),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}