import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/data/user/user_api.dart';
import 'package:flutter_architecture_sample/data/user/user_db.dart';
import 'package:flutter_architecture_sample/data/user/user_repository.dart';
import 'package:flutter_architecture_sample/ui/deeplink/deep_link_bloc.dart';
import 'package:flutter_architecture_sample/ui/router.dart';
import 'package:flutter_architecture_sample/ui/user/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lightweight_bloc/lightweight_bloc.dart';

void main() {
  setupDI();
  runApp(MyApp());
}

void setupDI() {
  GetIt.I.registerLazySingleton(() => UserApiProvider());
  GetIt.I.registerLazySingleton(() => UserDatabaseProvider());
  GetIt.I.registerLazySingleton(() => UserRepository(
      GetIt.I.get<UserApiProvider>(), GetIt.I.get<UserDatabaseProvider>()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeepLinkBloc>(
      builder: (context) => DeepLinkBloc(),
      child: BlocProvider<UserBloc>(
        builder: (context) => UserBloc(GetIt.I.get<UserRepository>()),
        child: MaterialApp(
          navigatorKey: Router.navigatorKey,
          onGenerateRoute: Router.generateRoute,
          initialRoute: Router.initialRoute,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
        ),
      ),
    );
  }
}