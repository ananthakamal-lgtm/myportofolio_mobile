import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';

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
    final destinationBuilder = item.destinationBuilder;
    final hasDestination = destinationBuilder != null;

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
          action: hasDestination
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

    // Navigasi menggunakan Navigator.push bila item memiliki halaman tujuan.
    if (destinationBuilder != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: destinationBuilder),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            children: [
              Icon(
                item.icon,
                color: Colors.white,
                size: 26.0,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.5,
                        height: 1.15,
                      ),
                    ),
                    if (item.subtitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.88),
                          fontSize: 10.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
