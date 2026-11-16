import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506656425";
  final String nama = "Anantha Kamal Eirian";
  final String kelas = "PBP D";

  final List<ItemHomepage> items = [
    ItemHomepage(
      "Lihat Proyek",
      Icons.folder_rounded,
      Colors.blue.shade700,
      subtitle: "Daftar karya",
      detailDescription:
          "Menampilkan koleksi proyek teknis yang terhubung dengan ekosistem portofolio web Django (/api/v1/projects/).",
    ),
    ItemHomepage(
      "Tambah Proyek",
      Icons.add_circle_rounded,
      Colors.green.shade700,
      subtitle: "Entri baru",
      detailDescription:
          "Membuka formulir untuk menambahkan proyek portofolio baru beserta deskripsi dan tech stack.",
    ),
    ItemHomepage(
      "Logout",
      Icons.logout_rounded,
      Colors.red.shade600,
      subtitle: "Keluar sesi",
      detailDescription:
          "Mengakhiri sesi autentikasi akun pengguna ketika integrasi login Django diaktifkan.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur visual dasar halaman (AppBar, Body, SnackBar).
    return Scaffold(
      // AppBar menampilkan bar bagian atas halaman aplikasi.
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // Body halaman utama dengan padding di sekelilingnya.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Baris horizontal untuk menampilkan 3 InfoCard secara sejajar dan simetris.
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: InfoCard(
                      title: 'NPM',
                      content: npm,
                      icon: Icons.badge_outlined,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: InfoCard(
                      title: 'Name',
                      content: nama,
                      icon: Icons.person_outline,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: InfoCard(
                      title: 'Class',
                      content: kelas,
                      icon: Icons.school_outlined,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16.0),

            // Bagian tengah: pesan sambutan dan kisi tombol menu portofolio.
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di MyPortfolio Mobile!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  // GridView menampilkan kartu tombol dalam tata letak kisi 3 kolom.
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    // shrinkWrap agar ukuran kisi menyesuaikan tinggi konten anak.
                    shrinkWrap: true,
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kartu informasi profil pemilik portofolio yang menampilkan ikon opsional,
/// judul ([title]), dan isi ([content]) secara terpusat.
class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData? icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20.0, color: colorScheme.primary),
              const SizedBox(height: 6.0),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13.0),
            ),
          ],
        ),
      ),
    );
  }
}

/// Model data untuk setiap tombol menu aksi pada halaman utama portofolio.
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  final String subtitle;
  final String detailDescription;

  ItemHomepage(
    this.name,
    this.icon,
    this.color, {
    this.subtitle = '',
    this.detailDescription = '',
  });
}

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
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
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
          action: SnackBarAction(
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
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const SizedBox(height: 6),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (item.subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    textAlign: TextAlign.center,
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
