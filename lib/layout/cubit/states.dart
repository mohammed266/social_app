abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class HomeGetUserLoadingState extends HomeStates{}

class HomeGetUserSuccessState extends HomeStates{}

class HomeGetUserErrorState extends HomeStates{
  final String error;

  HomeGetUserErrorState(this.error);
}

///get all users
class HomeGetAllUsersLoadingState extends HomeStates{}

class HomeGetAllUserSuccessState extends HomeStates{}

class HomeGetAllUserErrorState extends HomeStates{
  final String error;

  HomeGetAllUserErrorState(this.error);
}

///get posts
class HomeGetPostsLoadingState extends HomeStates{}

class HomeGetPostsSuccessState extends HomeStates{}

class HomeGetPostsErrorState extends HomeStates{
  final String error;

  HomeGetPostsErrorState(this.error);
}

///like posts
class HomeLikePostSuccessState extends HomeStates{}

class HomeLikePostErrorState extends HomeStates{
  final String error;

  HomeLikePostErrorState(this.error);
}

///get comment posts
class HomeGetCommentPostsLoadingState extends HomeStates{}

class HomeGetCommentPostsSuccessState extends HomeStates{}

class HomeGetCommentPostsErrorState extends HomeStates{
  final String error;

  HomeGetCommentPostsErrorState(this.error);
}

///comment posts
class HomeCommentPostSuccessState extends HomeStates{}

class HomeCommentPostErrorState extends HomeStates{
  final String error;

  HomeCommentPostErrorState(this.error);
}

class HomeChangeBottomNavState extends HomeStates{}

class HomeNewPostState extends HomeStates{}


class HomeProfileImagePikerSuccessState extends HomeStates{}

class HomeProfileImagePikerErrorState extends HomeStates{}

class HomeCoverImagePikerSuccessState extends HomeStates{}

class HomeCoverImagePikerErrorState extends HomeStates{}

class HomeUploadProfileImageSuccessState extends HomeStates{}

class HomeUploadProfileImageErrorState extends HomeStates{}

class HomeUploadCoverImageErrorState extends HomeStates{}

class HomeUploadCoverImageSuccessState extends HomeStates{}

class HomeUserUpdateLoadingState extends HomeStates{}

class HomeUserUpdateErrorState extends HomeStates{}

///create posts
class HomeCreatePostLoadingState extends HomeStates{}

class HomeCreatePostSuccessState extends HomeStates{}

class HomeCreatePostErrorState extends HomeStates{}

class HomePostImagePikerSuccessState extends HomeStates{}

class HomePostImagePikerErrorState extends HomeStates{}

class HomeRemovePostImageState extends HomeStates{}

///chat
class HomeSendMessageSuccessState extends HomeStates{}

class HomeSendMessageErrorState extends HomeStates{}

class HomeGetMessageSuccessState extends HomeStates{}

