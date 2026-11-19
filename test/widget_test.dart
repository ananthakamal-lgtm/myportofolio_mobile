import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

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

  testWidgets(
    'ItemCards have unique colors, show SnackBars, and Tambah Proyek pushes form',
    (WidgetTester tester) async {
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

      // Uji SnackBar untuk kartu non-navigasi (Lihat Proyek dan Logout).
      await tester.tap(find.text('Lihat Proyek'));
      await tester.pumpAndSettle();
      expect(
        find.text('Kamu telah menekan tombol Lihat Proyek!'),
        findsOneWidget,
      );

      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();
      expect(find.text('Kamu telah menekan tombol Logout!'), findsOneWidget);

      // Uji tombol aksi 'Detail' pada SnackBar Logout.
      await tester.tap(find.text('Detail'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(
        find.textContaining('Mengakhiri sesi autentikasi akun pengguna'),
        findsOneWidget,
      );
      await tester.tap(find.text('Tutup'));
      await tester.pumpAndSettle();

      // Uji tombol Tambah Proyek memunculkan SnackBar dan push ke ProjectFormPage.
      await tester.tap(find.text('Tambah Proyek'));
      await tester.pumpAndSettle();
      expect(find.byType(ProjectFormPage), findsOneWidget);
      expect(find.text('Add Project Form'), findsOneWidget);

      // Kembali (pop) ke MyHomePage.
      Navigator.of(tester.element(find.byType(ProjectFormPage))).pop();
      await tester.pumpAndSettle();
      expect(find.byType(MyHomePage), findsOneWidget);
    },
  );

  testWidgets('LeftDrawer navigates between Home and Add Project pages', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Buka drawer menu di MyHomePage.
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    expect(find.byType(LeftDrawer), findsOneWidget);
    expect(find.text('My Portfolio'), findsOneWidget);
    expect(
      find.text('Explore personal projects and experiences!'),
      findsOneWidget,
    );

    // Pindah ke halaman Add Project melalui Drawer (pushReplacement).
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();

    expect(find.byType(ProjectFormPage), findsOneWidget);
    expect(find.byType(MyHomePage), findsNothing);

    // Buka drawer dari ProjectFormPage dan kembali ke Home.
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(ProjectFormPage), findsNothing);
  });

  testWidgets(
    'ProjectFormPage validates required fields, shows dialog summary, and resets',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Tambah Proyek'));
      await tester.pumpAndSettle();
      // Tunggu SnackBar 3 detik selesai menghilang agar tidak menutupi tombol Save.
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      // Tekan Save dalam keadaan kosong untuk memastikan validasi berjalan.
      await tester.ensureVisible(find.text('Save'));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
      expect(
        find.text('Deskripsi proyek tidak boleh kosong!'),
        findsOneWidget,
      );
      expect(find.byType(AlertDialog), findsNothing);

      // Isi seluruh field formulir.
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Nama Proyek'),
        'MyPortfolio App',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Deskripsi Proyek'),
        'Aplikasi portofolio Flutter',
      );

      // Ubah pilihan kategori pada DropdownButtonFormField.
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mobile Development').last);
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Teknologi yang Digunakan'),
        'Flutter, Dart',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Tautan Proyek'),
        'https://github.com/ananthakamal-lgtm/myportofolio_mobile',
      );

      await tester.ensureVisible(find.text('Save'));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verifikasi pop-up AlertDialog menampilkan seluruh isian formulir.
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
      expect(find.text('Nama Proyek: MyPortfolio App'), findsOneWidget);
      expect(
        find.text('Deskripsi: Aplikasi portofolio Flutter'),
        findsOneWidget,
      );
      expect(find.text('Kategori: Mobile Development'), findsOneWidget);
      expect(find.text('Teknologi: Flutter, Dart'), findsOneWidget);
      expect(
        find.text(
          'Tautan: https://github.com/ananthakamal-lgtm/myportofolio_mobile',
        ),
        findsOneWidget,
      );

      // Tutup dialog dan pastikan form ter-reset.
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('MyPortfolio App'), findsNothing);
    },
  );

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
