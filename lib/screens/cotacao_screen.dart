import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CotacaoScreen extends StatefulWidget {
  @override
  State<CotacaoScreen> createState() => _CotacaoScreenState();
}

class _CotacaoScreenState extends State<CotacaoScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic>? _cotacao;
  bool _loading = true;
  String? _erro;

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _opacityAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    _buscarCotacao();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _buscarCotacao() async {
    setState(() {
      _loading = true;
      _erro = null;
    });
    try {
      final url = Uri.parse('https://api.exchangerate-api.com/v4/latest/USD');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _cotacao = data['rates'];
          _loading = false;
        });
      } else {
        setState(() {
          _erro = 'Erro ao buscar cotação.';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _erro = 'Erro: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text('Cotação do Dólar'),
      ),
      body: FadeTransition(
        opacity: _opacityAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: _loading
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : _erro != null
                    ? Center(
                        child: Text(
                          _erro!,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView(
                        children: _cotacao!.entries.map<Widget>((entry) {
                          return Card(
                            color: Colors.blue.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              title: Text(
                                '${entry.key}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: Text(
                                '${(entry.value as num).toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
          ),
        ),
      ),
    );
  }
}


