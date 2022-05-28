import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lps_app/pages/pagina_registro.dart';
import 'pagina_principal.dart';
import 'CustomShape.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';

class PaginaLogin extends StatefulWidget {
  @override
  _PaginaLoginState createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  String _email;
  String _senha;

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
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
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _senha);
        print('User logged: ${user.user.uid}');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PaginaPrincipal(loggedUserId: user.user.uid)),
        );
      } catch (e) {
        if (e.code == 'user-not-found' || e.code == 'invalid-email') {
          showDialog(
              context: context,
              builder: (context) {
                return _falha();
              });
        } else {
          print(e);
        }
      }
    }
  }

  void movePaginaRegistrarFuncionario() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaginaRegistro()),
    );
  }

  _falha() {
    return AlertDialog(
      title: Text("Credenciais incorretas ou mal formatadas!"),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                Color.fromARGB(255, 250, 183, 153),
                Color.fromARGB(255, 245, 223, 211),
                Color.fromARGB(255, 251, 170, 215),
              ])),
          padding: EdgeInsets.all(20),
          child: new Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                SizedBox(
                  width: 128,
                  height: 128,
                  child: Image.asset('assets/images/logo1.png'),
                ),
                new TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Email:", hintText: "Digite o Email"),
                  controller: _controllerEmail,
                  validator: (value) =>
                      value.isEmpty ? "Nenhum email fornecido" : null,
                  onSaved: (value) => _email = value,
                ),
                new TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Senha:", hintText: "Digite a senha"),
                  obscureText: true,
                  controller: _controllerSenha,
                  validator: (value) =>
                      value.isEmpty ? "Nenhuma senha fornecida" : null,
                  onSaved: (value) => _senha = value,
                ),
                SizedBox(
                  height: 30,
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
                        Color(0xFFF58524),
                        Color(0XFFF92B7F),
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
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            child: SizedBox(
                              child: Image.asset('assets/images/login1.png'),
                              height: 28,
                              width: 28,
                            ),
                          )
                        ],
                      ),
                      onPressed: validateAndSubmit,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                        Color.fromARGB(255, 15, 0, 232),
                        Color(0XFFF92B7F),
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
                            "Cadastre-se",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            child: SizedBox(
                              child: Image.asset('assets/images/cadastro.png'),
                              height: 28,
                              width: 28,
                            ),
                          )
                        ],
                      ),
                      onPressed: movePaginaRegistrarFuncionario,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
