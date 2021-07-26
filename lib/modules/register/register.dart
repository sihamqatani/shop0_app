import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop01_app/layouts/shop_layout.dart';
import 'package:shop01_app/modules/register/cubit/cubit.dart';
import 'package:shop01_app/modules/register/cubit/state.dart';
import 'package:shop01_app/shared/network/components/components.dart';
import 'package:shop01_app/shared/network/local/cash_helper.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    late var emailController = TextEditingController();
    late var passwordController = TextEditingController();
    late var nameController = TextEditingController();
    late var phoneController = TextEditingController();
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.shopUserModel.status) {
              CashHelper.saveData(
                      key: 'token', value: state.shopUserModel.data?.token)
                  .then((value) => navigateAndFinish(context, ShopLayout()));
              showToast(
                  message: state.shopUserModel.message!,
                  state: ToastColorstate.SUCCESS);
              print(state.shopUserModel.message);
            } else {
              showToast(
                  message: state.shopUserModel.message!,
                  state: ToastColorstate.ERROR);
            }

            print('the status is: ${state.shopUserModel.status}');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Register now to browse our offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'must enter name';
                              }
                            },
                            label: 'name',
                            prefix: Icons.person),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'must enter email';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            suffix:
                                ShopRegisterCubit.get(context).iconVisiblity,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changPasswordVisibilty();
                            },
                            isPassword:
                                ShopRegisterCubit.get(context).isPasword,
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'must enter Password';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_clock_outlined,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                print('done');
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text);

                                print('22');
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'must enter phone number';
                              }
                            },
                            label: 'Phone number',
                            prefix: Icons.phone),
                        SizedBox(
                          height: 20,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) => true,
                          widgetBuilder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  print('done');
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                  print('22');
                                }
                              },
                              text: ('REGISTER')),
                          fallbackBuilder: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
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
