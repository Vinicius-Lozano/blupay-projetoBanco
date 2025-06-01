import 'package:flutter/material.dart';
import '../models/transferencia_args.dart';

class TransferenciaScreen extends StatefulWidget {
  final TransferenciaArgs args;
  TransferenciaScreen({required this.args});

  @override
  State<TransferenciaScreen> createState() => _TransferenciaScreenState();
}

class _TransferenciaScreenState extends State<TransferenciaScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late String _contaDestino;
  late double _valor;

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _contaDestino = widget.args.contaDestino;
    _valor = widget.args.valor;

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _opacityAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.blue.shade900),
      filled: true,
      fillColor: Colors.blue.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text('Transferência'),
      ),
      body: FadeTransition(
        opacity: _opacityAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _contaDestino,
                    decoration: _inputDecoration('Conta Destino'),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Informe a conta destino' : null,
                    onSaved: (v) => _contaDestino = v!,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: _valor.toString(),
                    decoration: _inputDecoration('Valor'),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Informe o valor';
                      final valor = double.tryParse(v);
                      if (valor == null || valor <= 0) return 'Valor inválido';
                      return null;
                    },
                    onSaved: (v) => _valor = double.parse(v!),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue.shade900,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Confirmar Transferência',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              backgroundColor: Colors.blue.shade50,
                              title: Text(
                                'Sucesso',
                                style: TextStyle(color: Colors.blue.shade900),
                              ),
                              content: Text(
                                'Transferência de R\$ ${_valor.toStringAsFixed(2)} para a conta $_contaDestino realizada!',
                                style: TextStyle(color: Colors.blue.shade900),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: Colors.blue.shade900),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context); 
                                  },
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

