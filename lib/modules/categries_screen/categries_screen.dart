import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop01_app/models/categories.dart';
import 'package:shop01_app/shared/cubit/shop_cubit.dart';
import 'package:shop01_app/shared/cubit/shop_state.dart';

class Categries extends StatelessWidget {
  const Categries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
          itemBuilder: (context, index) => buildCatoegriesItem(
              ShopCubit.get(context).catogriesModel?.data?.data[index]),
          separatorBuilder: (context, index) => Container(
                width: double.infinity,
                color: Colors.grey[300],
                height: 1,
              ),
          itemCount: ShopCubit.get(context).catogriesModel!.data!.data.length),
    );
  }

  Widget buildCatoegriesItem(DataModel? dataModel) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            height: 120,
            width: 120,
            image: NetworkImage(dataModel!.image),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            dataModel.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
