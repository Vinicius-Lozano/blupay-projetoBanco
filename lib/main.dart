import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/principal_screen.dart';
import 'screens/cotacao_screen.dart';
import 'screens/transferencia_screen.dart';
import 'models/transferencia_args.dart';
import 'screens/cadastro_screen.dart';

void main() {
  runApp(BancoDigitalApp());
}

class BancoDigitalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco Digital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue.shade900,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/principal': (context) => PrincipalScreen(),
        '/cotacao': (context) => CotacaoScreen(),
        '/cadastro': (context) => CadastroScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/transferencia') {
          final args = settings.arguments;
          if (args is TransferenciaArgs) {
            return MaterialPageRoute(
              builder: (context) => TransferenciaScreen(args: args),
            );
          }
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(child: Text('Erro: argumentos inválidos')),
            ),
          );
        }
        assert(false, 'Rota desconhecida: ${settings.name}');
        return null;
      },
    );
  }
}
