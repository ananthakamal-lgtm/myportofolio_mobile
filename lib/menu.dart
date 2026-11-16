import 'package:flutter/material.dart';

/// Halaman menu utama aplikasi MyPortfolio Mobile.
///
/// Diimplementasikan sebagai [StatelessWidget] yang menampilkan identitas pemilik
/// melalui 3 [InfoCard], ringkasan profil interaktif, serta kisi tombol aksi [ItemCard].
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506656425";
  final String nama = "Anantha Kamal Eirian";
  final String kelas = "PBP D";
  final String programStudi = "S1 Ilmu Komputer • Universitas Indonesia";
  final String bio =
      "Mahasiswa Ilmu Komputer Universitas Indonesia yang tertarik pada pengembangan perangkat lunak dan pendidikan.";

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

  void _showOwnerProfileSheet(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: colorScheme.primary,
                    child: const Text(
                      'AK',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nama,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          programStudi,
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(bio, style: const TextStyle(height: 1.4)),
              const SizedBox(height: 14),
              _buildProfileInfoRow(Icons.badge_outlined, 'NPM', npm),
              const SizedBox(height: 6),
              _buildProfileInfoRow(Icons.school_outlined, 'Kelas', kelas),
              const SizedBox(height: 14),
              const Text(
                'Modul Ekosistem Portofolio',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(height: 8),
              const Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  Chip(label: Text('Projects')),
                  Chip(label: Text('Experience')),
                  Chip(label: Text('Achievements')),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black54),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
        backgroundColor: colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            tooltip: 'Profil Pemilik',
            onPressed: () => _showOwnerProfileSheet(context),
          ),
        ],
      ),
      // SafeArea dan SingleChildScrollView mencegah overflow pada layar kecil.
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
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

                  const SizedBox(height: 12.0),

                  // Kartu sambutan pemilik portofolio beserta akses cepat profil lengkap.
                  Card(
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Selamat datang di MyPortfolio Mobile!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            programStudi,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          OutlinedButton.icon(
                            onPressed: () => _showOwnerProfileSheet(context),
                            icon: const Icon(
                              Icons.account_circle_outlined,
                              size: 18,
                            ),
                            label: const Text('Lihat Profil Pemilik'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  // Bagian menu aksi portofolio.
                  const Text(
                    'Menu Portofolio',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Ketuk kartu untuk aksi cepat atau tahan untuk pratinjau fitur',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),

                  // GridView menampilkan kartu tombol dalam tata letak kisi 3 kolom.
                  GridView.count(
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 4.0,
                    ),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    childAspectRatio: 0.90,
                    // shrinkWrap agar ukuran kisi menyesuaikan tinggi konten anak.
                    shrinkWrap: true,
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
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
