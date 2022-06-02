import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lps_app/pages/pagina_adicionar_produto.dart';

class PaginaEstoque extends StatefulWidget {
  @override
  _PaginaEstoqueState createState() => _PaginaEstoqueState();
}

class _PaginaEstoqueState extends State<PaginaEstoque> {

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore db = FirebaseFirestore.instance;
    var snap = db.collection("estoque")
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: Text("Estoque"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => pagina_adicionar_produto()
              ),
            );
          },
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
                  CollectionReference estoque = FirebaseFirestore.instance.collection('estoque');
                  return GestureDetector(
                    onTap: (){
                    },
                    child: Card(
                      child: Padding(padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Nome: ",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Setor: ",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Lote: ",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Quantidade: ",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Fabricação: ",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Validade: ",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(left: 12)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item['nome'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  item['setor'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  item['lote'].toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  item['quantidade'].toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  item['fabricacao'].toDate().toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  item['validade'].toDate().toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
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
