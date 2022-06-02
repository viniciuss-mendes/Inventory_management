import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class pagina_adicionar_produto extends StatefulWidget {
  @override
  _pagina_adicionar_produtoState createState() => _pagina_adicionar_produtoState();
}

class _pagina_adicionar_produtoState extends State<pagina_adicionar_produto> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerSetor = TextEditingController();
  TextEditingController _controllerLote = TextEditingController();
  TextEditingController _controllerQuantidade = TextEditingController();
  TextEditingController _controllerFabricacao = TextEditingController();
  TextEditingController _controllerValidade = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar um Produto"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[

            TextFormField(
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: "Nome:",
              ),
              controller: _controllerNome,
              validator: (String text){
                if(text.isEmpty){
                  return "Digite o nome";
                }
                return null;
              },
            ),
            SizedBox(height: 10,),

            TextFormField(
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: "Setor:",
              ),
              controller: _controllerSetor,
              validator: (String text){
                if(text.isEmpty){
                  return "Digite o setor do produto";
                }
                return null;
              },
            ),
            SizedBox(height: 10,),

            TextFormField(
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: "Lote: ",
              ),
              controller: _controllerLote,
              validator: (String text){
                if(text.isEmpty){
                  return "Digite o lote do produto ";
                }
                return null;
              },
            ),
            SizedBox(height: 20,),

            TextFormField(
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: "Quantidade: ",
              ),
              controller: _controllerQuantidade,
              validator: (String text){
                if(text.isEmpty){
                  return "Digite a quantidade do produto ";
                }
                return null;
              },
            ),
            SizedBox(height: 20,),

            TextFormField(
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: "Fabricação: ",
              ),
              controller: _controllerFabricacao,
              validator: (String text){
                if(text.isEmpty){
                  return "Digite a data de fabricação ";
                }
                return null;
              },
            ),
            SizedBox(height: 20,),

            TextFormField(
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  labelText: "Validade: ",
              ),
              controller: _controllerValidade,
              validator: (String text){
                if(text.isEmpty){
                  return "Digite a data de Validade ";
                }
                return null;
              },
            ),
            SizedBox(height: 20,),

            Container(
              height: 46,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      child: Text("Adicionar",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),),
                      onPressed: () {
                      }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _confirmacao(){
    return AlertDialog(
      title: Text("Registro efetuado"),
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

  trataResponse(Map<String, dynamic> ret){
    return ret["logradouro"]+", "+ret["bairro"]+" - "+ret["localidade"];
  }

}
