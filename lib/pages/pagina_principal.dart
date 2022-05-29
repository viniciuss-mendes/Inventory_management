import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lps_app/pages/pagina_login.dart';
import 'pagina_estoque.dart';
import 'pagina_funcionarios.dart';
import 'pagina_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'CustomShape.dart';
import 'package:google_fonts/google_fonts.dart';

class PaginaPrincipal extends StatefulWidget {
  final String loggedUserId;
  PaginaPrincipal({Key key, @required this.loggedUserId}) : super(key: key);

  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  void movePaginaEstoque() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaginaEstoque()),
    );
  }

  void movePaginaFuncionarios() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaginaFuncionarios()),
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
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    )));
          }

          if (snap.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snap.data.data();
            print(data['role']);
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromARGB(255, 255, 143, 105),
                  toolbarHeight: 150,
                  elevation: 0.3,
                  flexibleSpace: ClipPath(
                    clipper: Customshape2(),
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(255, 252, 109, 66),
                      child: Center(
                          child: Text(
                        "Home",
                        style: GoogleFonts.prata(
                            fontSize: 35,
                            color: Color.fromARGB(255, 254, 203, 187)),
                      )),
                    ),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaginaLogin()),
                      );
                    },
                    child: Icon(
                      Icons.exit_to_app,
                      size: 26.0,
                    ),
                  ),
                ),
                body: new Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color.fromARGB(255, 255, 143, 105),
                        Color.fromARGB(255, 255, 205, 182),
                        Color.fromARGB(255, 245, 223, 211),
                      ])),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildPageButtons(data),
                  ),
                ));
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  List<Widget> buildPageButtons(Map<String, dynamic> data) {
    if (data["role"] == "Administrador") {
      return <Widget>[
        botaoGerenciarEstoque(),
        botaoGerenciarFuncionarios(),
      ];
    } else {
      if (data['role'] == 'Funcionário') {
        return <Widget>[
          botaoGerenciarEstoque(),
        ];
      } else {
        return <Widget>[
          Column(
            children: [
              Icon(Icons.warning),
              Text(
                "Você não tem permissão para visualizar essa página",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          )
        ];
      }
    }
  }

  Widget botaoGerenciarEstoque() {
    return GestureDetector(
        onTap: movePaginaEstoque,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
                child: Image.asset('assets/images/estoque.png'),
                borderRadius: const BorderRadius.all(Radius.circular(30)))));
  }

  Widget botaoGerenciarFuncionarios() {
    return GestureDetector(
        onTap: movePaginaFuncionarios,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
                child: Image.asset('assets/images/funcionarios.png'),
                borderRadius: const BorderRadius.all(Radius.circular(30)))));
  }
}
