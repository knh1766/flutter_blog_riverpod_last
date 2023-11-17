import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_blog/data/store/param_store.dart';
import 'package:flutter_blog/data/store/session_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

//창고데이터
class PostDetailModel {
  Post post;

  PostDetailModel(this.post);
}
//창고
//통신으로 받을거면 널이 필요없음

class PostDetailViewModel extends StateNotifier<PostDetailModel?> {
  PostDetailViewModel(super._state, this.ref);
  Ref ref;

  Future<void> notifyInit(int id) async {
    Logger().d("notifyInit");

    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO =
        await PostRepository().fetchPost(sessionUser.jwt!, id);

    state = PostDetailModel(responseDTO.data);
  }
}

//통신안할거니까 퓨처안써도 됨
//스테이트값 전달

//창고관리자 --창고관리자한테 데이터를 전달 (창고관리자가 뭔가를 하고싶을 때)
//패턴을 유지하려교 패밀리를 찾음?
//아이디가 있어야 통신하니까 패밀리가 필요

//프로바이더에서 ref를 결합한다는건
final postDetailProvider =
    StateNotifierProvider.autoDispose<PostDetailViewModel, PostDetailModel?>(
        (ref) {
  int postId = ref.read(paramProvider).postDtailId!; //이 화면에 들어오는건 널일수 ㅇ벗음?
  return PostDetailViewModel(null, ref)..notifyInit(postId);
});
