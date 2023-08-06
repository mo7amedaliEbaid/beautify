import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:beautify/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../widgets/customloading_widget.dart';
import '../../widgets/duplicatecontainer_widget.dart';
import '../../widgets/duplicatetempelate_widget.dart';
import '../../widgets/exception_widget.dart';
import '../../widgets/snackbar_widget.dart';
import '../../widgets/textfield_widget.dart';
import 'bloc/authentication_bloc.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  AuthenticationBloc? authenticationBloc;
  StreamSubscription? subscription;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> nameKey = GlobalKey();
  final GlobalKey<FormState> userNameKey = GlobalKey();
  final GlobalKey<FormState> passwordKey = GlobalKey();
  @override
  void dispose() {
    authenticationBloc?.close();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = AuthenticationBloc();
        bloc.add(AuthenticationStart());
        subscription = bloc.stream.listen((state) {
          if (state is SignSuccess) {
            snackBar(
                title: "sign",
                message: "sign in successfull",
             );
            Navigator.pop(context);
          } else if (state is LoginSuccess) {
            snackBar(
                title: "sign",
                message: "sign in successfull",
          );
            Navigator.pop(context);
          } else if (state is ChangeInformation) {
            final TextEditingController userNameController =
                TextEditingController();
            final TextEditingController passwordController =
                TextEditingController();
            final GlobalKey<FormState> userNameKey = GlobalKey();
            final GlobalKey<FormState> passwordKey = GlobalKey();
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: AppDimensions.normalize(150),
                  child: AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    titlePadding: EdgeInsets.zero,
                    shape: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(AppDimensions.normalize(5))),
                    title: Container(
                      alignment: Alignment.center,
                      height: AppDimensions.normalize(15),
                      margin: Space.v1,
                      decoration: BoxDecoration(
                          borderRadius:  BorderRadius.vertical(
                              top: Radius.circular(AppDimensions.normalize(5)))),
                      child: Text(
                        "Change password",

                      ),
                    ),
                    content: Container(
                      child: duplicateContainer(
                        child: Container(
                         // padding: const EdgeInsets.all(15),
                          width: AppDimensions.normalize(80),
                          height: AppDimensions.normalize(100),
                          child: Column(
                            children: [
                              textField(
                                context: context,
                                  controller: userNameController,
                                  formKey: userNameKey,
                                  lable: "user name",
                                  edgeInsetsGeometry: Space.all(.5,.5)),
                              textField(
                                context: context,
                                  controller: passwordController,
                                  formKey: passwordKey,
                                  lable: "Password",
                                  edgeInsetsGeometry: Space.all(.5,.5)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      Container(
                        alignment: Alignment.center,
                        margin: Space.v1,
                        child: CupertinoButton.filled(

                          child: Text(
                            "Save",
                          ),
                          onPressed: () {
                            if (userNameKey.currentState!.validate() &&
                                passwordKey.currentState!.validate()) {
                              authenticationBloc!.add(
                                  AuthenticationSaveChanges(
                                      userName: userNameController.text,
                                      password: passwordController.text));
                              Navigator.pop(context);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else if (state is UserHaveNoAccount) {
            snackBar(
                title: "Account",
                message: "Account not found",
           );
          } else if (state is LoginUnSuccess) {
            snackBar(
                title: "Incorrect information",
                message: "Incorrect username and password entered",
 );
          }
        });
        authenticationBloc = bloc;
        return bloc;
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationLoginScreen) {
            final duplicateController = state.duplicateController;
            final profileController = state.profileController;


             EdgeInsetsGeometry edgeInsets = Space.all(.5,.5);
            return DuplicateTemplate(
              title: "Login",
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: duplicateController.uiDuplicate.defaultScroll,
                      child: Column(
                        children: [
                          Padding(
                            padding:Space.all(.5,.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  "Let's sign you in",
                                style:AppText.h3b ,
                                  maxLines: 1,
                                ),
                                Space.y!,
                                AutoSizeText(
                                  "welcome back, we've been missed you",
                                style: AppText.b1b,
                                  maxLines: 1,
                                )
                              ],
                            ),
                          ),
                          Space.y1!,
                          textField(
                            context: context,
                              edgeInsetsGeometry: edgeInsets,
                              controller: userNameController,
                              formKey: userNameKey,
                              lable: "UserName or Email"),
                          Obx(
                            () => textField(
                              context: context,
                                suffix: CupertinoButton(
                                  child: Icon(profileController.obscureText
                                      ? CupertinoIcons.eye
                                      : CupertinoIcons.eye_slash),
                                  onPressed: () {
                                    profileController
                                            .obscureTextInstance.value =
                                        !profileController
                                            .obscureTextInstance.value;
                                  },
                                ),
                                obscureText: profileController.obscureText,
                                edgeInsetsGeometry: edgeInsets,
                                controller: passwordController,
                                formKey: passwordKey,
                                lable: "Password"),
                          ),
                          Padding(
                            padding: edgeInsets,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Obx(
                                      () => Checkbox(
                                        value:
                                            profileController.rememberMeStatus,
                                        onChanged: (value) {
                                          if (value != null) {
                                            profileController
                                                .rememberMeStatusInstance
                                                .value = value;
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      "Remember me",
                                    )
                                  ],
                                ),
                                CupertinoButton(
                                  child: Text(
                                    "Forgat password?",
                                  ),
                                  onPressed: () {
                                    authenticationBloc!
                                        .add(AuthenticationChangeInformation());
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: edgeInsets,
                            child: CupertinoButton.filled(
                                borderRadius: BorderRadius.circular(AppDimensions.normalize(5)),
                                child: Text(
                                  "Login",
                                ),
                                onPressed: () async {
                                  authenticationBloc!.add(
                                      AuthenticatioLogin(
                                          userName: userNameController.text,
                                          password: passwordController.text,
                                          isRemember: profileController
                                              .rememberMeStatus));
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "Don't have an account?",
                        style: AppText.b1b,
                      ),
                      CupertinoButton(
                        child: Text(
                          "SignUp",
                        ),
                        onPressed: () {
                          authenticationBloc!.add(AuthenticationSignUpMode());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is AuthenticationSignUpScreen) {
            final duplicateController = state.duplicateController;
            final profileController = state.profileController;
             EdgeInsetsGeometry edgeInsets = Space.all(1,.2);
            return DuplicateTemplate(
                title: "Signup",
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: duplicateController.uiDuplicate.defaultScroll,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  Space.all(.5,.8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    "Let's sign you in",
                                  style: AppText.b1b,
                                    maxLines: 1,
                                  ),
                                 Space.y!,
                                  AutoSizeText(
                                    "welcome back, we've been missed you",
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            ),
                            Space.y1!,
                            textField(
                              context: context,
                                edgeInsetsGeometry: edgeInsets,
                                controller: nameController,
                                formKey: nameKey,
                                lable: "Full Name"),
                            textField(
                              context: context,
                                edgeInsetsGeometry: edgeInsets,
                                controller: userNameController,
                                formKey: userNameKey,
                                lable: "UserName or Email"),
                            Obx(
                              () => textField(
                                context: context,
                                  suffix: CupertinoButton(
                                    child: Icon(profileController.obscureText
                                        ? CupertinoIcons.eye
                                        : CupertinoIcons.eye_slash),
                                    onPressed: () {
                                      profileController
                                              .obscureTextInstance.value =
                                          !profileController
                                              .obscureTextInstance.value;
                                    },
                                  ),
                                  obscureText: profileController.obscureText,
                                  edgeInsetsGeometry: edgeInsets,
                                  controller: passwordController,
                                  formKey: passwordKey,
                                  lable: "Password"),
                            ),
                            Padding(
                              padding: edgeInsets,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Checkbox(
                                      value: profileController.rememberMeStatus,
                                      onChanged: (value) {
                                        if (value != null) {
                                          profileController
                                              .rememberMeStatusInstance
                                              .value = value;
                                        }
                                      },
                                    ),
                                  ),
                                  Text(
                                    "Remember me",
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: edgeInsets,
                              child: CupertinoButton.filled(
                                  borderRadius: BorderRadius.circular(AppDimensions.normalize(7)),
                                  child: Text(
                                    "SignUp",
                                   style: AppText.h3b
                                  ),
                                  onPressed: () async {
                                    if (nameKey.currentState!.validate() &&
                                        userNameKey.currentState!
                                            .validate() &&
                                        passwordKey.currentState!
                                            .validate()) {
                                      authenticationBloc!.add(
                                          AuthenticationSignUp(
                                              name: nameController.text,
                                              userName:
                                                  userNameController.text,
                                              password:
                                                  passwordController.text,
                                              isRemember: profileController
                                                  .rememberMeStatus));
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "have an account?",
                         style: AppText.h3b,
                        ),
                        CupertinoButton(
                          child: Text(
                            "Login",
                          ),
                          onPressed: () {
                            authenticationBloc!.add(AuthenticationLoginMode());
                          },
                        ),
                      ],
                    ),
                    Space.y!
                  ],
                ));
          } else if (state is AuthenticationLoading) {
            return const CustomLoading();
          } else if (state is AuthenticationError) {
            return AppException(
              callback: () {
                authenticationBloc!.add(AuthenticationStart());
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
