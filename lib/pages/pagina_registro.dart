import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaginaRegistro extends StatefulWidget {
  @override
  _PaginaRegistroState createState() => _PaginaRegistroState();
}

class _PaginaRegistroState extends State<PaginaRegistro> {
  String _email;
  String _senha;
  bool _checked = false;

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
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
        UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _senha);
        print('User: ${user.user.uid}');
      }
      catch(e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registrar Novo Funcionário"),
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
                      labelText: "E-mail:",
                      hintText: "Digite o e-mail do funcionário"
                  ),
                  controller: _controllerEmail,
                  validator: (value) => value.isEmpty ? "Nenhum e-mail fornecido" : null,
                  onSaved: (value) => _email = value,
                ),
                new TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Senha:",
                      hintText: "Crie a senha para o funcionário"
                  ),
                  obscureText: true,
                  controller: _controllerSenha,
                  validator: (value) => value.isEmpty ? "Nenhuma senha fornecida" : null,
                  onSaved: (value) => _senha = value,
                ),
                new CheckboxListTile(
                    title: Text("Criar como administrador"),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _checked,
                    onChanged: (bool value){
                      setState(() {
                        _checked = value;
                        print(value);
                      });
                    }
                ),
                new ElevatedButton(
                  child: Text(
                    "Login",
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
