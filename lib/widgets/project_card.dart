import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

/// Kartu tombol menu interaktif yang menggunakan warna unik [ItemHomepage.color]
/// dan memunculkan [SnackBar] serta pratinjau detail aksi saat ditekan.
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  void _showItemDetailDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: item.color.withValues(alpha: 0.14),
                child: Icon(item.icon, color: item.color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            item.detailDescription.isNotEmpty
                ? item.detailDescription
                : 'Aksi menu ${item.name} pada aplikasi MyPortfolio Mobile.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void _handleTap(BuildContext context) {
    final navigatesToForm = item.name == "Tambah Proyek";

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: item.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Row(
            children: [
              Icon(item.icon, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Kamu telah menekan tombol ${item.name}!",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          action: navigatesToForm
              ? null
              : SnackBarAction(
                  label: 'Detail',
                  textColor: Colors.white,
                  onPressed: () {
                    if (context.mounted) {
                      _showItemDetailDialog(context);
                    }
                  },
                ),
        ),
      );

    // Navigasi ke halaman tambah proyek saat kartu Tambah Proyek ditekan.
    if (navigatesToForm) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProjectFormPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // Menggunakan warna unik dari atribut color pada model ItemHomepage.
      color: item.color,
      elevation: 2.0,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _handleTap(context),
        onLongPress: () => _showItemDetailDialog(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 28.0,
                ),
                const SizedBox(height: 4),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0,
                  ),
                ),
                if (item.subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.88),
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
