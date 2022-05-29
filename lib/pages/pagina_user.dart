import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaUser extends StatefulWidget {
  final String idContato;
  PaginaUser({Key key, @required this.idContato}) : super(key: key);

  @override
  _PaginaUserState createState() => _PaginaUserState();
}

class _PaginaUserState extends State<PaginaUser> {
  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    bool value1 = false;
    bool value2 = true;


    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.idContato).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();

          return Scaffold(
            appBar: AppBar(
              title: Text(data['nome']),
              centerTitle: true,
            ),
            body: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: 150.0, height: 150.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/nopic.png")
                        )
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Nome",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "${data['nome']}",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(1.0),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "E-mail",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "${data['email']}",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(1.0),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Função",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "${data['role']}",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(5.0),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Permissões",
                        style: TextStyle(fontSize: 15),
                      ),
                      Container(
                        child: Expanded(
                          child: Column(
                            children: [
                              CheckboxListTile(
                                title: Text("Funcionário"),
                                value: value1,
                                onChanged: (newValue) {
                                  setState(() {
                                    value1 = newValue;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity.leading,
                              ),
                              CheckboxListTile(
                                title: Text("Administrador"),
                                value: value2,
                                onChanged: (newValue) {
                                  setState(() {
                                    value2 = value2;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity.leading,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),

              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
