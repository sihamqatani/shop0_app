import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop01_app/layouts/shop_layout.dart';
//import 'package:shop01_app/models/shop_model.dart';
import 'package:shop01_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop01_app/modules/login_screen/cubit/state.dart';
import 'package:shop01_app/shared/network/components/components.dart';
import 'package:shop01_app/shared/network/local/cash_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    late var emailController = TextEditingController();
    late var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
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
        builder: (context, state) => Scaffold(
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
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'login nom to brows our offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
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
                          suffix: ShopLoginCubit.get(context).iconVisiblity,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changPasswordVisibilty();
                          },
                          isPassword: ShopLoginCubit.get(context).isPasword,
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
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);

                              print('22');
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            state is! ShopLoginloadingState,
                        widgetBuilder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                print('done');
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);

                                print('22');
                              }
                            },
                            text: 'Login'),
                        fallbackBuilder: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('you Don \'t have account?'),
                          TextButton(onPressed: () {}, child: Text('REGISTER')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
