import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lps_app/pages/pagina_login.dart';
import 'CustomShape.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class PaginaRegistro extends StatefulWidget {
  @override
  _PaginaRegistroState createState() => _PaginaRegistroState();
}

class _PaginaRegistroState extends State<PaginaRegistro> {
  String _email;
  String _senha;
  String _nome;

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerSenhaConfirma = TextEditingController();
  TextEditingController _controllerNome = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        _email = _controllerEmail.text;
        _senha = _controllerSenha.text;
        _nome = _controllerNome.text;
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _senha);
        print('User created: ${user.user.uid}');

        final role = {
          "role": "Aguardando permissão",
          "email": "$_email",
          "nome": "$_nome"
        };

        db.collection("users").doc(user.user.uid).set(role);

        showDialog(
            context: context,
            builder: (context) {
              return creationSuccess();
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          showDialog(
              context: context,
              builder: (context) {
                return _falha();
              });
        }
        if (e.code == 'invalid-email') {
          showDialog(
              context: context,
              builder: (context) {
                return _falha2();
              });
        }
        if (e.code == 'weak-password') {
          showDialog(
              context: context,
              builder: (context) {
                return _falha3();
              });
        } else {
          print(e);
        }
      }
    }
  }

  _falha() {
    return AlertDialog(
      title: Text("Erro!"),
      content: Text("Este e-mail já está sendo utilizado!"),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok")),
      ],
    );
  }

  _falha2() {
    return AlertDialog(
      title: Text("Erro!"),
      content: Text("E-mail mal formatado!"),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok")),
      ],
    );
  }

  _falha3() {
    return AlertDialog(
      title: Text("Erro!"),
      content: Text("Senha deve ter pelo menos 6 dígitos!"),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok")),
      ],
    );
  }

  creationSuccess() {
    return AlertDialog(
      title: Text("Conta criada"),
      content: Text("Sua conta foi criada com sucesso!"),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaginaLogin()),
              );
            },
            child: Text("Ok")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 143, 105),
          toolbarHeight: 150,
          elevation: 0.3,
          flexibleSpace: ClipPath(
            clipper: Customshape(),
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              color: Color.fromARGB(255, 252, 127, 89),
              child: Center(
                  child: Text(
                "inVentory",
                style: GoogleFonts.prata(
                    fontSize: 35, color: Color.fromARGB(255, 255, 206, 190)),
              )),
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
                Color.fromARGB(255, 242, 232, 237),
              ])),
          padding: EdgeInsets.all(16.0),
          child: new Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                SizedBox(
                  width: 128,
                  height: 128,
                  child: Image.asset('assets/images/welcome.png'),
                ),
                new TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "E-mail", hintText: "Digite o e-mail"),
                  controller: _controllerEmail,
                  validator: (value) =>
                      value.isEmpty ? "Nenhum e-mail fornecido" : null,
                ),
                SizedBox(
                  height: 10,
                ),
                new TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Senha", hintText: "Crie uma senha"),
                  obscureText: true,
                  controller: _controllerSenha,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Digite a senha ";
                    }
                    if (_controllerSenhaConfirma.text !=
                        _controllerSenha.text) {
                      return "As senhas devem ser iguais";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                new TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Confirmar senha",
                      hintText: "Digite a senha novamente"),
                  obscureText: true,
                  controller: _controllerSenhaConfirma,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Digite a senha ";
                    }
                    if (_controllerSenhaConfirma.text !=
                        _controllerSenha.text) {
                      return "As senhas devem ser iguais";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                new TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Nome",
                      hintText: "Digite seu nome"
                  ),
                  controller: _controllerNome,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Digite a senha ";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.3, 1],
                      colors: [
                        Color.fromARGB(255, 240, 81, 17),
                        Color.fromARGB(255, 237, 212, 134),
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: SizedBox.expand(
                    child: CupertinoButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Cadastrar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              child: SizedBox(
                                child: Image.asset('assets/images/check.png'),
                                height: 28,
                                width: 28,
                              ),
                            )
                          ],
                        ),
                        onPressed: validateAndSubmit),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
