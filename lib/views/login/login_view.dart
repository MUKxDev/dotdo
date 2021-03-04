import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/logo/logo_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  final Function navigateToIndex;
  LoginView({this.navigateToIndex});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (BuildContext context, LoginViewModel viewModel, Widget _) {
        // var emailController = useTextEditingController(text: 'hi');
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // * LogoWidget
                  LogoWidget(),
                  // * Email textfield
                  TextfieldWidget(
                      controller: viewModel.emailController,
                      obscureText: false,
                      labelText: 'Email',
                      hintText: 'Enter Email...'),
                  // * Password textfield
                  TextfieldWidget(
                      controller: viewModel.passwordController,
                      obscureText: true,
                      labelText: 'Password',
                      hintText: 'Enter Password'),
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
                        // onPressed: viewModel.navigateToRegister,
                        onPressed: navigateToIndex,
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
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
