import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/contact_repository.dart';
import 'bloc/contact_bloc.dart';
import 'bloc/contact_event.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactRepository(),
      child: BlocProvider(
        create: (context) => ContactBloc(
          repository: RepositoryProvider.of<ContactRepository>(context),
        )..add(LoadContacts()), 
        child: MaterialApp(
          title: 'Contact Manager',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(), // 
          home: const HomeScreen(),
        ),
      ),
    );
  }
}