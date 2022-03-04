import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miarma_app/blocs/bloc_image/image_pick_bloc_bloc.dart';
import 'package:miarma_app/blocs/bloc_login/login_bloc.dart';
import 'package:miarma_app/blocs/bloc_register/register_bloc.dart';
import 'package:miarma_app/models/register/register_dto.dart';
import 'package:miarma_app/resources/register_repository.dart';
import 'package:miarma_app/resources/register_repository_impl.dart';
import 'package:miarma_app/screens/login_screen.dart';
import 'package:miarma_app/utils/constant.dart';
import 'package:miarma_app/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late DateTime birthDate;
  TextEditingController photoController = TextEditingController();
  late RegisterRepository registerRepository;
  bool isPublic = true;
  String filePath = ' ';

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  void initState() {
    registerRepository = RegisterRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return RegisterBloc(registerRepository);
        }),
        BlocProvider(create: (context) {
          return ImagePickBlocBloc();
        })
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _createBody(context),
      ),
    );
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: const Color(0xFFEEEEEE),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(30),
            child: BlocConsumer<RegisterBloc, RegisterState>(
                listenWhen: (context, state) {
              return state is RegisterSuccessState ||
                  state is RegisterErrorState;
            }, listener: (context, state) {
              if (state is RegisterSuccessState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else if (state is RegisterErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is RegisterInitialState ||
                  state is RegisterLoadState;
            }, builder: (ctx, state) {
              if (state is RegisterInitialState) {
                return buildForm(ctx);
              } else if (state is RegisterLoadState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return buildForm(ctx);
              }
            })),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: getSmallDiameter(context) * 0.8,
              height: getSmallDiameter(context) * 0.8,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFFB226B2), Color(0xFFFF6DA7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Image.asset("assets/images/logo.png"),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.fromLTRB(20, 50, 20, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
              child: Column(
                children: <Widget>[
                  BlocConsumer<ImagePickBlocBloc, ImagePickBlocState>(
                    listenWhen: (context, state) {
                      return state is ImageSelectedSuccessState;
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return state is ImagePickBlocInitial ||
                          state is ImageSelectedSuccessState;
                    },
                    builder: (context, state) {
                      if (state is ImageSelectedSuccessState) {
                        filePath = state.pickedFile.path;
                        return InkWell(
                          onTap: () {
                            BlocProvider.of<ImagePickBlocBloc>(context).add(
                                const SelectImageEvent(ImageSource.gallery));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              File(state.pickedFile.path),
                              width: 150,
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<ImagePickBlocBloc>(context).add(
                                const SelectImageEvent(ImageSource.gallery));
                          },
                          child: Image.asset(
                            'assets/images/avatargris.jpg',
                            width: 80,
                          ),
                        ),
                      );
                    },
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        suffixIcon:
                            Icon(Icons.person, color: Color(0xFFFF4891)),
                        suffixIconColor: Colors.white,
                        labelText: 'NickName',
                        enabledBorder: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter some text'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.email, color: Color(0xFFFF4891)),
                        suffixIconColor: Colors.white,
                        labelText: 'Email',
                        enabledBorder: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    validator: (String? value) {
                      return (value == null || !value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        suffixIcon:
                            Icon(Icons.vpn_key, color: Color(0xFFFF4891)),
                        suffixIconColor: Colors.white,
                        labelText: 'Password',
                        enabledBorder: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Write a password'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: password2Controller,
                    obscureText: true,
                    decoration: const InputDecoration(
                        suffixIconColor: Colors.white,
                        labelText: 'Repeat Password',
                        enabledBorder: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Write a password'
                          : null;
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isPublic,
                          onChanged: (value) {
                            setState(() {
                              isPublic = value!;
                            });
                          }),
                      const Text('Hacer perfil público'),
                    ],
                  ),
                  DateTimeFormField(
                    initialDate: DateTime(2001, 3, 2),
                    firstDate: DateTime.utc(1922),
                    lastDate: DateTime.now(),
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Birthday',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      birthDate = value;
                    },
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                    child: const Text(
                      "FORGOT PASSWORD?",
                      style: TextStyle(color: Color(0xFFFF4891), fontSize: 11),
                    ))),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    child: Container(
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.amber,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              final registerDTO = RegisterDTO(
                                  avatar: filePath,
                                  fullname: nameController.text,
                                  email: emailController.text,
                                  privacy: isPublic,
                                  birthday: birthDate,
                                  password: passwordController.text,
                                  password2: password2Controller.text);
                              BlocProvider.of<RegisterBloc>(context)
                                  .add(DoRegisterEvent(registerDTO));
                            }
                          },
                          child: const Center(
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              colors: [Color(0xFFB226B2), Color(0xFFFF4891)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                    ),
                  ),
                  FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      elevation: 0,
                      child: Icon(FontAwesomeIcons.facebook)),
                  FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      elevation: 0,
                      child: Icon(FontAwesomeIcons.twitter)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "HAVE AN ACCOUNT ? ",
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                InkWell(
                  child: Text("SIGN IN"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
