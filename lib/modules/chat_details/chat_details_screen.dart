import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/components.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailsScreen({this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
     builder: (BuildContext context){
       HomeCubit.get(context).getMessage(receiverId: userModel.uId);
       return  BlocConsumer<HomeCubit, HomeStates>(
         listener: (context, state) {
           // TODO: implement listener
         },
         builder: (context, state) {
           return Scaffold(
             backgroundColor: Colors.white,
             appBar: AppBar(
               titleSpacing: 0.0,
               leading: TextButton(
                 onPressed: () {
                   Navigator.pop(context);
                 },
                 child: Icon(
                   Icons.arrow_back_ios,
                   color: Colors.black,
                   size: 20,
                 ),
               ),
               title: Row(
                 // crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   CircleAvatar(
                     radius: 18,
                     backgroundImage: NetworkImage('${userModel.image}'),
                   ),
                   SizedBox(
                     width: 8,
                   ),
                   Text(userModel.name),
                 ],
               ),
             ),
             body: ConditionalBuilder(
               condition: HomeCubit.get(context).message.length >0,
               builder: (context)=> Padding(
                 padding: const EdgeInsets.all(20),
                 child: Column(
                   children: [
                     Expanded(
                       child: ListView.separated(
                           itemBuilder: (context,index){
                             var message = HomeCubit.get(context).message[index];
                             if( HomeCubit.get(context).userModel.uId == message.senderId)
                               return buildMyMessage(message);
                             return buildMessage(message);
                           },
                           separatorBuilder:(context,index) => SizedBox(height: 8),
                           itemCount:  HomeCubit.get(context).message.length,
                       ),
                     ),
                     Container(
                       height: 40,
                       clipBehavior: Clip.antiAliasWithSaveLayer,
                       decoration: BoxDecoration(
                         border: Border.all(
                           color: Colors.grey,
                         ),
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child: Row(
                         children: [
                           Expanded(
                             child: Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 8),
                               child: TextFormField(
                                 controller: messageController,
                                 decoration: InputDecoration(
                                   border: InputBorder.none,
                                   hintText: 'write your message here...',
                                 ),
                               ),
                             ),
                           ),
                           Container(
                             height: 40,
                             child: MaterialButton(
                               minWidth: 1,
                               onPressed: () {
                                 HomeCubit.get(context).sentMessage(
                                   receiverId: userModel.uId,
                                   text: messageController.text,
                                   dateTime: DateTime.now().toString(),
                                 );
                                 print(messageController.text);
                                 messageController.clear();
                               },
                               child: Icon(
                                 Icons.send,
                                 color: Colors.white,
                               ),
                               color: Colors.blue,
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               fallback: (context)=> Center(child: CircularProgressIndicator()),
             ),
           );
         },
       );
     },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
    alignment: Alignment.centerLeft,
    child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Text(model.text)),
  );
  Widget buildMyMessage(MessageModel model) =>  Align(
    alignment: Alignment.centerRight,
    child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child: Text(model.text)),
  );
}
