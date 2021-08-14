import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).users.length > 0,
          builder: (context)=> ListView.separated(
            itemBuilder: (context,index) =>buildChatItem(context,HomeCubit.get(context).users[index]),
            separatorBuilder: (context,index)=> myDivider(),
            itemCount: HomeCubit.get(context).users.length,
            physics: BouncingScrollPhysics(),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(context,UserModel model) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(userModel: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              '${model.image}',
              // 'https://image.freepik.com/free-photo/portrait-beautiful-young-woman-standing-grey-wall_231208-10760.jpg',
            ),
            radius: 25.0,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model.name}'),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
