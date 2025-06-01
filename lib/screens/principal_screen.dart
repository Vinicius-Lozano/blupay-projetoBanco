import 'package:flutter/material.dart';
import '../models/transferencia_args.dart';

class PrincipalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text('Principal'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logoney.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Bem-vindo ao Banco NeyPay!',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade900,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Ver Cotação', style: TextStyle(fontSize: 16)),
                onPressed: () {
                  Navigator.pushNamed(context, '/cotacao');
                },
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade900,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Fazer Transferência', style: TextStyle(fontSize: 16)),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/transferencia',
                    arguments: TransferenciaArgs(
                      contaDestino: '123456',
                      valor: 100.0,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

