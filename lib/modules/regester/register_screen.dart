import 'package:conditional_builder/conditional_builder.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/modules/regester/cubit/cubit.dart';
import 'package:social_app/modules/regester/cubit/states.dart';
import '../../shared/components/components.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if( state is RegisterCreateUserSuccessState){
            navigateAndFinished(context, HomeScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'register',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'register now to communicate with friends',
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
                        controller: nameController,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'enter your name';
                          }
                        },
                        textInputType: TextInputType.name,
                        hint: 'your name',
                        prefix: Icon(Icons.person),
                        secure: false,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        secure: RegisterCubit.get(context).isPassword,
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
                            RegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          child: RegisterCubit.get(context).suffix,
                        ),
                        onSubmit: (value) {},
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        // onSave: (){},
                        // onChanged: (){},
                        controller: emailController,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'enter your email';
                          }
                        },
                        textInputType: TextInputType.emailAddress,
                        hint: 'your email',
                        prefix: Icon(Icons.email),
                        secure: false,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        // onSave: (){},
                        // onChanged: (){},
                        controller: phoneController,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'enter your phone';
                          }
                        },
                        textInputType: TextInputType.phone,
                        hint: 'your phone',
                        prefix: Icon(Icons.phone),
                        secure: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState.validate()) {
                              RegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'Register',
                          color:Colors.blue,
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: 15,
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
