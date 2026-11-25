import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

/// Titik masuk utama aplikasi Flutter MyPortfolio Mobile.
void main() {
  runApp(MyApp(apiClient: ApiClient()));
}

/// Root widget aplikasi yang menyisipkan [ApiClient] dan [AuthState]
/// melalui [MultiProvider] serta mengonfigurasi tema Material 3.
class MyApp extends StatelessWidget {
  MyApp({ApiClient? apiClient, super.key})
    : apiClient = apiClient ?? ApiClient();

  final ApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1E3A8A),
      secondary: const Color(0xFFD95D39),
    );

    return MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: apiClient),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState(apiClient)),
      ],
      child: MaterialApp(
        title: 'MyPortfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: colorScheme,
          scaffoldBackgroundColor: const Color(0xFFFAF6F0),
          cardTheme: const CardThemeData(
            color: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
