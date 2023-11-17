//1,창고데이터
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestParam {
  int? postDtailId;
  //int? commentId;

  RequestParam({this.postDtailId});
}

//2,창고(비즈니스 로직)
// 스토어에는 콘텍스트가 있는게 좋음,꺼내쓰기에

class ParamStore extends RequestParam {
  final mContext = navigatorKey.currentContext;
}

//3,창고관리자
//창고관리자니까 창고를 가지고 있음
final paramProvider = Provider<ParamStore>((ref) {
  return ParamStore();
});
