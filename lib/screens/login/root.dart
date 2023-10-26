import 'dart:async';
// //
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lennar/core/utils/images.dart';
import 'package:lennar/core/utils/response_message.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../core/datasource/key.dart';
import '../../core/datasource/local_storage.dart';
import '../../core/navigation/keys.dart';
import '../../core/navigation/navigation_service.dart';
import '../../core/startup/app_startup.dart';
import '../../core/utils/styles.dart';
import '../../core/utils/validator.dart';
import '../../core/widgets/app_password_textfield.dart';
import '../../core/widgets/app_textfield.dart';
import '../../core/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? _emailController = TextEditingController(text: "admin@admin.com");
  TextEditingController? _passwordController = TextEditingController(text: "admin");
  bool? _isRememberMeChecked = false, canSubmit = false, isSubmitting = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  //use this to remember the last logged-in email
  Future<void> _getData() async {
    String? loginEmail;
      loginEmail = (await GetIt.I
          .get<LocalStorage>()
          .readString(LocalStorageKeys.kLoginEmailPrefs))!;
    print(loginEmail);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: _formKey,
          onChanged: () {
            setState(() {
              canSubmit = _formKey.currentState!.validate();
            });
          },
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.appIcon,
                    height: 100.h,
                  ),
                  Text(
                    "login".tr(),
                    textAlign: TextAlign.center,
                    style: AppStyle.h3.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: 60.h),
                  AppTextField(
                    headerText: "email".tr(),
                    hintText: "example@gmail.com",
                    validator: Validator.emailValidator,
                    controller: _emailController,
                    readOnly: false,
                    onChanged: (v) {


                    },
                    textInputType: TextInputType.emailAddress,
                    onSaved: (val) => _emailController!.text = val!,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppPasswordTextField(
                    headerText: 'password'.tr(),
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    validator: Validator.requiredValidator,
                    onSaved: (val) => _passwordController!.text = val!,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 19,
                            width: 19,
                            child: Checkbox(
                              value: _isRememberMeChecked,
                              onChanged: (bool? newValue) => setState(() {
                                _isRememberMeChecked = newValue!;
                                if (_isRememberMeChecked!) {
                                  // TODO: Here goes your functionality that remembers the user.
                                } else {
                                  // TODO: Forget the user
                                }
                              }),
                              checkColor: Colors.white,
                              activeColor: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => print("remember_me".tr()),
                            child: Text(
                              "remember_me".tr(),
                              style: AppStyle.text2.copyWith(
                                  color: Colors.black, fontSize: 12.sp),
                            ),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () async {

                        },
                        child: Text(
                          "forgot_password".tr(),
                          style: AppStyle.text2.copyWith(
                              color: Colors.black, fontSize: 12.sp),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AppButton(
                          buttonText: "login".tr(),
                          onPressed: canSubmit!
                              ? () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _authUser();
                            }
                          }
                              : null)),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _authUser() {
    //show loader
    context.loaderOverlay.show();
    //delay (mock network call)
    Future.delayed(const Duration(seconds: 5), () async {
    //check email and password
      if (_emailController!.text == "admin@admin.com" && _passwordController!.text == "admin" ) {
        await serviceLocator.get<LocalStorage>().writeBool(LocalStorageKeys.kLoginPrefs, true);
        await serviceLocator.get<NavigationService>().replaceWith(RouteKeys.routeHome);
      } else {
        ResponseMessage.showErrorSnack(
            context: context, message: "invalid_login".tr());
      }
      //hide loader
      context.loaderOverlay.hide();
    });

  }
}
