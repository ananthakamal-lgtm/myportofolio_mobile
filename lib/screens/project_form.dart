import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

/// Halaman formulir untuk menambahkan entri proyek baru ke backend DRF.
class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _techStackController = TextEditingController();
  final _projectUrlController = TextEditingController();
  final _projectImageUrlController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _techStackController.dispose();
    _projectUrlController.dispose();
    _projectImageUrlController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    String? hintText,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }

  String? _validateRequired(String? value, String emptyMessage) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage;
    }
    return null;
  }

  String? _validateUrl(String? value, {required bool isRequired}) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return isRequired ? 'URL proyek tidak boleh kosong!' : null;
    }
    final uri = Uri.tryParse(trimmed);
    final isValid =
        uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
    if (!isValid) {
      return 'Masukkan URL valid yang diawali http:// atau https://!';
    }
    return null;
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _descriptionController.clear();
    _techStackController.clear();
    _projectUrlController.clear();
    _projectImageUrlController.clear();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final loggedIn = await ensureLoggedIn(context);
    if (!loggedIn || !mounted) return;

    final authState = context.read<AuthState>();
    final apiClient = context.read<ApiClient>();
    final token = authState.token;
    if (token == null) return;

    final newProject = Project(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      techStack: _techStackController.text.trim(),
      projectUrl: _projectUrlController.text.trim(),
      projectImageUrl: _projectImageUrlController.text.trim(),
    );

    setState(() {
      _isSubmitting = true;
    });

    try {
      final created = await apiClient.createProject(newProject, token: token);
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
      });

      await showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Proyek berhasil ditambahkan!'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Title: ${created.title}'),
                  Text('Description: ${created.description}'),
                  Text('Tech Stack: ${created.techStack}'),
                  Text('Project URL: ${created.projectUrl}'),
                  if (created.projectImageUrl.isNotEmpty)
                    Text('Image URL: ${created.projectImageUrl}'),
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
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        await authState.logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Sesi berakhir (401). Silakan login kembali.'),
            ),
          );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Gagal menyimpan proyek (HTTP ${e.statusCode}).'),
            ),
          );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Tidak dapat terhubung ke server.')),
        );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
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
                    // === Title ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _titleController,
                        decoration: _buildInputDecoration(
                          hintText: 'Title',
                          labelText: 'Title',
                        ),
                        validator: (value) => _validateRequired(
                          value,
                          'Title tidak boleh kosong!',
                        ),
                      ),
                    ),

                    // === Description ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _descriptionController,
                        maxLines: 5,
                        decoration: _buildInputDecoration(
                          hintText: 'Description',
                          labelText: 'Description',
                        ),
                        validator: (value) => _validateRequired(
                          value,
                          'Description tidak boleh kosong!',
                        ),
                      ),
                    ),

                    // === Tech Stack ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _techStackController,
                        decoration: _buildInputDecoration(
                          hintText: 'Contoh: Flutter, Django, PostgreSQL',
                          labelText: 'Tech Stack',
                        ),
                        validator: (value) => _validateRequired(
                          value,
                          'Tech Stack tidak boleh kosong!',
                        ),
                      ),
                    ),

                    // === Project URL ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _projectUrlController,
                        keyboardType: TextInputType.url,
                        decoration: _buildInputDecoration(
                          hintText: 'https://example.com/project',
                          labelText: 'Project URL',
                        ),
                        validator: (value) =>
                            _validateUrl(value, isRequired: true),
                      ),
                    ),

                    // === Project Image URL (Optional) ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _projectImageUrlController,
                        keyboardType: TextInputType.url,
                        decoration: _buildInputDecoration(
                          hintText: 'https://example.com/image.png (opsional)',
                          labelText: 'Project Image URL (Optional)',
                        ),
                        validator: (value) =>
                            _validateUrl(value, isRequired: false),
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
                          onPressed: _isSubmitting ? null : _submit,
                          child: _isSubmitting
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
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
