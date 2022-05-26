import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaginaFuncionarios extends StatefulWidget {
  @override
  _PaginaFuncionariosState createState() => _PaginaFuncionariosState();
}

class _PaginaFuncionariosState extends State<PaginaFuncionarios> {

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore db = FirebaseFirestore.instance;
    var snap = db.collection("users")
        .where("role", whereIn: ["none", "funcionario"])
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: Text("Funcionários"),
          centerTitle: true,
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
                  CollectionReference users = FirebaseFirestore.instance.collection('users');
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
                                  "E-mail: ",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Função Atual: ",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(left: 12)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item['email'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  item['role'],
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
