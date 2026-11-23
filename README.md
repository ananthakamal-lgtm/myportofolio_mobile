# MyPortfolio Mobile

Aplikasi mobile berbasis **Flutter** untuk ekosistem portofolio pribadi, dikembangkan sebagai bagian dari mata kuliah **Pemrograman Berbasis Platform (CSGE602022)**, Fakultas Ilmu Komputer, Universitas Indonesia — Semester Gasal 2026/2027.

Aplikasi ini menjadi pendamping mobile dari website portofolio pribadi berbasis Django (`myportofolio`), dengan fokus pada struktur widget yang modular, tata letak responsif, serta interaksi antarmuka berbasis Material 3.

---

## Identitas Pemilik

| Atribut | Nilai |
| :--- | :--- |
| **Nama Lengkap** | Anantha Kamal Eirian |
| **NPM** | `2506656425` |
| **Kelas** | PBP D |
| **Program Studi** | S1 Ilmu Komputer — Universitas Indonesia |

---

## Fitur Utama

- **Kartu Identitas Profil (`InfoCard`)**: Menampilkan 3 kartu informasi simetris (**NPM**, **Name**, **Class**) di bagian atas halaman dengan ikon pendukung dan penyesuaian tinggi otomatis (`IntrinsicHeight`).
- **Kartu Menu Portofolio Berwarna (`ItemCard`)**: Menyediakan 4 tombol aksi dalam tata letak kisi 2×2 (**Lihat Proyek**, **Tambah Proyek**, **Tambah Pengalaman**, dan **Logout**) dengan warna latar unik dan kontras (Biru, Hijau, Ungu Tua, Merah) yang dimodelkan secara bersih pada kelas `ItemHomepage`.
- **Umpan Balik Interaktif (`SnackBar` & Pratinjau Detail)**: Mengetuk kartu memunculkan `SnackBar` berwarna senada berisi pesan `"Kamu telah menekan tombol [Nama Tombol]!"` (dilengkapi aksi `Detail` untuk kartu non-navigasi), sedangkan menahan kartu (`onLongPress`) membuka dialog pratinjau fungsi fitur.
- **Pratinjau Profil Pemilik**: Tombol profil pada `AppBar` dan kartu sambutan membuka *modal bottom sheet* berisi ringkasan bio serta modul ekosistem portofolio Django (*Projects*, *Experience*, *Achievements*).
- **Navigasi Drawer & Formulir Portofolio (`LeftDrawer`, `ProjectFormPage`, `ExperienceFormPage`)**: Menyediakan menu navigasi samping untuk berpindah antara **Home**, **Add Project**, dan **Add Experience** menggunakan `Navigator.pushReplacement`, serta navigasi `Navigator.push` dari kartu aksi di halaman utama menuju formulir proyek dan pengalaman lengkap dengan `showDatePicker()`, `SwitchListTile`, validasi menyeluruh, serta `AlertDialog` ringkasan isian.
- **Tata Letak Responsif**: Menggunakan `SafeArea`, `SingleChildScrollView`, serta `ConstrainedBox` agar terbebas dari *overflow* baik di layar ponsel sempit (`360x800`) maupun layar lebar.

---

## Struktur Proyek

```text
myportofolio_mobile/
├── lib/
│   ├── screens/
│   │   ├── experience_form.dart # Halaman formulir tambah pengalaman (ExperienceFormPage)
│   │   ├── menu.dart            # Halaman utama (MyHomePage), InfoCard, dan model ItemHomepage
│   │   └── project_form.dart    # Halaman formulir tambah proyek (ProjectFormPage) & validasi
│   ├── widgets/
│   │   ├── left_drawer.dart     # Drawer navigasi bersama (Home, Add Project, Add Experience)
│   │   └── project_card.dart    # Widget ItemCard interaktif dengan navigasi & SnackBar
│   └── main.dart                # Entry point aplikasi & konfigurasi tema MaterialApp
├── test/
│   └── widget_test.dart         # Pengujian widget otomatis (identitas, warna, navigasi, form)
├── pubspec.yaml                 # Deklarasi dependensi (termasuk material_ui) & konfigurasi paket
└── README.md                    # Dokumentasi proyek, progres mingguan, refleksi, & AI disclosure
```

---

## Panduan Setup & Menjalankan Proyek

### Prasyarat
- **Flutter SDK** (diverifikasi pada Flutter `3.47.9` • Dart `3.13.7`)
- IDE (VS Code / Android Studio) serta emulator Android, iOS Simulator, Chrome, atau Windows Desktop runner.

### Langkah Setup Lokal
1. **Clone repositori ini:**
   ```bash
   git clone https://github.com/ananthakamal-lgtm/myportofolio_mobile.git
   cd myportofolio_mobile
   ```
2. **Unduh dependensi Flutter:**
   ```bash
   flutter pub get
   ```
3. **Jalankan analisis statis kode (*linting*):**
   ```bash
   flutter analyze
   ```
   Pastikan keluaran menampilkan `No issues found!`.
4. **Jalankan pengujian widget (*widget test*):**
   ```bash
   flutter test
   ```
5. **Jalankan aplikasi:**
   ```bash
   flutter run
   ```

---

## Progres Mingguan

- **Tutorial 08 (Basic Flutter):** Inisialisasi proyek Flutter `myportofolio_mobile`, memisahkan widget halaman utama ke `lib/menu.dart` dari `lib/main.dart`, mengubah `MyHomePage` menjadi `StatelessWidget`, serta menyusun komponen awal `InfoCard` dan `ItemCard`.
- **Individual Assignment 7 (Basic Flutter):** Mengganti identitas contoh menjadi data pribadi akurat, menambahkan atribut `Color color` pada `ItemHomepage`, menerapkan warna latar unik per tombol `ItemCard`, menyempurnakan tema Material 3 & interaktivitas UI/UX (modal profil pemilik dan dialog pratinjau aksi), memperluas pengujian di `test/widget_test.dart`, serta menyusun jawaban reflektif dan AI disclosure.
- **Tutorial 09 (Flutter Navigation, Layouts, Forms, and Input Elements):** Menambahkan paket `material_ui` dan memigrasikan impor Material, membangun `LeftDrawer` (`lib/widgets/left_drawer.dart`) dan halaman formulir `ProjectFormPage` (`lib/screens/project_form.dart`) dengan validasi dan dialog ringkasan, menghubungkan navigasi `Navigator.push` pada tombol **Tambah Proyek**, merapikan struktur berkas ke dalam `lib/screens/` dan `lib/widgets/`, serta memperluas widget test.
- **Individual Assignment 8 (Flutter Navigation, Layouts, Forms, and Input Elements):** Membuat halaman formulir `ExperienceFormPage` (`lib/screens/experience_form.dart`) yang selaras dengan model `Experience` Django (judul, kategori, deskripsi, tanggal mulai/selesai via `showDatePicker()`, toggle *Masih berlangsung*, dan URL thumbnail opsional), menambahkan kartu aksi **Tambah Pengalaman** di halaman utama dan opsi **Add Experience** di `LeftDrawer`, merefaktor navigasi kartu berbasis `destinationBuilder`, memperluas widget test (termasuk uji layar ponsel `360x800`), serta melengkapi refleksi dan AI disclosure Tugas 8.

---

### Tugas 7

1. **Pengertian *Widget Tree* pada Flutter dan Cara Kerja Hubungan Induk-Anak (*Parent-Child*):**
   - ***Widget Tree*** adalah struktur data hierarkis berbentuk pohon yang merepresentasikan susunan seluruh elemen antarmuka pengguna (UI) di aplikasi Flutter—mulai dari *root widget* seperti `MaterialApp`, struktur halaman seperti `Scaffold`, kontainer tata letak seperti `Column`/`Row`, hingga elemen daun seperti `Text` dan `Icon`.
   - **Cara Kerja Hubungan Induk-Anak (*Parent-Child*):**
     - **Komposisi Deklaratif:** Sebuah widget induk (*parent*) membungkus satu widget anak (*child*, misalnya `Padding`, `Center`, `Card`) atau sekumpulan anak (*children*, misalnya `Column`, `Row`, `GridView`).
     - **Mekanisme Layout (*Constraints Go Down, Sizes Go Up, Parent Sets Position*):** Saat fase tata letak berlangsung, widget induk mengirimkan batasan ukuran (*constraints*, seperti `minWidth`, `maxWidth`, `minHeight`, `maxHeight`) ke bawah menuju widget anak. Widget anak kemudian menentukan ukurannya sendiri sesuai batasan tersebut dan mengembalikannya (*sizes go up*) ke induk. Terakhir, widget induk menentukan posisi koordinat `(x, y)` penempatan widget anak di layar.
     - **Pewarisan Konteks (*Inherited Context*):** Widget induk juga dapat menyediakan data konfigurasi (seperti tema warna dari `MaterialApp`/`Theme`, media layar dari `MediaQuery`, atau pengelola notifikasi dari `ScaffoldMessenger`) yang dapat diakses oleh seluruh keturunannya melalui `BuildContext`.

2. **Daftar Semua Widget yang Digunakan dalam Proyek Ini dan Fungsinya Masing-Masing:**
   Berikut seluruh widget yang digunakan di `lib/main.dart` dan `lib/menu.dart`:
   - **Widget Kustom Proyek:**
     1. `MyApp` (`StatelessWidget` di `lib/main.dart`): Widget root aplikasi yang menyiapkan skema warna Material 3 dan memasang `MyHomePage` sebagai halaman awal.
     2. `MyHomePage` (`StatelessWidget` di `lib/menu.dart`): Widget halaman menu utama yang menampilkan identitas pemilik, kartu sambutan, dan kisi tombol portofolio.
     3. `InfoCard` (`StatelessWidget` di `lib/menu.dart`): Widget kartu kustom untuk menampilkan informasi profil (`NPM`, `Name`, `Class`) beserta ikon opsional.
     4. `ItemCard` (`StatelessWidget` di `lib/menu.dart`): Widget kartu tombol interaktif dengan warna latar unik per item (`item.color`), efek sentuhan, `SnackBar`, dan dialog pratinjau fitur.
   - **Widget Bawaan Flutter Material & Layout:**
     5. `MaterialApp`: Root widget Material Design yang mengatur judul aplikasi, konfigurasi tema (`ThemeData`), navigasi dasar, serta halaman awal (`home`).
     6. `Scaffold`: Menyediakan kerangka visual standar halaman Material Design (slot `appBar`, `body`, serta dukungan penampilan `SnackBar`).
     7. `AppBar`: Bilah judul di bagian atas layar yang menampilkan nama aplikasi `'MyPortfolio'` dan tombol aksi profil pemilik.
     8. `IconButton`: Tombol berbasis ikon di `AppBar` (lengkap dengan `tooltip`) untuk memicu pembukaan bottom sheet profil pemilik.
     9. `SafeArea`: Memberikan batas aman otomatis agar konten tidak tertutup oleh *notch*, bilah status, atau bilah navigasi sistem perangkat.
     10. `SingleChildScrollView`: Memungkinkan isi halaman digulir secara vertikal apabila tinggi konten melebihi tinggi layar perangkat.
     11. `Center`: Memusatkan widget anak di dalam area kosong yang diberikan oleh induknya.
     12. `ConstrainedBox`: Membatasi lebar maksimum konten halaman (`maxWidth: 560`) dan grid menu (`maxWidth: 380`) agar proporsional di berbagai ukuran layar.
     13. `Column`: Menyusun beberapa widget anak secara vertikal dari atas ke bawah.
     14. `IntrinsicHeight`: Menyamakan tinggi seluruh widget anak di dalam `Row` (ketiga `InfoCard`) agar sejajar mengikuti kartu tertinggi.
     15. `Row`: Menyusun beberapa widget anak secara horizontal dari kiri ke kanan (pada baris `InfoCard`, kartu sambutan, baris info profil, judul dialog, dan isi `SnackBar`).
     16. `Expanded`: Membuat widget anak mengisi sisa ruang yang tersedia secara proporsional di dalam `Row` agar tidak terjadi *overflow* teks.
     17. `SizedBox`: Memberikan jarak spasi tetap antar-widget (vertikal maupun horizontal) dan mengatur lebar penuh tombol di bottom sheet.
     18. `Card`: Kontainer bergaya kartu Material dengan elevasi bayangan dan sudut membulat (`RoundedRectangleBorder`).
     19. `Padding`: Memberikan ruang bantalan (*inner padding*) di sekitar widget anak.
     20. `Text`: Menampilkan teks pada antarmuka beserta konfigurasi `TextStyle`, perataan (`textAlign`), batas baris (`maxLines`), dan pemotongan (`overflow`).
     21. `OutlinedButton` (`OutlinedButton.icon`): Tombol berbingkai dengan ikon dan teks `'Profil'` untuk membuka pratinjau profil pemilik.
     22. `GridView` (`GridView.count`): Menampilkan daftar `ItemCard` dalam tata letak kisi 3 kolom (`crossAxisCount: 3`) dengan `shrinkWrap: true`.
     23. `Material`: Memberikan permukaan Material berwarna (`color: item.color`), elevasi, dan sudut membulat sebagai media dasar bagi `InkWell` untuk menggambar efek riak sentuhan.
     24. `InkWell`: Menangkap gestur ketuk (`onTap`) dan tekan-tahan (`onLongPress`) sekaligus menampilkan efek visual *ink ripple* di dalam batas `borderRadius`.
     25. `Container`: Widget pembungkus serbaguna untuk memberi padding kartu pada `ItemCard` serta menggambar *drag handle* dekoratif (`BoxDecoration`) di bottom sheet.
     26. `Icon`: Menampilkan ikon vektor Material (`Icons.*`) pada kartu, tombol, `AppBar`, dialog, dan `SnackBar`.
     27. `CircleAvatar`: Menampilkan lingkaran berinisial `'AK'` pada modal profil pemilik dan latar ikon berwarna pada dialog pratinjau item.
     28. `Wrap`: Menyusun kumpulan `Chip` modul portofolio agar otomatis berpindah baris bila lebar horizontal tidak lagi mencukupi.
     29. `Chip`: Menampilkan label kategori ringkas (*Projects*, *Experience*, *Achievements*) di dalam modal profil pemilik.
     30. `FilledButton`: Tombol aksi utama berwarna solid untuk menutup modal bottom sheet profil pemilik.
     31. `AlertDialog`: Kotak dialog Material (`showDialog`) untuk menampilkan penjelasan pratinjau tiap aksi menu portofolio.
     32. `TextButton`: Tombol teks sederhana pada area aksi `AlertDialog` untuk menutup dialog (`'Tutup'`).
     33. `SnackBar` & `SnackBarAction`: Pesan notifikasi sementara di bagian bawah layar (`ScaffoldMessenger`) yang muncul saat `ItemCard` ditekan beserta tombol aksi `'Detail'`.

3. **Fungsi Widget `MaterialApp` dan Alasan Umumnya Digunakan sebagai *Root Widget*:**
   - **Fungsi `MaterialApp`:** `MaterialApp` membungkus seluruh aplikasi dengan fungsionalitas inti berbasis desain Material milik Google, antara lain:
     - Mengelola **`Navigator`** untuk perpindahan rute antar-halaman (*routing* dan transisi halaman).
     - Menyediakan **`Theme`** global (`ThemeData`, `ColorScheme`, tipografi Material 3) yang dapat diakses dari mana saja lewat `Theme.of(context)`.
     - Menyediakan **`MediaQuery`**, **`Directionality`** (arah baca LTR/RTL), **`Localizations`**, dan **`ScaffoldMessenger`** global yang dibutuhkan widget seperti `Text`, `Scaffold`, `SnackBar`, dan `Dialog`.
   - **Mengapa Digunakan sebagai *Root Widget*:** Widget Material seperti `Scaffold`, `AppBar`, `Card`, dan `Text` bergantung pada layanan bawaan (`Theme`, `Directionality`, `Navigator`, `Localizations`) yang diinjeksikan dari atas *widget tree*. Dengan menempatkan `MaterialApp` di posisi paling atas (*root*), seluruh halaman dan widget anak di bawahnya otomatis memiliki konsistensi desain, dukungan navigasi, lokalisasi teks, dan tema terpusat tanpa perlu mengonfigurasinya ulang per halaman.

4. **Perbedaan `StatelessWidget` dan `StatefulWidget` serta Kapan Menggunakan Masing-Masing:**
   - **`StatelessWidget`:**
     - Bersifat **immutabel** (tidak memiliki objek `State` internal yang berubah selama siklus hidup widget).
     - Metode `build(BuildContext context)` hanya dijalankan saat widget pertama kali dibuat, saat widget induk membangun ulang (*rebuild*) dengan parameter baru, atau saat dependensi seperti `Theme`/`MediaQuery` berubah.
     - **Kapan dipilih:** Ketika tampilan widget hanya bergantung pada konfigurasi/argumen konstruktor statis dan tidak perlu menyimpan perubahan data internal secara langsung, misalnya `MyApp`, `MyHomePage` pada Tugas 7, `InfoCard`, dan `ItemCard`.
   - **`StatefulWidget`:**
     - Bersifat **mutabel secara state** karena berpasangan dengan kelas `State<T>` yang bertahan di memori meskipun objek widgetnya dibangun ulang.
     - Menyediakan fungsi `setState(() { ... })` untuk memberi tahu Flutter bahwa ada perubahan data internal sehingga `build()` perlu dijalankan kembali untuk memperbarui UI, serta memiliki *lifecycle hooks* seperti `initState()` dan `dispose()`.
     - **Kapan digunakan:** Ketika widget harus mempertahankan dan memperbarui data dinamis akibat interaksi pengguna atau proses asinkronus di dalam dirinya sendiri—misalnya isi input formulir (`TextEditingController`), indeks tab navigasi aktif, status *loading*/hasil *fetch* API daftar proyek, atau status checkbox/toggle.

5. **Pengertian `BuildContext`, Pentingnya di Flutter, dan Penggunaannya di dalam Metode `build`:**
   - **Pengertian:** `BuildContext` adalah sebuah *handle* atau penunjuk lokasi (*reference*) unik milik sebuah elemen widget di dalam *element tree* / *widget tree* Flutter. Secara teknis, setiap `Element` di Flutter mengimplementasikan antarmuka `BuildContext`.
   - **Mengapa Penting:** Karena widget di Flutter disusun berlapis dalam pohon hierarki, sebuah widget sering perlu berkomunikasi ke atas (*ancestor lookup*) untuk mengambil konfigurasi tema, dimensi layar, navigator, atau pengelola notifikasi tanpa harus meneruskan semua parameter tersebut secara manual melalui konstruktor.
   - **Penggunaan di dalam Metode `build(BuildContext context)`:**
     - Mengakses warna dan gaya tema terdekat: `Theme.of(context).colorScheme`.
     - Mengirimkan pesan notifikasi ke `ScaffoldMessenger` terdekat saat tombol ditekan: `ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(...)`.
     - Membuka overlay relatif terhadap navigator/konteks halaman aktif: `showModalBottomSheet(context: context, ...)` dan `showDialog(context: context, ...)`.
     - Penting diperhatikan bahwa pemanggilan `.of(context)` mencari *ancestor* di atas `context` yang dipakai, sehingga `context` harus berada di bawah widget penyedia (misalnya `ItemCard` berada di bawah `Scaffold`, bukan di `build` milik widget yang langsung mengembalikan `Scaffold` itu sendiri).

6. **Konsep *Hot Reload* vs *Hot Restart* dan Kapan Memerlukan *Hot Restart* atau *Full Restart*:**
   - ***Hot Reload*:** Menyuntikkan berkas kode Dart yang baru dikompilasi ke dalam *Dart Virtual Machine (VM)* yang sedang berjalan, lalu membangun ulang (*rebuild*) *widget tree* secara cepat (umumnya < 1 detik) **tanpa menghilangkan status (*state*) aplikasi saat ini** (posisi halaman, isi variabel `State`, dan sesi tetap dipertahankan).
   - ***Hot Restart*:** Memuat ulang seluruh kode Dart ke dalam Dart VM dan menjalankan aplikasi kembali dari fungsi `main()`, sehingga **seluruh *state* memori di-reset** ke kondisi awal tanpa harus mengompilasi ulang kode native Android/iOS dari nol.
   - **Kapan Tidak Bisa Mengandalkan *Hot Reload*:**
     - **Memerlukan *Hot Restart*:** Ketika perubahan terjadi pada fungsi `main()`, inisialisasi awal di `initState()`, perubahan nilai variabel global/statis (`static`/`const` top-level), perubahan struktur kelas `enum`, atau perubahan hierarki pewarisan kelas (misalnya mengubah `StatefulWidget` menjadi `StatelessWidget` seperti pada `MyHomePage`).
     - **Memerlukan *Full Restart* (stop & rebuild penuh):** Ketika mengubah konfigurasi dependensi di `pubspec.yaml`, menambah/mengubah aset gambar atau font baru, atau memodifikasi kode dan izin platform native (`android/`, `ios/`, `AndroidManifest.xml`, `Info.plist`, maupun plugin native).

---

### AI Disclosure (Tugas 7)

Pengerjaan Individual Assignment 7 ini memanfaatkan generative AI sebagai asisten pemrograman (*pair programming*) dengan transparansi proses, strategi *prompting*, serta evaluasi kritis berikut:

- **Tools yang Digunakan:** Gemini (Antigravity Assistant).
- **Log & Strategi Prompting:**
  1. **Pemetaan Kebutuhan & Kontinuitas Proyek:** Memberikan spesifikasi PDF *Individual Assignment 7* agar asisten memeriksa basis kode Tutorial 08 (`lib/main.dart`, `lib/menu.dart`, `test/widget_test.dart`) serta memverifikasi kelayakan setiap checklist sebelum mengubah kode.
  2. **Penyelarasan Identitas & Konteks Portofolio:** Mengonfirmasi data identitas nyata pemilik (`Anantha Kamal Eirian`, `2506656425`, `PBP D`) agar selaras dengan repositori web portofolio Django (`myportofolio`) dan bebas dari data contoh generik.
  3. **Implementasi Bertahap & Pengujian Lintas Resolusi:** Menerapkan pembaruan secara inkremental dengan *Conventional Commits* (`InfoCard` → `ItemCard` berwarna → tema & modal profil → *widget tests* → dokumentasi) serta menguji tampilan di viewport standar (`800x600`) dan layar ponsel sempit (`360x800`).
- **Bagian Spesifik yang Dibantu:**
  1. Merancang model data `ItemHomepage` dengan atribut `color`, `subtitle`, dan `detailDescription` agar pewarnaan tiap `ItemCard` modular tanpa percabangan `if-else`.
  2. Menyesuaikan skema warna Material 3 di `lib/main.dart` dan menambahkan interaktivitas ekstra (`SnackBarAction`, dialog pratinjau `AlertDialog`, serta bottom sheet profil pemilik) dengan tetap mempertahankan `MyHomePage` sebagai `StatelessWidget`.
  3. Menyusun skenario pengujian komprehensif pada `test/widget_test.dart` serta draf terstruktur jawaban 6 pertanyaan reflektif.
- **Analisis Kritis Keterbatasan AI & Perbaikan Manual yang Dilakukan:**
  1. **Deteksi *Overflow* Mikro (`0.889 px`) pada Layar Mobile Sempit (`360x800`):** Pada draf implementasi awal tata letak, tinggi kolom di dalam `ItemCard` pada `GridView.count` diperkirakan cukup secara teoretis, tetapi gagal memperhitungkan *line-height multiplier* bawaan font Roboto sehingga memunculkan `RenderFlex overflowed by 0.889 pixels` saat diuji pada viewport `360x800`. Masalah ini diidentifikasi melalui pengujian widget nyata dan diselesaikan dengan menyesuaikan `padding`, ukuran ikon (`28.0`), batas `maxLines`, dan `childAspectRatio`.
  2. **Tumpang-Tindih `SnackBar` dengan Tombol Menu di Viewport Pendek (`800x600`):** Pengujian interaktif mengungkap dua hal penting yang terlewat pada draf awal: (a) kartu menu sempat berada terlalu dekat ke bagian bawah layar sehingga tertutup floating `SnackBar` dari ketukan sebelumnya, dan (b) `SnackBar` Flutter yang memuat `SnackBarAction` tidak otomatis hilang oleh timer durasi standar demi aksesibilitas (*a11y*). Masalah diselesaikan dengan memperingkas kartu sambutan menjadi tata letak horizontal dan memisahkan `ConstrainedBox(maxWidth: 560)` untuk bagian atas serta `ConstrainedBox(maxWidth: 380)` untuk `GridView.count`, sehingga seluruh `ItemCard` selalu berada jauh di atas area tampil `SnackBar`.
  3. **Verifikasi Keakuratan Kode & Pengujian Akhir:** Memastikan daftar seluruh widget pada jawaban reflektif nomor 2 benar-benar cocok dengan isi aktual `lib/main.dart` dan `lib/menu.dart`, serta memverifikasi secara langsung bahwa `flutter analyze` menghasilkan `No issues found!` dan seluruh 3 skenario `flutter test` lulus 100%.

---

### Tugas 8

1. **Perbedaan `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()` serta Alur Navigasi Formulir & Drawer:**
   - **Perbedaan Ketiga Metode `Navigator`:**
     - **`Navigator.push()`:** Menambahkan *route* (halaman) baru ke posisi teratas tumpukan (*navigation stack*) tanpa menghapus halaman sebelumnya. Halaman lama tetap tersimpan di bawahnya sehingga pengguna dapat kembali ke halaman sebelumnya menggunakan tombol *Back* bawaan perangkat/browser atau `Navigator.pop()`.
     - **`Navigator.pushReplacement()`:** Menghapus *route* yang sedang aktif di puncak *stack* lalu langsung menggantikannya dengan *route* baru. Halaman sebelumnya tidak lagi tersisa di bawah *route* baru tersebut, sehingga mencegah penumpukan halaman berulang ketika berpindah antarhalaman tingkat atas (*top-level navigation*).
     - **`Navigator.pop()`:** Menghapus *route* teratas yang sedang aktif dari *stack* (baik halaman maupun overlay seperti `AlertDialog` atau `ModalBottomSheet`) sehingga tampilan kembali ke *route* tepat di bawahnya.
   - **Metode untuk Membuka Formulir dari Kartu Aksi:**
     Pada `ItemCard` (`lib/widgets/project_card.dart`), kartu **Tambah Proyek** dan **Tambah Pengalaman** menggunakan **`Navigator.push()`** (melalui `item.destinationBuilder`) untuk membuka `ProjectFormPage` dan `ExperienceFormPage`. Dengan `push()`, `MyHomePage` tetap berada di bawah halaman formulir pada *stack* sehingga tombol kembali (*Back*) perangkat dapat membawa pengguna pulang ke halaman utama secara alami.
   - **Cara Opsi *Home* di Drawer Membawa Pengguna Kembali ke Halaman Utama:**
     Pada `LeftDrawer` (`lib/widgets/left_drawer.dart`), opsi **Home**, **Add Project**, dan **Add Experience** memakai **`Navigator.pushReplacement()`**. Saat pengguna berada di `ExperienceFormPage` (atau `ProjectFormPage`) lalu menekan **Home** di drawer, `Navigator.pushReplacement()` menggantikan halaman formulir aktif di puncak *stack* dengan `MyHomePage()` sekaligus menutup drawer karena seluruh `Scaffold` halaman sebelumnya digantikan. Cara ini juga memastikan pengguna di peramban Chrome selalu dapat kembali ke halaman utama meski tanpa tombol *Back* fisik Android.

2. **Peran Susunan `Scaffold`, `AppBar`, dan `Drawer` dalam Menjaga Konsistensi Struktur Halaman + Contoh Penggunaan Warna Tema:**
   - **Konsistensi Struktur Halaman:**
     - **`Scaffold`** menyediakan kerangka tata letak Material yang seragam di seluruh halaman (`MyHomePage`, `ProjectFormPage`, dan `ExperienceFormPage`), termasuk slot terstandarisasi untuk bilah atas (`appBar`), navigasi samping (`drawer`), konten utama (`body`), dan pengelola notifikasi `SnackBar`.
     - **`AppBar`** menempatkan judul halaman dan tombol pembuka drawer (*hamburger menu*) pada posisi dan tinggi yang selalu sama di puncak layar, sehingga pengguna selalu mengetahui di halaman mana mereka berada dan bagaimana membuka menu navigasi.
     - **`Drawer` (`const LeftDrawer()`)** dipakai ulang sebagai satu komponen modular yang sama pada ketiga halaman. Dengan demikian, daftar tautan navigasi, urutan menu, dan tampilan header selalu konsisten tanpa duplikasi kode.
   - **Contoh Penggunaan Warna Tema Portofolio di Lebih dari Satu Halaman:**
     Pada `lib/main.dart`, tema global `ThemeData` mendefinisikan `colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3A8A), secondary: const Color(0xFFD95D39))` serta `scaffoldBackgroundColor: const Color(0xFFFAF6F0)`. Warna utama **`Theme.of(context).colorScheme.primary`** digunakan lintas halaman dan komponen:
     - Sebagai warna latar `AppBar` dan ikon pada `InfoCard` di `MyHomePage` (`lib/screens/menu.dart`),
     - Sebagai warna latar `AppBar` dan tombol aksi utama (`Save` / `Simpan`) di `ProjectFormPage` (`lib/screens/project_form.dart`) dan `ExperienceFormPage` (`lib/screens/experience_form.dart`),
     - Serta sebagai warna latar `DrawerHeader` pada `LeftDrawer` (`lib/widgets/left_drawer.dart`).

3. **Alasan Pemilihan Tata Letak Formulir serta Peran Widget Pengatur Jarak dan Widget Penggulir pada Ruang Layar Terbatas:**
   - **Alasan Pemilihan Tata Letak (`SafeArea` → `Form` → `SingleChildScrollView` → `Center` → `ConstrainedBox` → `Column`):**
     Formulir `ExperienceFormPage` memiliki beberapa input bertingkat secara alami dari atas ke bawah (ringkasan header, judul, kategori, deskripsi multi-baris, pemilih tanggal mulai, *switch* status berlangsung, pemilih tanggal selesai kondisional, URL thumbnail, hingga baris tombol Reset & Simpan). Struktur vertikal `Column` menjaga alur pengisian linear dan mudah dipindai, sementara `ConstrainedBox(maxWidth: 560)` di dalam `Center` menjaga lebar kolom input tetap nyaman dibaca pada layar desktop/Chrome tanpa melebar berlebihan.
   - **Peran Widget Pengatur Jarak (`Padding`, `SizedBox`, `SafeArea`):**
     - `SafeArea` melindungi bagian atas dan bawah formulir dari *notch*, bilah status, dan area gestur sistem.
     - `Padding` memberi ruang tepi luar formulir (`EdgeInsets.fromLTRB(16, 16, 16, 32)`) dan ruang dalam kartu agar elemen input tidak menempel ke pinggir layar.
     - `SizedBox` memberikan jeda vertikal/horizontal yang konsisten (`height: 8–24`, `width: 8–12`) sehingga label, pesan error validasi, dan tombol tidak saling berhimpitan.
   - **Peran Widget Penggulir (`SingleChildScrollView`):**
     `Column` secara bawaan tidak dapat digulir dan akan memicu `RenderFlex overflow` begitu tinggi total field melebihi tinggi layar—terutama pada layar ponsel sempit (`360x800`), ketika pesan validasi muncul, saat field *Tanggal Selesai* terbuka, atau ketika papan ketik virtual (*on-screen keyboard*) mengambil hampir setengah tinggi layar. Membungkus `Column` dengan `SingleChildScrollView` memastikan seluruh field input dan tombol **Simpan** tetap dapat digulir dan dijangkau dengan lancar tanpa terpotong.

4. **Peran `GlobalKey<FormState>`, `validator`, dan `validate()` saat Tombol Simpan Ditekan, Contoh Nilai yang Ditolak, dan Keterbatasan Jenis Input/Keyboard Saja:**
   - **Peran Masing-Masing Komponen:**
     - **`GlobalKey<FormState>` (`_formKey`):** Kunci unik yang memberikan akses langsung ke objek `FormState` milik widget `Form` dari luar pohon anak-anaknya (misalnya dari handler `_handleSave()` tombol **Simpan**), sehingga kita dapat memicu validasi (`validate()`) dan pengaturan ulang (`reset()`) seluruh field secara terkoordinasi.
     - **`validator`:** Fungsi *callback* pada setiap `TextFormField` dan `FormField` (`_validateTitle`, `_validateDescription`, `_validateThumbnailUrl`, `_validateEndDate`) yang memeriksa nilai field saat ini; mengembalikan `null` jika valid atau string pesan kesalahan jika melanggar aturan model.
     - **`_formKey.currentState!.validate()`:** Menjalankan fungsi `validator` milik **semua** `FormField` turunan `Form` secara serentak, memicu tampilan pesan error merah di bawah setiap field yang gagal, dan mengembalikan `true` hanya jika seluruh field lolos validasi (sehingga `showDialog()` hanya tampil bila seluruh data sah).
   - **Contoh Nilai yang Ditolak Validasi:**
     - Input hanya berisi spasi seperti `"   "` pada **Judul Pengalaman** ditolak oleh `_validateTitle` (memakai `.trim().isEmpty`) dengan pesan `"Judul pengalaman tidak boleh kosong!"`.
     - Input URL tanpa skema seperti `"example.com/invalid-url"` pada **URL Thumbnail** ditolak oleh `_validateThumbnailUrl` karena tidak berawalan `http://` atau `https://`.
     - Memilih **Tanggal Selesai** yang lebih awal dari **Tanggal Mulai** (misalnya mulai `15 Nov 2026`, selesai `10 Nov 2026`) ditolak oleh `_validateEndDate` dengan pesan `"Tanggal selesai tidak boleh lebih awal dari tanggal mulai!"`.
   - **Mengapa Memilih Jenis Input atau Papan Ketik (`TextInputType`) Saja Belum Cukup:**
     - `keyboardType` (seperti `TextInputType.url`) hanya memberi petunjuk tata letak tombol yang nyaman pada papan ketik virtual ponsel; pengguna tetap dapat mengetik teks acak, menempelkan (*copy-paste*) string rusak dari clipboard, atau mengetik bebas melalui papan ketik fisik di browser Chrome/desktop.
     - Jenis input/keyboard tidak mencegah pengguna menekan tombol **Simpan** saat kolom wajib masih kosong atau hanya berisi spasi.
     - Jenis input per-field tidak bisa menegakkan aturan bisnis lintas-field (seperti memastikan `ended_at >= started_at`), panjang minimal/maksimal bermakna setelah `.trim()`, ataupun validitas struktur URI (`scheme` + `host`). Oleh karena itu, validasi eksplisit melalui `validator` dan `FormState.validate()` tetap wajib diterapkan.

---

### AI Disclosure (Tugas 8)

Pengerjaan Individual Assignment 8 ini memanfaatkan generative AI sebagai asisten pemrograman (*pair programming*) dengan transparansi proses, log/strategi *prompting*, serta evaluasi kritis berikut:

- **Tools yang Digunakan:** Gemini (Antigravity Assistant).
- **Log & Strategi Prompting:**
  1. **Penyelarasan dengan Model Portofolio Django:** Menyampaikan spesifikasi PDF *Individual Assignment 8* agar asisten menyelaraskan halaman formulir baru dengan model `Experience` yang sudah dibangun pada portofolio web Django (`myportofolio/main/models.py`), mencakup field `title`, `category`, `description`, `thumbnail`, `started_at`, `ended_at`, dan `is_ongoing`.
  2. **Perancangan Arsitektur Navigasi & Validasi Modular:** Meminta pembuatan `lib/screens/experience_form.dart` lengkap dengan `showDatePicker()`, `SwitchListTile`, validasi batas panjang/spasi/URL/urutan tanggal, pembaruan `LeftDrawer`, serta refaktorisasi `ItemHomepage` menggunakan `destinationBuilder` agar navigasi kartu bersih tanpa percabangan string berulang.
  3. **Pengujian Menyeluruh Lintas Resolusi:** Meminta ekspansi `test/widget_test.dart` untuk memverifikasi navigasi kartu & drawer, penolakan seluruh kasus input tidak valid, urutan tanggal terbalik, dialog ringkasan, dan responsivitas pada lebar layar ponsel (`360x800`).
- **Bagian Spesifik yang Dibantu:**
  1. Implementasi `ExperienceFormPage` di `lib/screens/experience_form.dart` termasuk `TextEditingController`, `FormField<DateTime>` dengan `showDatePicker()`, validasi URL/tanggal, tombol `Reset` & `Simpan`, serta `AlertDialog` ringkasan.
  2. Integrasi kartu **Tambah Pengalaman** di `lib/screens/menu.dart`, refaktorisasi `ItemCard` di `lib/widgets/project_card.dart`, dan penambahan opsi **Add Experience** di `lib/widgets/left_drawer.dart`.
  3. Penyusunan skenario pengujian widget baru di `test/widget_test.dart` serta draf jawaban reflektif `### Tugas 8` dan pembaruan `README.md`.
- **Analisis Kritis Keterbatasan AI & Perbaikan Manual yang Dilakukan:**
  1. **Deteksi *Overflow* Horizontal (`57 px`) pada `Row` Pemilih Tanggal di Layar Ponsel (`360x800`):** Pada draf awal `ExperienceFormPage`, `Row` di dalam `InputDecorator` untuk field *Tanggal Selesai* langsung menaruh `Text('Pilih tanggal selesai')` sejajar dengan ikon kalender tanpa pembungkus `Expanded`, sehingga memicu `RenderFlex overflowed by 57 pixels on the right` saat diuji pada viewport `360x800`. Masalah ini diperbaiki dengan membungkus `Text` di dalam `Expanded` dengan `TextOverflow.ellipsis` pada kedua field tanggal.
  2. **Penyesuaian Tata Letak Kisi 4 Kartu (`2x2`) terhadap `Overflow` dan `SnackBar`:** Ketika jumlah kartu aksi bertambah dari 3 menjadi 4, kisi 2×2 vertikal awal (`childAspectRatio: 1.65`) sempat mengalami *overflow* `10 px` pada layar `360x800` dan membuat kartu baris kedua (`Logout`) tertutup oleh floating `SnackBar` pada viewport `800x600`. Masalah ini diselesaikan dengan mengubah tata letak internal `ItemCard` menjadi horizontal (`Row` dengan `Icon` + `Expanded(Column)`), menyetel `childAspectRatio: 2.15`, dan merapikan jarak vertikal sehingga keempat kartu tampil simetris tanpa *overflow* maupun tumpang-tindih `SnackBar`.
  3. **Verifikasi Mandiri Pengujian & Analisis Statis:** Memastikan seluruh kode bebas `TODO`, menjalankan `flutter analyze` hingga bersih (`No issues found!`), dan memverifikasi seluruh 6 skenario `flutter test` lulus 100% sebelum meng-commit secara bertahap dengan *Conventional Commits*.
