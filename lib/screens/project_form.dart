import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir untuk menambahkan entri proyek portofolio baru.
class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  static const String _defaultCategory = 'Web Development';
  static const List<String> _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

  final _formKey = GlobalKey<FormState>();
  String _projectName = '';
  String _description = '';
  String _category = _defaultCategory;
  String _technologies = '';
  String _projectLink = '';

  InputDecoration _buildInputDecoration({
    required String labelText,
    String? hintText,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  String? _validateRequired(String? value, String emptyMessage) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage;
    }
    return null;
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _projectName = '';
      _description = '';
      _category = _defaultCategory;
      _technologies = '';
      _projectLink = '';
    });
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Proyek berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Nama Proyek: $_projectName'),
                Text('Deskripsi: $_description'),
                Text('Kategori: $_category'),
                Text('Teknologi: $_technologies'),
                Text('Tautan: $_projectLink'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(dialogContext);
                _resetForm();
              },
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
        title: const Text('Add Project Form'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // === Project Name ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: _buildInputDecoration(
                          hintText: 'Nama Proyek',
                          labelText: 'Nama Proyek',
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _projectName = value;
                          });
                        },
                        validator: (String? value) => _validateRequired(
                          value,
                          'Nama proyek tidak boleh kosong!',
                        ),
                      ),
                    ),

                    // === Description ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: _buildInputDecoration(
                          hintText: 'Deskripsi Proyek',
                          labelText: 'Deskripsi Proyek',
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _description = value;
                          });
                        },
                        validator: (String? value) => _validateRequired(
                          value,
                          'Deskripsi proyek tidak boleh kosong!',
                        ),
                      ),
                    ),

                    // === Category ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: _buildInputDecoration(
                          labelText: 'Kategori Proyek',
                        ),
                        initialValue: _category,
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
                    ),

                    // === Technologies ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: _buildInputDecoration(
                          hintText: 'Contoh: Flutter, Django, Figma',
                          labelText: 'Teknologi yang Digunakan',
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _technologies = value;
                          });
                        },
                      ),
                    ),

                    // === Project Link ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: _buildInputDecoration(
                          hintText: 'URL Proyek (opsional)',
                          labelText: 'Tautan Proyek',
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _projectLink = value;
                          });
                        },
                      ),
                    ),

                    // === Tombol Simpan ===
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              colorScheme.primary,
                            ),
                          ),
                          onPressed: _handleSave,
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
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
