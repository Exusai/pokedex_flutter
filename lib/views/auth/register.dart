import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/bloc/user_bloc.dart';
import '../../models/user.dart';

class UserNameRegister extends StatefulWidget {
  const UserNameRegister({Key? key}) : super(key: key);

  @override
  State<UserNameRegister> createState() => _UserNameRegisterState();
}

class _UserNameRegisterState extends State<UserNameRegister> {
  final _formkey = GlobalKey<FormState>();
  String username = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      //shrinkWrap: true,
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      children: <Widget>[
        //Image.asset('assets/avatar/avatar.png',height: 150,width: 150,)
        const SizedBox(
          height: 10,
        ),
        Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              const Text(
                'Parece que no te has registrado',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                //textAlign: TextAlign.center,
              ),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Ingresar un nombre de usuario' : null,
                onChanged: (val) {
                  setState(() => username = val);
                },
                //keyboardType: TextInputType.emailAddress,
                autofocus: false,
                initialValue: '',
                decoration: const InputDecoration(
                  hintText: 'Elige tu nombre de usuario',
                ),
              ),
              const SizedBox(
                height: 10,
              ),

            ],
          ),
        ),

        ElevatedButton(
          child: const Text('Registrar'),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
          onPressed: () async {
            if (_formkey.currentState!.validate()) {
              context.read<UserBloc>().add(AddUser(User(username: username)));
              setState(() => error = '');
              //context.read<UserBloc>().add(LoadUser());
            } else {
              setState(() => error = 'El nombre de usuario no puede estar en blanco');
            }
          },
        ),

        const SizedBox(
          height: 10,
        ),
        Text(
          error,
          style: const TextStyle(color: Colors.red, fontSize: 14.0),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}