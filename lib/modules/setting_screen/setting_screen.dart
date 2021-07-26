import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop01_app/shared/cubit/shop_cubit.dart';
import 'package:shop01_app/shared/cubit/shop_state.dart';
import 'package:shop01_app/shared/network/components/components.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var fromKey = GlobalKey<FormState>();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).shopUserModel;
        nameController.text = model!.data!.name;
        print(' user email::${model.data!.email}');
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return Conditional.single(
            conditionBuilder: (context) =>
                ShopCubit.get(context).shopUserModel != null,
            widgetBuilder: (context) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: fromKey,
                      child: Column(children: [
                        if (state is ShopLoadingUpdateUserModelData)
                          LinearProgressIndicator(),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'you must enter your name';
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
                                return 'you must enter your email';
                              }
                            },
                            label: 'email',
                            prefix: Icons.email),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'you must enter your email';
                              }
                            },
                            label: 'phone',
                            prefix: Icons.phone),
                        SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                            function: () {
                              if (fromKey.currentState!.validate()) {
                                ShopCubit.get(context).updateUserModel(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text);
                              }
                            },
                            text: 'UPDATE'),
                        SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                            function: () {
                              signOut(context);
                            },
                            text: 'SIGN OUT'),
                      ]),
                    ),
                  ),
                ),
            context: context,
            fallbackBuilder: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}
