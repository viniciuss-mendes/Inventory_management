import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pagina_estoque.dart';
import 'pagina_funcionarios.dart';

class PaginaPrincipal extends StatefulWidget {
  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {

  void checkAuth() async {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user != null) {
        print(user.uid);
      }
    });
  }

  void movePaginaEstoque(){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaginaEstoque()
      ),
    );
  }

  void movePaginaFuncionarios(){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaginaFuncionarios()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Contatos"),
          centerTitle: true,
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                child: Text(
                  "Gerenciar Estoque",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
                  onPressed: movePaginaEstoque,
              ),
              ElevatedButton(
                child: Text(
                  "Gerenciar Funcionários",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
                onPressed: movePaginaFuncionarios,
              )
            ],
          ),
        )
    );
  }
}
