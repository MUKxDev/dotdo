import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/logo/logo_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * Logo & Tilte
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * LogoWidget
                    LogoWidget(
                      height: 80,
                      width: 80,
                    ),
                    // * Title widget
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Register a new account',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                // * Form
                Column(
                  children: [
                    Column(
                      children: [
                        // * userName textfield
                        TextfieldWidget(
                          controller: viewModel.userNameController,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          autofillHints: AutofillHints.newUsername,
                          labelText: 'Username',
                          hintText: 'Enter your username...',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              viewModel.validateUsername(value),
                        ),
                        // * Email textfield
                        TextfieldWidget(
                            controller: viewModel.emailController,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: AutofillHints.email,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                viewModel.validateEmail(value),
                            labelText: 'Email',
                            hintText: 'Enter email...'),
                        // * Password textfield
                        TextfieldWidget(
                            controller: viewModel.passwordController,
                            obscureText: true,
                            // keyboardType: TextInputType.visiblePassword,
                            autofillHints: AutofillHints.newPassword,
                            labelText: 'New password',
                            hintText: 'Enter new password...'),
                        // * Confirm password textfield
                        TextfieldWidget(
                            controller: viewModel.confirmPasswordController,
                            obscureText: true,
                            // keyboardType: TextInputType.visiblePassword,
                            autofillHints: AutofillHints.newPassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                viewModel.validatePassword(value),
                            labelText: 'Confirm password',
                            hintText: 'Confirm password...'),
                      ],
                    ),
                    // * Already have an account? button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: navigateToIndex,
                            child: Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          : ButtonWidget(
                              onPressed: viewModel.registerWithEmail,
                              text: 'Register',
                            ),
                    ),
                  ],
                ),
                // * Or & Social Media Auth
                Column(
                  children: [
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
                    // * Social Media Auth
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // * Auth with Google
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.google,
                                  color: Theme.of(context).accentColor,
                                ),
                                onPressed: viewModel.authWithGoogle),
                          ),
                          // * Auth with Apple
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.apple,
                                  color: Theme.of(context).accentColor,
                                ),
                                onPressed: viewModel.authWithApple),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => RegisterViewModel(),
    );
  }
}
