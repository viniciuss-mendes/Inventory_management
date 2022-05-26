import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pagina_estoque.dart';
import 'pagina_funcionarios.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaginaPrincipal extends StatefulWidget {
  final String loggedUserId;
  PaginaPrincipal({Key key, @required this.loggedUserId}) : super(key: key);

  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {

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

    CollectionReference users = FirebaseFirestore.instance.collection("users");
    print(widget.loggedUserId);
    print(users.doc(widget.loggedUserId));

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.loggedUserId).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snap) {
          if (snap.hasError) {
            return Text("Something went wrong");
          }

          if (snap.hasData && !snap.data.exists) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Home"),
                  centerTitle: true,
                ),
                body: new Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(Icons.warning),
                      Text(
                        "Você não tem permissão para visualizar essa página",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                    ],
                  )
                )
            );
          }

          if (snap.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snap.data.data();
            print(data['role']);
            return Scaffold(
              appBar: AppBar(
                title: Text("Home"),
                centerTitle: true,
              ),
                body: new Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildPageButtons(data),
                  ),
                )
            );
          }
          return Center(child: CircularProgressIndicator());
        }
    );
  }

  List<Widget> buildPageButtons(Map<String, dynamic> data){
    if( data["role"]== "admin"){
      return <Widget>[
        botaoGerenciarEstoque(),
        botaoGerenciarFuncionarios(),
      ];
    }else{
      if( data['role']== 'funcionario'){
        return <Widget>[
          botaoGerenciarEstoque(),
        ];
      }else{
        return <Widget>[
          Column(
            children: [
              Icon(Icons.warning),
              Text(
                "Você não tem permissão para visualizar essa página",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),
              ),
            ],
          )
        ];
      }
    }
  }

  Widget botaoGerenciarEstoque(){
    return ElevatedButton(
      child: Text(
        "Gerenciar Estoque",
        style: TextStyle(
            fontSize: 20,
            color: Colors.white
        ),
      ),
      onPressed: movePaginaEstoque,
    );
  }

  Widget botaoGerenciarFuncionarios(){
    return ElevatedButton(
      child: Text(
        "Gerenciar Funcionários",
        style: TextStyle(
            fontSize: 20,
            color: Colors.white
        ),
      ),
      onPressed: movePaginaFuncionarios,
    );
  }


}
