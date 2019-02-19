import 'string_base.dart';

// 中文
mixin StringZh on StringBase {
  @override
  String get appName => '基础框架';

  @override
  String get pushToLoad => '上拉加载更多哦～'; //上拉加载
  @override
  String get releaseToLoad => '释放即可加载呦～'; //释放加载
  @override
  String get loading => '正在加载，O(∩_∩)O哈哈～'; //加载中
  @override
  String get loaded => '加载完成，\(^o^)/'; //加载完成
  @override
  String get noMore => '————  别翻啦，木有了～  ————'; //没有更多
  @override
  String get loadError => '加载失败，点击重试哦～'; //加载失败
  @override
  String get loadErrorClickRetry => loadError; //加载失败，点击重试
  @override
  String get noDataYet => '暂时没有数据呦～(づ￣3￣)づ╭❤～'; //暂时没有数据呦~(づ￣3￣)づ╭❤～

  @override
  String get all => '全部';

  @override
  String get ok => '确定';

  @override
  String get cancel => '取消';

  @override
  String get prompt => '提示';

  @override
  String get skip => '跳过';

  @override
  String get exitApp => '再按一次退出应用';

  @override
  String get noNetwork => '暂无网络连接，请连接网络后重试';

  @override
  String get networkError => '网络异常，请稍后重试';

  @override
  String get apiParameterError => '接口参数错误';

  @override
  String get dataParsingFailed => '数据解析失败';

  @override
  String get man => '男';

  @override
  String get woman => '女';

  @override
  String get login => '登录';

  @override
  String get logout => '退出登录';

  @override
  String get inputPhone => '输入手机号码';

  @override
  String get pleaseInputPhone => '请输入手机号码';

  @override
  String get inputPassword => '输入密码';

  @override
  String get pleaseInputPassword => '请输入密码';

  @override
  String get inputCode => '输入验证码';

  @override
  String get pleaseInputCode => '请输入验证码';

  @override
  String get register => '注册';

  @override
  String get getCode => '获取验证码';

  @override
  String get forgotPassword => '忘记密码';

  @override
  String get rewriteTheAccess => '重新获取';

  @override
  String get resetPassword => '重置密码';

  @override
  String get submit => '提交';

  @override
  String get head => '头像';

  @override
  String get gender => '性别';

  @override
  String get phone => '手机号';

  @override
  String get nickName => '昵称';

  @override
  String get retrievePassword => '找回密码';

  @override
  String get modify => '修改';

  @override
  String get edit => '编辑';

  @override
  String get release => '发布';

  @override
  String get search => '搜索';

  @override
  String get filter => '筛选';

  @override
  String get select => '选择';
}
