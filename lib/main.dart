import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Films",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// Antes de iniciar a aplicação, substitua a KEY API em utils/http_service.dart

// Código/APP em melhoria, primeiro projeto criado em Flutter, 
// buscando aprender mais sobre suas ferramentas e funcionalidades,
// projeto foi criado pra participação do processo seletivo na Evo System.
