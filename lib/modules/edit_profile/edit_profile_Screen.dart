import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var userModel = HomeCubit.get(context).userModel;
        var profileImage = HomeCubit.get(context).profileImage;
        var coverImage = HomeCubit.get(context).coverImage;

        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'edit profile',
            actions: [
              defaultTextButton(
                onPressed: () {
                  HomeCubit.get(context).updateUser(
                      phone: phoneController.text,
                      name: nameController.text,
                      bio: bioController.text,
                  );
                },
                text: 'update',
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is HomeUserUpdateLoadingState)
                  LinearProgressIndicator(),
                  if(state is HomeUserUpdateLoadingState)
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 169,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 145,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null ? NetworkImage('${userModel.cover}') : FileImage(coverImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: CircleAvatar(
                                    radius: 20,
                                    child: Icon(Icons.camera_alt_outlined,size: 17,),
                                ),
                                onPressed: (){
                                  HomeCubit.get(context).getCoverImage();
                                },
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 43,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  radius: 37,
                                  backgroundImage: profileImage == null ? NetworkImage('${userModel.image}') : FileImage(profileImage),
                                ),
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              IconButton(
                                icon: CircleAvatar(
                                  radius: 15,
                                  child: Icon(Icons.camera_alt_outlined,size: 17,),
                                ),
                                onPressed: (){
                                  HomeCubit.get(context).getProfileImage();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(HomeCubit.get(context).profileImage != null || HomeCubit.get(context).coverImage != null)
                  Row(
                    children: [
                      if(HomeCubit.get(context).profileImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                              function: (){
                                HomeCubit.get(context).uploadProfileImage(
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  bio: bioController.text,
                                );
                              },
                              text: 'upload image',
                              color: Colors.blue,
                            ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      if(HomeCubit.get(context).coverImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                function: (){
                                  HomeCubit.get(context).uploadCoverImage(
                                    phone: phoneController.text,
                                    name: nameController.text,
                                    bio: bioController.text,
                                  );
                                },
                                text: 'upload cover',
                              color: Colors.blue,
                            ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  defaultFormField(
                    controller: nameController,
                    validate: (String value){
                      if(value.isEmpty){
                        return'name must not be empty';
                      }
                      return null;
                    },
                    textInputType: TextInputType.name,
                    secure: false,
                    hint: 'name',
                    prefix: Icon(Icons.person),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: bioController,
                    validate: (String value){
                      if(value.isEmpty){
                        return'bio must not be empty';
                      }
                      return null;
                    },
                    textInputType: TextInputType.text,
                    secure: false,
                    hint: 'bio',
                    prefix: Icon(Icons.info_outline),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller:phoneController,
                    validate: (String value){
                      if(value.isEmpty){
                        return'phone must not be empty';
                      }
                      return null;
                    },
                    textInputType: TextInputType.number,
                    secure: false,
                    hint: 'name',
                    prefix: Icon(Icons.call),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
