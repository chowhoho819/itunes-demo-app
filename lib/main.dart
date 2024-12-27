import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:itune_test_app/bloc/home_bloc/bloc.dart';
import 'package:itune_test_app/utils/routes.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'utils/bloc_observer.dart';
import 'utils/dio_client.dart';

// Global Accessibilty for talker logger
final talker = Talker();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  DioClient().create();
  runApp(const ItuneApp());
}

class ItuneApp extends StatefulWidget {
  const ItuneApp({super.key});

  @override
  State<ItuneApp> createState() => _ItuneAppState();
}

class _ItuneAppState extends State<ItuneApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => HomeBloc()..add(HomeInitialEvent()))],
      child: MaterialApp.router(
        routerConfig: route,
      ),
    );
  }
}
