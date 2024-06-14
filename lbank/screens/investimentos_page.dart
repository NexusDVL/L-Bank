import 'package:flutter/material.dart';

class InvestimentosPage extends StatefulWidget {
  @override
  _InvestimentosPageState createState() => _InvestimentosPageState();
}

class _InvestimentosPageState extends State<InvestimentosPage> {
  Map<String, double> valores = {
    'CDI': 0.0,
    'LCA': 0.0,
    'Poupança': 0.0,
  };

  void _showInputDialog(String title, bool isAdicionar) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isAdicionar ? 'Adicionar Valor' : 'Retirar Valor'),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Digite o valor'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  double valor = double.tryParse(_controller.text) ?? 0.0;
                  if (isAdicionar) {
                    valores[title] = (valores[title] ?? 0) + valor;
                  } else {
                    valores[title] = (valores[title] ?? 0) - valor;
                    if (valores[title]! < 0) valores[title] = 0;
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Investimentos'),
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
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'images/logo_login.png',
                    width: 400, // conforme necessário
                    height: 400, // conforme necessário
                  ),
                  SizedBox(height: 0), // Espaço entre a imagem e o Container principal
                  FractionallySizedBox(
                    widthFactor: 0.35,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildInvestimentoCard('CDI', 'images/cdi_graph.png'),
                            SizedBox(height: 20),
                            _buildInvestimentoCard('LCA', 'images/lca_graph.png'),
                            SizedBox(height: 20),
                            _buildInvestimentoCard('Poupança', 'images/poupanca_graph.png'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInvestimentoCard(String title, String imagePath) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 100, // valor conforme necessário
              height: 100, //valor conforme necessário
            ),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Valor: R\$ ${valores[title]?.toStringAsFixed(2) ?? '0.00'}'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showInputDialog(title, true);
                  },
                  child: Text('Adicionar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showInputDialog(title, false);
                  },
                  child: Text('Retirar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
