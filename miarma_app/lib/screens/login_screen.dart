import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miarma_app/blocs/bloc_login/login_bloc.dart';
import 'package:miarma_app/models/auth/login_dto.dart';
import 'package:miarma_app/resources/auth_repository.dart';
import 'package:miarma_app/resources/auth_repository_impl.dart';
import 'package:miarma_app/screens/menu_screen.dart';
import 'package:miarma_app/screens/register_screen.dart';
import 'package:miarma_app/utils/constant.dart';
import 'package:miarma_app/utils/preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc(authRepository);
        },
        child: _createBody(context));
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: const Color(0xFFEEEEEE),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(30),
            child: BlocConsumer<LoginBloc, LoginState>(
                listenWhen: (context, state) {
              return state is LoginSuccessState || state is LoginErrorState;
            }, listener: (context, state) {
              if (state is LoginSuccessState) {
                PreferenceUtils.setString(
                    Constants.token, state.loginResponse.token);
                PreferenceUtils.setString(
                    Constants.fullName, state.loginResponse.fullName);
                PreferenceUtils.setString(
                    Constants.avatar, state.loginResponse.avatar);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              } else if (state is LoginErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is RegisterInitialState ||
                  state is RegisterLoadingState;
            }, builder: (ctx, state) {
              if (state is RegisterInitialState) {
                return buildForm(ctx);
              } else if (state is RegisterLoadingState) {
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
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Write a password'
                          : null;
                    },
                  ),
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
                              final loginDto = LoginDto(
                                  email: emailController.text,
                                  password: passwordController.text);
                              BlocProvider.of<LoginBloc>(context)
                                  .add(DoLoginEvent(loginDto));
                            }
                          },
                          child: const Center(
                            child: Text(
                              "SIGN IN",
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
                  "DON'T HAVE AN ACCOUNT ? ",
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                InkWell(
                  child: Text("SIGN UP"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
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
