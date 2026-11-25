import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_detail_screen.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

ApiClient _createMockApiClient() {
  final projects = <Map<String, dynamic>>[
    {
      'id': '11111111-1111-1111-1111-111111111111',
      'title': 'Portfolio Backend',
      'description': 'REST API built with Django REST Framework.',
      'tech_stack': 'Django, DRF, PostgreSQL',
      'project_url': 'https://example.com/portfolio',
      'project_image_url': '',
    },
  ];

  final mockHttp = MockClient((request) async {
    if (request.method == 'GET' && request.url.path == '/api/v1/projects/') {
      return http.Response(jsonEncode(projects), 200);
    }
    if (request.method == 'POST' && request.url.path == '/api/v1/auth/token/') {
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      if (body['username'] == 'admin' && body['password'] == 'secret') {
        return http.Response(jsonEncode({'token': 'mock-token-123'}), 200);
      }
      return http.Response('{"non_field_errors":["Invalid"]}', 400);
    }
    if (request.method == 'POST' && request.url.path == '/api/v1/projects/') {
      if (request.headers['Authorization'] != 'Token mock-token-123') {
        return http.Response('{"detail":"Unauthorized"}', 401);
      }
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      final created = <String, dynamic>{
        'id': '22222222-2222-2222-2222-222222222222',
        ...body,
      };
      projects.add(created);
      return http.Response(jsonEncode(created), 201);
    }
    if (request.method == 'POST' &&
        request.url.path == '/api/v1/auth/logout/') {
      return http.Response('', 204);
    }
    return http.Response('Not Found', 404);
  });

  return ApiClient(client: mockHttp, baseUrl: 'http://localhost:8000');
}

void main() {
  testWidgets('MyHomePage renders owner InfoCards and 4 ItemCards', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp(apiClient: _createMockApiClient()));

    expect(tester.widget(find.byType(MyHomePage)), isA<StatelessWidget>());
    expect(find.byType(InfoCard), findsNWidgets(3));
    expect(find.text('2506656425'), findsOneWidget);
    expect(find.text('Anantha Kamal Eirian'), findsOneWidget);
    expect(find.text('PBP D'), findsOneWidget);
    expect(find.byType(ItemCard), findsNWidgets(4));
  });

  testWidgets(
    'Lihat Proyek fetches public projects and opens ProjectDetailScreen',
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(apiClient: _createMockApiClient()));

      await tester.tap(find.text('Lihat Proyek'));
      await tester.pumpAndSettle();

      expect(find.byType(ProjectListScreen), findsOneWidget);
      expect(find.text('Portfolio Backend'), findsOneWidget);
      expect(find.text('Django, DRF, PostgreSQL'), findsOneWidget);

      await tester.tap(find.text('Portfolio Backend'));
      await tester.pumpAndSettle();

      expect(find.byType(ProjectDetailScreen), findsOneWidget);
      expect(
        find.text('REST API built with Django REST Framework.'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Route guard requires login before Tambah Proyek and submits to API',
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(apiClient: _createMockApiClient()));

      // Tapping Tambah Proyek while logged out opens LoginScreen first.
      await tester.tap(find.text('Tambah Proyek'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);

      // Login with valid credentials.
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'admin',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'secret',
      );
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      // After login, ProjectFormPage is opened automatically.
      expect(find.byType(ProjectFormPage), findsOneWidget);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'),
        'Flutter Mobile App',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Description'),
        'Integrated with DRF token auth.',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Tech Stack'),
        'Flutter, Dart',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Project URL'),
        'https://example.com/flutter',
      );

      // Wait for the 3-second navigation SnackBar to auto-dismiss before tapping Save.
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Save'));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
      expect(find.text('Title: Flutter Mobile App'), findsOneWidget);
    },
  );

  testWidgets('LeftDrawer navigates to ExperienceFormPage and back Home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp(apiClient: _createMockApiClient()));

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);

    await tester.tap(find.text('Add Experience'));
    await tester.pumpAndSettle();
    expect(find.byType(ExperienceFormPage), findsOneWidget);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
  });
}
