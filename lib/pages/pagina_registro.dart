import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaginaRegistro extends StatefulWidget {
  @override
  _PaginaRegistroState createState() => _PaginaRegistroState();
}

class _PaginaRegistroState extends State<PaginaRegistro> {
  String _email;
  String _senha;

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerSenhaConfirma = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  bool validateAndSave(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if(validateAndSave()){
      try {
        _email = _controllerEmail.text;
        _senha = _controllerSenha.text;
        UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _senha);
        print('User created: ${user.user.uid}');

        final role = {
          "role": "none",
          "email": "$_email",
        };

        db.collection("users").doc(user.user.uid).set(role);

        showDialog(
            context: context,
            builder: (context){
              return creationSuccess();
            });

      } on FirebaseAuthException catch(e) {
        if (e.code == 'email-already-in-use'){
          showDialog(
              context: context,
              builder: (context){
                return _falha();
              });
        }
        if (e.code == 'invalid-email'){
          showDialog(
              context: context,
              builder: (context){
                return _falha2();
              });
        }
        if (e.code == 'weak-password'){
          showDialog(
              context: context,
              builder: (context){
                return _falha3();
              });
        }else{
          print(e);
        }
      }

    }
  }

  _falha(){
    return AlertDialog(
      title: Text("Erro!"),
      content: Text("Este e-mail já está sendo utilizado!"),
      actions: <Widget>[
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Ok")
        ),
      ],
    );
  }

  _falha2(){
    return AlertDialog(
      title: Text("Erro!"),
      content: Text("E-mail mal formatado!"),
      actions: <Widget>[
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Ok")
        ),
      ],
    );
  }

  _falha3(){
    return AlertDialog(
      title: Text("Erro!"),
      content: Text("Senha deve ter pelo menos 6 dígitos!"),
      actions: <Widget>[
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Ok")
        ),
      ],
    );
  }

  creationSuccess(){
    return AlertDialog(
      title: Text("Conta criada"),
      content: Text("Sua conta foi criada com sucesso!"),
      actions: <Widget>[
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Ok")
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registrar"),
          centerTitle: true,
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                new TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "E-mail",
                      hintText: "Digite o e-mail"
                  ),
                  controller: _controllerEmail,
                  validator: (value) => value.isEmpty ? "Nenhum e-mail fornecido" : null,
                ),
                new TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Senha",
                      hintText: "Crie uma senha"
                  ),
                  obscureText: true,
                  controller: _controllerSenha,
                  validator: (value){
                    if(value.isEmpty){
                      return "Digite a senha ";
                    }
                    if(_controllerSenhaConfirma.text != _controllerSenha.text){
                      return "As senhas devem ser iguais";
                    }
                    return null;
                  },
                ),
                new TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Confirmar senha",
                      hintText: "Digite a senha novamente"
                  ),
                  obscureText: true,
                  controller: _controllerSenhaConfirma,
                  validator: (value){
                    if(value.isEmpty){
                      return "Digite a senha ";
                    }
                    if(_controllerSenhaConfirma.text != _controllerSenha.text){
                      return "As senhas devem ser iguais";
                    }
                    return null;
                  },
                ),
                new ElevatedButton(
                  child: Text(
                    "Confirmar",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  onPressed: validateAndSubmit,
                ),
              ],
            ),
          ),
        )
    );
  }
}
