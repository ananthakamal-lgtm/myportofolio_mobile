import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir untuk menambahkan entri pengalaman (*Experience*) portofolio.
///
/// Field dan aturan validasi diselaraskan dengan model `Experience` pada
/// portofolio web Django (`title`, `category`, `description`, `thumbnail`,
/// `started_at`, `ended_at`, dan status `is_ongoing`).
class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  static const String _defaultCategory = 'Full-Time';
  static const List<String> _categories = [
    'Full-Time',
    'Part-Time',
    'Internship',
    'Research',
    'Volunteer',
    'Freelance',
  ];
  static const List<String> _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _thumbnailController = TextEditingController();

  String _category = _defaultCategory;
  DateTime _startedAt = _todayDate();
  DateTime? _endedAt;
  bool _isOngoing = true;

  static DateTime _todayDate() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = _monthNames[date.month - 1];
    return '$day $month ${date.year}';
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData prefixIcon,
    String? hintText,
    String? helperText,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      prefixIcon: Icon(prefixIcon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }

  String? _validateTitle(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'Judul pengalaman tidak boleh kosong!';
    }
    if (trimmed.length < 3) {
      return 'Judul pengalaman minimal 3 karakter!';
    }
    if (trimmed.length > 255) {
      return 'Judul pengalaman maksimal 255 karakter!';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'Deskripsi pengalaman tidak boleh kosong!';
    }
    if (trimmed.length < 10) {
      return 'Deskripsi pengalaman minimal 10 karakter!';
    }
    return null;
  }

  String? _validateThumbnailUrl(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return null;
    }
    if (trimmed.length > 200) {
      return 'URL thumbnail maksimal 200 karakter!';
    }
    final uri = Uri.tryParse(trimmed);
    final isValidScheme =
        uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
    final hasValidHost =
        uri != null && uri.host.isNotEmpty && uri.host.contains('.');
    if (!isValidScheme || !hasValidHost) {
      return 'Masukkan URL valid yang diawali http:// atau https://!';
    }
    return null;
  }

  String? _validateEndDate(DateTime? value) {
    if (_isOngoing) {
      return null;
    }
    if (value == null) {
      return 'Tanggal selesai wajib dipilih jika pengalaman sudah berakhir!';
    }
    if (value.isBefore(_startedAt)) {
      return 'Tanggal selesai tidak boleh lebih awal dari tanggal mulai!';
    }
    return null;
  }

  Future<void> _pickStartDate(FormFieldState<DateTime> fieldState) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startedAt,
      firstDate: DateTime(2015),
      lastDate: DateTime(2035),
      helpText: 'Pilih Tanggal Mulai',
    );
    if (picked == null) return;
    setState(() {
      _startedAt = DateTime(picked.year, picked.month, picked.day);
    });
    fieldState.didChange(_startedAt);
  }

  Future<void> _pickEndDate(FormFieldState<DateTime?> fieldState) async {
    final initial = _endedAt ?? _startedAt;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2015),
      lastDate: DateTime(2035),
      helpText: 'Pilih Tanggal Selesai',
    );
    if (picked == null) return;
    final normalized = DateTime(picked.year, picked.month, picked.day);
    setState(() {
      _endedAt = normalized;
    });
    fieldState.didChange(normalized);
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _descriptionController.clear();
    _thumbnailController.clear();
    setState(() {
      _category = _defaultCategory;
      _startedAt = _todayDate();
      _endedAt = null;
      _isOngoing = true;
    });
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final thumbnail = _thumbnailController.text.trim();
    final periodText = _isOngoing
        ? '${_formatDate(_startedAt)} - Sekarang (Masih berlangsung)'
        : '${_formatDate(_startedAt)} - ${_formatDate(_endedAt!)}';

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Pengalaman berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Judul: $title'),
                const SizedBox(height: 6),
                Text('Kategori: $_category'),
                const SizedBox(height: 6),
                Text('Periode: $periodText'),
                const SizedBox(height: 6),
                Text('Deskripsi: $description'),
                const SizedBox(height: 6),
                Text('Thumbnail: ${thumbnail.isEmpty ? '-' : thumbnail}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _resetForm();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Pengalaman',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // === Header Singkat Formulir ===
                    Card(
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: colorScheme.primary.withValues(
                                alpha: 0.12,
                              ),
                              child: Icon(
                                Icons.work_history_rounded,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Catat Pengalaman Baru',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Lengkapi rincian posisi, periode, dan deskripsi pengalamanmu.',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    // === Judul / Posisi Pengalaman ===
                    TextFormField(
                      controller: _titleController,
                      maxLength: 255,
                      textInputAction: TextInputAction.next,
                      decoration: _buildInputDecoration(
                        labelText: 'Judul Pengalaman',
                        hintText: 'Contoh: Software Engineer Intern',
                        prefixIcon: Icons.badge_outlined,
                      ),
                      validator: _validateTitle,
                    ),

                    const SizedBox(height: 12.0),

                    // === Kategori Pengalaman ===
                    DropdownButtonFormField<String>(
                      initialValue: _category,
                      decoration: _buildInputDecoration(
                        labelText: 'Kategori Pengalaman',
                        prefixIcon: Icons.category_outlined,
                      ),
                      items: _categories
                          .map(
                            (category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                      onChanged: (String? newValue) {
                        if (newValue == null) return;
                        setState(() {
                          _category = newValue;
                        });
                      },
                    ),

                    const SizedBox(height: 16.0),

                    // === Deskripsi Pengalaman ===
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: _buildInputDecoration(
                        labelText: 'Deskripsi Pengalaman',
                        hintText: 'Ceritakan peran, tanggung jawab, dan pencapaian utama...',
                        prefixIcon: Icons.description_outlined,
                      ),
                      validator: _validateDescription,
                    ),

                    const SizedBox(height: 16.0),

                    // === Tanggal Mulai (showDatePicker) ===
                    FormField<DateTime>(
                      initialValue: _startedAt,
                      builder: (FormFieldState<DateTime> fieldState) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () => _pickStartDate(fieldState),
                          child: InputDecorator(
                            decoration: _buildInputDecoration(
                              labelText: 'Tanggal Mulai',
                              prefixIcon: Icons.calendar_today_outlined,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _formatDate(_startedAt),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.edit_calendar_outlined,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8.0),

                    // === Status Masih Berlangsung ===
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),
                      child: SwitchListTile(
                        title: const Text(
                          'Masih berlangsung',
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: const Text(
                          'Aktifkan jika pengalaman belum berakhir',
                          style: TextStyle(fontSize: 12),
                        ),
                        value: _isOngoing,
                        onChanged: (bool value) {
                          setState(() {
                            _isOngoing = value;
                            if (value) {
                              _endedAt = null;
                            }
                          });
                        },
                      ),
                    ),

                    // === Tanggal Selesai (aktif bila tidak sedang berlangsung) ===
                    if (!_isOngoing) ...[
                      const SizedBox(height: 12.0),
                      FormField<DateTime?>(
                        key: ValueKey(_endedAt),
                        initialValue: _endedAt,
                        validator: _validateEndDate,
                        builder: (FormFieldState<DateTime?> fieldState) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () => _pickEndDate(fieldState),
                            child: InputDecorator(
                              decoration: _buildInputDecoration(
                                labelText: 'Tanggal Selesai',
                                prefixIcon: Icons.event_available_outlined,
                              ).copyWith(errorText: fieldState.errorText),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _endedAt != null
                                          ? _formatDate(_endedAt!)
                                          : 'Pilih tanggal selesai',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: _endedAt != null
                                            ? null
                                            : colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.edit_calendar_outlined,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],

                    const SizedBox(height: 16.0),

                    // === URL Thumbnail (opsional, validasi format URL bila diisi) ===
                    TextFormField(
                      controller: _thumbnailController,
                      keyboardType: TextInputType.url,
                      decoration: _buildInputDecoration(
                        labelText: 'URL Thumbnail (opsional)',
                        hintText: 'https://example.com/gambar.png',
                        helperText: 'Kosongkan jika tidak ada, atau gunakan URL http/https yang valid.',
                        prefixIcon: Icons.link_rounded,
                      ),
                      validator: _validateThumbnailUrl,
                    ),

                    const SizedBox(height: 24.0),

                    // === Tombol Reset & Simpan ===
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _resetForm,
                            icon: const Icon(Icons.refresh_rounded),
                            label: const Text('Reset'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: _handleSave,
                            icon: const Icon(Icons.save_outlined),
                            label: const Text('Simpan'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
