import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                        'Welcome to .do',
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
                    AutofillGroup(
                      child: Column(
                        children: [
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  viewModel.validatePassword(value),
                              keyboardType: TextInputType.visiblePassword,
                              autofillHints: AutofillHints.password,
                              labelText: 'Password',
                              hintText: 'Enter password...'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: screenWidth(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // * Forgot password button
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.all(10),
                                        scrollable: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        content: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  // reset email password
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: LableTextWidget(
                                                            lable:
                                                                'Reset your password'),
                                                      ),
                                                      verticalSpaceXSmall(
                                                          context),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Theme.of(
                                                                    context)
                                                                .scaffoldBackgroundColor),
                                                        width: 300,
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          TextFormField(
                                                                        keyboardType:
                                                                            TextInputType.emailAddress,
                                                                        controller:
                                                                            viewModel.restEmailController,
                                                                        autovalidateMode:
                                                                            AutovalidateMode.onUserInteraction,
                                                                        validator:
                                                                            (value) =>
                                                                                viewModel.validateResetEmail(value),
                                                                        autofillHints: [
                                                                          AutofillHints
                                                                              .email,
                                                                        ],
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              'Reset email',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      child: ButtonWidget(
                                                                          borderRadius:
                                                                              10,
                                                                          onPressed: viewModel
                                                                              .forgotPassword,
                                                                          text:
                                                                              'Send reset email'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                'Forgot password?',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            // * Register a new account? button
                            TextButton(
                              onPressed: navigateToIndex,
                              child: Text(
                                'Register a new account?',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
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
                          : ButtonWidget(
                              onPressed: viewModel.signinWithEmail,
                              text: 'Sign in'),
                    ),
                  ],
                ),
                // // * Or & Social Media Auth
                // Column(
                //   children: [
                //     // * Or Text
                //     Center(
                //       child: Padding(
                //         padding: EdgeInsets.all(10),
                //         child: Text(
                //           'Or',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 18,
                //           ),
                //         ),
                //       ),
                //     ),
                // // * Social Media Auth
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 20.0, vertical: 8),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       // * Auth with Google
                //       Container(
                //         decoration: BoxDecoration(
                //           color: Theme.of(context).primaryColor,
                //           shape: BoxShape.circle,
                //         ),
                //         child: IconButton(
                //             icon: Icon(
                //               FontAwesomeIcons.google,
                //               color: Theme.of(context).accentColor,
                //             ),
                //             onPressed: viewModel.authWithGoogle),
                //       ),
                //       // * Auth with Apple
                //       Container(
                //         decoration: BoxDecoration(
                //           color: Theme.of(context).primaryColor,
                //           shape: BoxShape.circle,
                //         ),
                //         child: IconButton(
                //             icon: Icon(
                //               FontAwesomeIcons.apple,
                //               color: Theme.of(context).accentColor,
                //             ),
                //             onPressed: viewModel.authWithApple),
                //       ),
                //     ],
                //   ),
                // ),
                //   ],
                // )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
