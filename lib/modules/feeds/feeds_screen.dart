import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/components/components.dart';

class FeedsScreen extends StatelessWidget {
  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: HomeCubit.get(context).posts.length > 0 && HomeCubit.get(context).userModel != null,
            builder:(context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://image.freepik.com/free-photo/living-room-interior-loft-apartment-with-armchair-concrete-wall-3d-rendering_41470-3793.jpg',
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'communicate with friends',
                            style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: HomeCubit.get(context).posts.length,
                    itemBuilder: (context, index) => buildPostItem(HomeCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context, index) => SizedBox(height: 7),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model,context,index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      '${model.image}'
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
                        Row(
                          children: [
                            Text('${model.name}'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 15,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 12,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text('${model.text}',
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    height: 1.2, fontWeight: FontWeight.w400, fontSize: 12),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Container(
              //           height: 20,
              //           child: Padding(
              //             padding: const EdgeInsetsDirectional.only(end: 8),
              //             child: MaterialButton(
              //               minWidth: 1.0,
              //               onPressed: (){},
              //               padding: EdgeInsets.zero,
              //               child: Text('#software',style: Theme.of(context).textTheme.caption.copyWith(color: Colors.blue,),),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 20,
              //           child: MaterialButton(
              //             minWidth: 1.0,
              //             onPressed: (){},
              //             padding: EdgeInsets.zero,
              //             child: Text('#flutter',style: Theme.of(context).textTheme.caption.copyWith(color: Colors.blue,),),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(model.postImage != "")
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.postImage}',
                        // 'https://image.freepik.com/free-photo/living-room-interior-loft-apartment-with-armchair-concrete-wall-3d-rendering_41470-3793.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.thumb_up_off_alt,
                              color: Colors.red,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${HomeCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chat,
                              color: Colors.amber,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('comment',
                              // '${HomeCubit.get(context).comment[index]} comment',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            '${HomeCubit.get(context).userModel.image}',
                            // 'https://image.freepik.com/free-photo/portrait-beautiful-young-woman-standing-grey-wall_231208-10760.jpg',
                          ),
                          radius: 16.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // Expanded(
                        //   child: Container(
                        //     height: 30,
                        //     child: defaultFormField(
                        //       hint: 'write a comment...',
                        //       secure: false,
                        //       onChanged: (value) => commentController.text[index] == value,
                        //       controller: commentController,
                        //       prefix: InkWell(
                        //           onTap: (){
                        //             HomeCubit.get(context).commentPosts(HomeCubit.get(context).postsId[index]);
                        //           },
                        //           child: Icon(Icons.send,size: 20),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              // HomeCubit.get(context).commentPosts(HomeCubit.get(context).postsId[index]);
                            },
                            child: Text(
                              'write a comment...',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 10),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      HomeCubit.get(context).likePosts(HomeCubit.get(context).postsId[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up_off_alt,
                            color: Colors.blue,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'like',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
