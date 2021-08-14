import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: defaultAppBar(
            context: context,
            title: 'new post',
            actions: [
              defaultTextButton(
                onPressed: () {
                  if(HomeCubit.get(context).postImage == null){
                    HomeCubit.get(context).createPost(
                        text: textController.text,
                        dateTime: DateTime.now().toString(),
                    );
                  }else{
                    HomeCubit.get(context).uploadPostImage(
                      text: textController.text,
                      dateTime: DateTime.now().toString(),
                    );
                  }
                },
                text: 'post',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is HomeCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is HomeCreatePostLoadingState)
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/portrait-beautiful-young-woman-standing-grey-wall_231208-10760.jpg',
                      ),
                      radius: 25.0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text('mohamed'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is in your mind',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(HomeCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Container(
                        height: 145,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image:  FileImage(HomeCubit.get(context).postImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.close,size: 17,),
                      ),
                      onPressed: (){
                        HomeCubit.get(context).removePostImage();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          HomeCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo_outlined,color: Colors.blue,size: 16,),
                            SizedBox(
                              width: 5,
                            ),
                            Text('add photos',style: TextStyle(fontSize: 10),),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('#Tags',style: TextStyle(fontSize: 10),),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
