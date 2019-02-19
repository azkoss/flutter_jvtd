import 'string_base.dart';

// 英文
mixin StringEn on StringBase {
  @override
  String get appName => 'Base';

  @override
  String get pushToLoad => 'Push To Load'; //上拉加载
  @override
  String get releaseToLoad => 'Release To Load'; //释放加载
  @override
  String get loading => 'Loading...'; //加载中
  @override
  String get loaded => 'Loaded'; //加载完成
  @override
  String get noMore => 'No More'; //没有更多
  @override
  String get loadError => 'Load Error'; //加载失败
  @override
  String get loadErrorClickRetry => 'Load Error!Click Retry.'; //加载失败，点击重试
  @override
  String get noDataYet => 'No Data Yet~'; //暂时没有数据呦~(づ￣3￣)づ╭❤～
  @override
  String get all => 'All';

  @override
  String get ok => 'Ok';

  @override
  String get cancel => 'Cancel';

  @override
  String get prompt => 'Prompt';

  @override
  String get skip => 'Skip';

  @override
  String get exitApp => 'Exit App';

  @override
  String get noNetwork => 'No Network';

  @override
  String get networkError => 'Network Error';

  @override
  String get apiParameterError => 'Api Parameter Error';

  @override
  String get dataParsingFailed => 'Data Parsing Failed';

  @override
  String get man => 'Man';

  @override
  String get woman => 'Woman';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get inputPhone => 'Input Phone';

  @override
  String get pleaseInputPhone => 'Please Input Phone';

  @override
  String get inputPassword => 'Input Password';

  @override
  String get pleaseInputPassword => 'Please Input Password';

  @override
  String get inputCode => 'Input Code';

  @override
  String get pleaseInputCode => 'Please Input Code';

  @override
  String get register => 'Register';

  @override
  String get getCode => 'Get Code';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get rewriteTheAccess => 'Rewrite The Access';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get submit => 'Submit';

  @override
  String get head => 'Head';

  @override
  String get gender => 'Gender';

  @override
  String get phone => 'Ghone';

  @override
  String get nickName => 'NickName';

  @override
  String get retrievePassword => 'Retrieve Password';

  @override
  String get modify => 'Modify';

  @override
  String get edit => 'Edit';

  @override
  String get release => 'Release';

  @override
  String get search => 'Search';

  @override
  String get filter => 'Filter';

  @override
  String get select => 'Select';
}
