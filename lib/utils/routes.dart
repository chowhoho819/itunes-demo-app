import 'package:go_router/go_router.dart';
import 'package:itune_test_app/theme/page_transition.dart';

import '../page/home.dart';

GoRouter get route {
  return GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: "/",
        pageBuilder: (context, state) {
          return pageTransaction(HomePage());
        },
      ),
    ],
  );
}
