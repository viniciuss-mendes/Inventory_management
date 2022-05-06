import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lps_app/pages/pagina_registro.dart';

class PaginaFuncionarios extends StatefulWidget {
  @override
  _PaginaFuncionariosState createState() => _PaginaFuncionariosState();
}

class _PaginaFuncionariosState extends State<PaginaFuncionarios> {

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore db = FirebaseFirestore.instance;
    var snap = db.collection("funcionarios")
        .where('excluido', isEqualTo: false)
        .snapshots();

    void movePaginaRegistrarFuncionario(){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaginaRegistro()
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Funcionários"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: movePaginaRegistrarFuncionario,
        ),
        body: StreamBuilder(
            stream: snap,
            builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot
                ){
              if(snapshot.hasError){
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }

              if(snapshot.data.docs.length == 0){
                return Center(child: Text('Nada por aqui ainda'));
              }

              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int i){
                  var item = snapshot.data.docs[i];
                  CollectionReference funcionarios = FirebaseFirestore.instance.collection('funcionarios');
                  return GestureDetector(
                    onTap: (){
                    },
                    child: Card(
                      child: Padding(padding: EdgeInsets.all(10.0),
                      ),
                    ),
                  );
                },
              );
            }
        )
    );
  }
}
