import 'package:flutter/material.dart';
import 'pages.dart';
import 'styles.dart';

class EventoraApp extends StatelessWidget {
  const EventoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventora',
      debugShowCheckedModeBanner: false,
      theme: EventoraStyles.theme,
      home: const EventoraShell(),
    );
  }
}
