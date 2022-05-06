import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pagina_principal.dart';

class PaginaLogin extends StatefulWidget {
  @override
  _PaginaLoginState createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin>{
  String _email;
  String _senha;

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
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _senha);
        print('User: ${user.user.uid}');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaginaPrincipal()
          ),
        );
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
        title: Text("Controle de Estoque"),
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
                      labelText: "Email:",
                      hintText: "Digite o Email"
                  ),
                  controller: _controllerEmail,
                  validator: (value) => value.isEmpty ? "Nenhum email fornecido" : null,
                  onSaved: (value) => _email = value,
                ),
                new TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelText: "Senha:",
                      hintText: "Digite a senha"
                  ),
                  obscureText: true,
                  controller: _controllerSenha,
                  validator: (value) => value.isEmpty ? "Nenhuma senha fornecida" : null,
                  onSaved: (value) => _senha = value,
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
