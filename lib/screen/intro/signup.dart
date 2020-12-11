import 'package:flutter/material.dart';
import 'package:crypto_template/screen/Bottom_Nav_Bar/bottom_nav_bar.dart';
import 'package:crypto_template/screen/home/home.dart';
import 'package:crypto_template/screen/intro/login.dart';
import 'package:crypto_template/screen/setting/themes.dart';
import 'package:crypto_template/component/style.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:crypto_template/repository/auth_repository.dart';
import 'package:crypto_template/network/api_provider.dart';
import 'package:crypto_template/models/user.dart';
import 'package:crypto_template/component/shared_pref.dart';

class SignUp extends StatefulWidget {
  final ThemeBloc themeBloc;
  SignUp({this.themeBloc});
  @override
  _SignUpState createState() => _SignUpState(themeBloc);
}

class _SignUpState extends State<SignUp> {
  ThemeBloc _themeBloc;
  bool isLoading = false;
  bool isFailure = false;
  User user;
  _SignUpState(this._themeBloc);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();

  dynamic registerObject;
  String _email, _password, _confirmPassword, _referralCode = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailValidator = MultiValidator([
    EmailValidator(errorText: 'Please type a valid email'),
  ]);

  final _passwordValidator = MultiValidator([
    PatternValidator(r'((?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*\W)\w.{6,18}\w)',
        errorText: 'passwords must be 8 characters with uppercase letters')
  ]);

  _onSignFormSubmit() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      _email = _emailController.text;
      _password = _passwordController.text;
      registerObject = {
        'email': _email,
        'password': _password,
      };
      if (_referralCode != null && _referralCode != '') {
        registerObject['refid'] = _referralCode;
      }

      try {
        AuthRepository _authRepository = new AuthRepository();
        user = await _authRepository.register(registerObject);
        SharedPref sharedPref = SharedPref();
        sharedPref.saveBool('isLoggedIn', true);
        sharedPref.save('user', user);
        setState(() {
          isLoading = false;
          isFailure = false;
        });
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new BottomNavBar(
                  themeBloc: _themeBloc,
                )));
      } catch (e) {
        print(e);
        setState(() {
          isFailure = true;
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Form(
      // autovalidate: true,
      key: _formKey,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,

          /// Set Background image in splash screen layout (Click to open code)
          decoration: BoxDecoration(color: colorStyle.background),
          child: Stack(
            children: <Widget>[
              ///
              /// Set image in top
              ///
              Container(
                height: 129.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/image/signupHeader.png"),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      /// Animation text marketplace to choose Login with Hero Animation (Click to open code)
                      Padding(
                        padding: EdgeInsets.only(
                            top: mediaQuery.padding.top + 130.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/image/logo.png", height: 35.0),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 17.0, top: 7.0),
                              child: Text(
                                "Crypto",
                                style: TextStyle(
                                    fontFamily: "Sans",
                                    color: Colors.white,
                                    fontSize: 27.0,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 3.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: _buildTextFeild(
                            widgetIcon: Icon(
                              Icons.email,
                              color: colorStyle.primaryColor,
                              size: 20,
                            ),
                            validator: emailValidator,
                            onChanged: (input) => _email = input,
                            controller: _emailController,
                            hint: 'Email',
                            obscure: false,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: _buildTextFeild(
                            widgetIcon: Icon(
                              Icons.vpn_key,
                              size: 20,
                              color: colorStyle.primaryColor,
                            ),
                            validator: _passwordValidator,
                            onChanged: (input) => _password = input,
                            controller: _passwordController,
                            hint: 'Password',
                            obscure: true,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: _buildTextFeild(
                            widgetIcon: Icon(
                              Icons.vpn_key,
                              size: 20,
                              color: colorStyle.primaryColor,
                            ),
                            controller: _confirmPasswordController,
                            validator: (val) => MatchValidator(
                                    errorText: 'passwords do not match')
                                .validateMatch(val, _password),
                            onChanged: (input) => _confirmPassword = input,
                            hint: 'Confirm Password',
                            obscure: true,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: _buildTextFeild(
                            widgetIcon: Icon(
                              Icons.group_add,
                              size: 20,
                              color: colorStyle.primaryColor,
                            ),
                            onChanged: (input) => _referralCode = input,
                            controller: _referralCodeController,
                            hint: 'Referral Code',
                            obscure: false,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.start),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            _onSignFormSubmit();
                            // Navigator.of(context)
                            //     .pushReplacement(PageRouteBuilder(
                            //         pageBuilder: (_, __, ___) => bottomNavBar(
                            //               themeBloc: _themeBloc,
                            //             )));
                          },
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)),
                              color: colorStyle.primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0,
                                    letterSpacing: 1.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => new Login(
                                          themeBloc: _themeBloc,
                                        )));
                          },
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)),
                              border: Border.all(
                                color: colorStyle.primaryColor,
                                width: 0.35,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17.5,
                                    letterSpacing: 1.9),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFeild({
    String hint,
    FormFieldSetter onSaved,
    ValueChanged onChanged,
    FormFieldValidator validator,
    TextEditingController controller,
    TextInputType keyboardType,
    bool obscure,
    String icon,
    TextAlign textAlign,
    Widget widgetIcon,
  }) {
    return Column(
      children: <Widget>[
        Container(
          child: TextFormField(
            onChanged: onChanged,
            // onSaved: onSaved,
            style: new TextStyle(color: Colors.white),
            textAlign: textAlign,
            obscureText: obscure,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            autocorrect: false,
            autofocus: false,
            decoration: InputDecoration(
                errorStyle: TextStyle(
                  fontSize: 13.5,
                ),
                errorMaxLines: 3,
                filled: true,
                fillColor: Colors.transparent,
                labelText: hint,
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(
                  color: Colors.white70,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
        ),
      ],
    );
  }
}
