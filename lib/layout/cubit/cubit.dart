import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chates_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel userModel;

  void getUserData() {
    emit(HomeGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJason(value.data());
      emit(HomeGetUserSuccessState());
    }).catchError((error) {
      emit(HomeGetUserErrorState(error));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    Text(''),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    '',
    'Users',
    'Settings',
  ];

  void changeBottomNavBarItem(int index) {
    if (index == 2) {
      emit(HomeNewPostState());
    } else {
      currentIndex = index;
      emit(HomeChangeBottomNavState());
    }
  }

  File profileImage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(HomeProfileImagePikerSuccessState());
    } else {
      print('No image selected.');
      emit(HomeProfileImagePikerErrorState());
    }
  }

  File coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(HomeProfileImagePikerSuccessState());
    } else {
      print('No image selected.');
      emit(HomeProfileImagePikerErrorState());
    }
  }

  // String profileImageUrl = '';

  void uploadProfileImage({
    @required String phone,
    @required String name,
    @required String bio,
  }) {
    emit(HomeUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        // profileImageUrl = value;
        updateUser(phone: phone, name: name, bio: bio, image: value);
        // emit(HomeUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(HomeUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(HomeUploadProfileImageErrorState());
    });
  }

  // String coverImageUrl = '';

  void uploadCoverImage({
    @required String phone,
    @required String name,
    @required String bio,
  }) {
    emit(HomeUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        // coverImageUrl = value;
        updateUser(phone: phone, name: name, bio: bio, cover: value);
        // emit(HomeUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(HomeUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(HomeUploadCoverImageErrorState());
    });
  }

  // void updateUserImage({
  //   @required String phone,
  //   @required String name,
  //   @required String bio,
  // }) {
  //   emit(HomeUserUpdateLoadingState());
  //
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if(coverImage != null &&profileImage != null){
  //     uploadCoverImage();
  //     uploadProfileImage();
  //   }else {
  //     updateUser(
  //       phone: phone,
  //       name: name,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    @required String phone,
    @required String name,
    @required String bio,
    String image,
    String cover,
  }) {
    UserModel model = UserModel(
      phone: phone,
      name: name,
      bio: bio,
      email: userModel.email,
      uId: userModel.uId,
      image: image ?? userModel.image,
      cover: cover ?? userModel.cover,
      isVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(HomeUserUpdateErrorState());
    });
  }

  File postImage;

  Future getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(HomePostImagePikerSuccessState());
    } else {
      print('No image selected.');
      emit(HomePostImagePikerErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(HomeRemovePostImageState());
  }

  void uploadPostImage({
    @required String text,
    @required String dateTime,
  }) {
    emit(HomeCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(HomeCreatePostSuccessState());
      });
    }).catchError((error) {
      emit(HomeCreatePostErrorState());
    });
  }

  void createPost({
    @required String text,
    @required String dateTime,
    String postImage,
  }) {
    emit(HomeCreatePostLoadingState());

    PostModel model = PostModel(
      text: text,
      uId: userModel.uId,
      name: userModel.name,
      image: userModel.image,
      dateTime: dateTime,
      postImage: postImage ?? "",
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(HomeCreatePostSuccessState());
    }).catchError((error) {
      emit(HomeCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comment = [];

  void getLikePosts() {
    emit(HomeGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJason(element.data()));
        }).catchError((error) {});
      });
      emit(HomeGetPostsSuccessState());
    }).catchError((error) {
      emit(HomeGetPostsErrorState(error.toString()));
    });
  }

  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({'like': true}).then((value) {
      emit(HomeLikePostSuccessState());
    }).catchError((error) {
      emit(HomeLikePostErrorState(error.toString()));
    });
  }

  void getCommentPosts() {
    emit(HomeGetCommentPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comment').get().then((value) {
          comment.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJason(element.data()));
        }).catchError((error) {});
      });
      emit(HomeGetCommentPostsSuccessState());
    }).catchError((error) {
      emit(HomeGetCommentPostsErrorState(error.toString()));
    });
  }

  void commentPosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel.uId)
        .set({'comment': false}).then((value) {
      emit(HomeCommentPostSuccessState());
    }).catchError((error) {
      emit(HomeCommentPostErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getUsers() {
    emit(HomeGetAllUsersLoadingState());
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel.uId)
            users.add(UserModel.fromJason(element.data()));
        });
        emit(HomeGetAllUserSuccessState());
      }).catchError((error) {
        emit(HomeGetAllUserErrorState(error.toString()));
      });
  }

  void sentMessage({
    @required String receiverId,
    @required String text,
    @required String dateTime,
  }) {
    MessageModel model = MessageModel(
      text: text,
      receivedId: receiverId,
      senderId: userModel.uId,
      dateTime: dateTime,
    );

    ///set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(HomeSendMessageSuccessState());
    }).catchError((error) {
      emit(HomeSendMessageErrorState());
    });

    /// receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(userModel.uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(HomeSendMessageSuccessState());
    }).catchError((error) {
      emit(HomeSendMessageErrorState());
    });
  }

  List<MessageModel> message = [];

  void getMessage({
    @required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('message').orderBy('dateTime')
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(MessageModel.fromJason(element.data()));
      });
    });

    emit(HomeGetMessageSuccessState());
  }
}
