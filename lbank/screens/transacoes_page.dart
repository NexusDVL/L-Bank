import 'package:flutter/material.dart';

class TransacoesPage extends StatefulWidget {
  @override
  _TransacoesPageState createState() => _TransacoesPageState();
}

class _TransacoesPageState extends State<TransacoesPage> {
  final _formKey = GlobalKey<FormState>();
  final _quantiaController = TextEditingController();
  final _destinatarioController = TextEditingController();
  final _senhaController = TextEditingController();
  String _opcaoPagamento = 'CREDITO';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transações'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[900]!, Colors.green[400]!],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 10), // Espaço adicionado acima da imagem
                Image.asset(
                  'assets/images/logo_login.png',
                  width: 400,
                  height: 400,
                ),
                SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 0.25,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: _quantiaController,
                              decoration: InputDecoration(
                                labelText: 'Quantia a ser transferida',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira a quantia a ser transferida.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              value: _opcaoPagamento,
                              decoration: InputDecoration(
                                labelText: 'Opção de pagamento',
                                border: OutlineInputBorder(),
                              ),
                              items: ['CREDITO', 'DEBITO', 'PIX'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _opcaoPagamento = newValue!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, selecione a opção de pagamento.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _destinatarioController,
                              decoration: InputDecoration(
                                labelText: 'Para quem será transferido (CPF, número de celular ou e-mail)',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira os dados do destinatário.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _senhaController,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                border: OutlineInputBorder(),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira sua senha.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Transferência realizada com sucesso')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Por favor, preencha todos os campos corretamente.')),
                                  );
                                }
                              },
                              child: Text('Transferir'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
