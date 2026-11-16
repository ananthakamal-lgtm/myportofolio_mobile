import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/menu.dart';

void main() {
  testWidgets('MyHomePage is StatelessWidget and shows owner InfoCards', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Pastikan MyHomePage merupakan StatelessWidget sesuai instruksi Tugas 7.
    expect(tester.widget(find.byType(MyHomePage)), isA<StatelessWidget>());

    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);

    // Pastikan 3 InfoCard menampilkan identitas pemilik secara akurat.
    expect(find.byType(InfoCard), findsNWidgets(3));
    expect(find.text('NPM'), findsOneWidget);
    expect(find.text('2506656425'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Anantha Kamal Eirian'), findsOneWidget);
    expect(find.text('Class'), findsOneWidget);
    expect(find.text('PBP D'), findsOneWidget);

    // Pastikan data contoh Burhan tidak lagi digunakan.
    expect(find.text('2406000001'), findsNothing);
    expect(find.text('Burhan'), findsNothing);
    expect(find.text('PBP A'), findsNothing);
  });

  testWidgets('ItemCards have unique colors and show matching SnackBars', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final itemCardFinder = find.byType(ItemCard);
    expect(itemCardFinder, findsNWidgets(3));

    // Verifikasi setiap ItemCard memakai warna unik dari model ItemHomepage.
    final colors = <Color?>[];
    for (final element in itemCardFinder.evaluate()) {
      final card = element.widget as ItemCard;
      final material = tester.widget<Material>(
        find
            .descendant(
              of: find.byWidget(card),
              matching: find.byType(Material),
            )
            .first,
      );
      expect(material.color, equals(card.item.color));
      colors.add(material.color);
    }
    expect(colors.toSet().length, equals(3));

    // Uji pesan SnackBar untuk masing-masing tombol aksi secara berurutan.
    for (final label in ['Lihat Proyek', 'Tambah Proyek', 'Logout']) {
      await tester.tap(find.text(label));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Kamu telah menekan tombol $label!'), findsOneWidget);
    }

    // Uji interaksi tombol aksi 'Detail' pada SnackBar aktif.
    await tester.tap(find.text('Detail'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
      find.textContaining('Mengakhiri sesi autentikasi akun pengguna'),
      findsOneWidget,
    );
    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
  });

  testWidgets(
    'Responsive layout on narrow mobile supports profile sheet and item detail',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const MyApp());

      // Buka modal profil pemilik melalui tombol Profil pada kartu sambutan.
      await tester.tap(find.text('Profil'));
      await tester.pumpAndSettle();

      expect(find.text('Modul Ekosistem Portofolio'), findsOneWidget);
      expect(find.text('Projects'), findsOneWidget);
      expect(find.text('Experience'), findsOneWidget);
      expect(find.text('Achievements'), findsOneWidget);

      await tester.tap(find.text('Tutup'));
      await tester.pumpAndSettle();

      // Tekan lama kartu menu untuk membuka dialog pratinjau detail aksi.
      await tester.longPress(find.text('Tambah Proyek'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(
        find.textContaining('formulir untuk menambahkan proyek portofolio'),
        findsOneWidget,
      );

      await tester.tap(find.text('Tutup'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    },
  );
}
