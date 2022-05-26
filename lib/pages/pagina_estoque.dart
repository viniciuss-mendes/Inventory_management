import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaginaEstoque extends StatefulWidget {
  @override
  _PaginaEstoqueState createState() => _PaginaEstoqueState();
}

class _PaginaEstoqueState extends State<PaginaEstoque> {

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore db = FirebaseFirestore.instance;
    var snap = db.collection("estoque")
        .where('excluido', isEqualTo: false)
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: Text("Estoque"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
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
