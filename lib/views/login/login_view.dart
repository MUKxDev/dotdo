import 'package:dotdo/constant.dart';
import 'package:dotdo/svg/svg.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (BuildContext context, LoginViewModel viewModel, Widget _) {
        // var emailController = useTextEditingController(text: 'hi');
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              shape: appBarShapeBorder,
              title: Text('Sign in'),
            ),
            body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    //* .Do logo svg
                    Theme.of(context).brightness == Brightness.light
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Hero(
                              tag: '_logoSvglight',
                              child: Container(
                                child: logoSvgLight,
                                height: 100,
                                width: 100,
                              ),
                            ))
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Hero(
                              tag: '_logoSvgDark',
                              child: Container(
                                child: logoSvgDark,
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                    // * email textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8),
                      child: TextField(
                        onChanged: viewModel.updateEmail,
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppColors.darkBackground
                                  : AppColors.white,
                        ),
                        autocorrect: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Email...',
                        ),
                      ),
                    ),
                    // * password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8),
                      child: TextField(
                        onChanged: viewModel.updatePassword,
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppColors.darkBackground
                                  : AppColors.white,
                        ),
                        autocorrect: false,
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Password...',
                        ),
                      ),
                    ),

                    // * Sign in button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8),
                      child: viewModel.isLoading
                          ? SizedBox(
                              child: CircularProgressIndicator(),
                              height: 60,
                              width: 60,
                            )
                          : Container(
                              height: 60,
                              width: double.infinity,
                              child: FlatButton(
                                color: Theme.of(context).accentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: viewModel.signinWithEmail,
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                    ),
                    // * Or Text
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Or',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    // * Register button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        child: FlatButton(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: viewModel.navigateToRegister,
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
