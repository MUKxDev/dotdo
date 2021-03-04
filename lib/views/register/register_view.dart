import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/logo/logo_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'register_view_model.dart';

class RegisterView extends StatelessWidget {
  final Function navigateToIndex;

  const RegisterView({Key key, this.navigateToIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      builder: (BuildContext context, RegisterViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // * LogoWidget
                  LogoWidget(),
                  // * email textfield
                  TextfieldWidget(
                      controller: viewModel.emailController,
                      obscureText: false,
                      labelText: 'Email',
                      hintText: 'Enter Email...'),
                  // * password textfield
                  TextfieldWidget(
                      controller: viewModel.passwordController,
                      obscureText: true,
                      labelText: 'New Password',
                      hintText: 'Enter New Password'),
                  // * confirm Password textfield
                  TextfieldWidget(
                      controller: viewModel.confirmPasswordController,
                      obscureText: true,
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password...'),
                  // * Register button
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
                              onPressed: viewModel.registerWithEmail,
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                  ),
                  // * Or Text
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Or',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // * Sign in button
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
                        onPressed: navigateToIndex,
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
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
      viewModelBuilder: () => RegisterViewModel(),
    );
  }
}
