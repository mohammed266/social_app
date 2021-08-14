import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/regester/register_screen.dart';
import 'package:social_app/shared/components/components.dart';

import 'package:social_app/network/local/cache_helper.dart';


class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginErrorState){
            showToast(msg: state.error, state: ToastState.ERROR);
          }
          if(state is LoginSuccessState){
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
              navigateAndFinished(context, HomeScreen());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'login',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'login now to communicate with friends',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                            ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        // onSave: (){},
                        // onChanged: (){},
                        controller: emailController,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'enter your email address';
                          }
                        },
                        textInputType: TextInputType.emailAddress,
                        hint: 'email address',
                        prefix: Icon(Icons.email),
                        secure: false,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        secure: LoginCubit.get(context).isPassword,
                        controller: passwordController,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'enter your password';
                          }
                        },
                        textInputType: TextInputType.visiblePassword,
                        hint: 'password',
                        prefix: InkWell(
                          onTap: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          child: LoginCubit.get(context).suffix,
                        ),
                        onSubmit: (value) {
                          if (formKey.currentState.validate()) {
                            // LoginCubit.get(context).userLogin(
                            //   email: emailController.text,
                            //   password: passwordController.text,
                            // );
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'login',
                          color: Colors.blue,
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'don\'t have account ?',
                          ),
                          defaultTextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            text: 'register',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
