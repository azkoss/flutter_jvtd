import 'package:flutter/material.dart';
import 'dart:convert';

class ProvincesBean {
  String id;
  String parentId;
  String name;
  String mergerName;
  String shortName;
  String mergerShortName;
  String levelType;
  String cityCode;
  String zipCode;
  String pinyin;
  String jianPin;
  String firstChar;
  String lng;
  String lat;
  String remarks;

  ProvincesBean({
    this.id,
    this.parentId,
    this.name,
    this.mergerName,
    this.shortName,
    this.mergerShortName,
    this.levelType,
    this.cityCode,
    this.zipCode,
    this.pinyin,
    this.jianPin,
    this.firstChar,
    this.lat,
    this.lng,
    this.remarks,
  });

  factory ProvincesBean.fromJson(Map<String, dynamic> json) => ProvincesBean(
      id: json['ID'] as String,
      parentId: json['ParentId'] as String,
      name: json['Name'] as String,
      mergerName: json['MergerName'] as String,
      shortName: json['ShortName'] as String,
      mergerShortName: json['MergerShortName'] as String,
      levelType: json['levelType'] as String,
      cityCode: json['CityCode'] as String,
      zipCode: json['ZipCode'] as String,
      pinyin: json['Pinyin'] as String,
      jianPin: json['Jianpin'] as String,
      firstChar: json['FirstChar'] as String,
      lng: json['lng'] as String,
      lat: json['Lat'] as String,
      remarks: json['Remarks'] as String);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ID': this.id,
        'ParentId': this.parentId,
        'Name': this.name,
        'MergerName': this.mergerName,
        'ShortName': this.shortName,
        'MergerShortName': this.mergerShortName,
        'levelType': this.levelType,
        'CityCode': this.cityCode,
        'ZipCode': this.zipCode,
        'Pinyin': this.pinyin,
        'Jianpin': this.jianPin,
        'FirstChar': this.firstChar,
        'lng': this.lng,
        'Lat': this.lat,
        'Remarks': this.remarks
      };

  static empty() {}
}

/// 省份数据工具类
typedef OnObtainSuccess = void Function(List<ProvincesBean> provincesBeans, List<List<ProvincesBean>> cityBeans, List<List<List<ProvincesBean>>> areaBeans);

typedef OnObtainFailed = void Function();

class OnObtainCallback {
  final OnObtainSuccess onObtainSuccess;
  final OnObtainFailed onObtainFailed;
  OnObtainCallback(this.onObtainSuccess, this.onObtainFailed);
}

class ProvincesUtil {
  // 工厂模式
  factory ProvincesUtil() => _getInstance();

  static ProvincesUtil get instance => _getInstance();
  static ProvincesUtil _instance;

  ProvincesUtil._internal() {
    // 初始化
  }

  static ProvincesUtil _getInstance() {
    if (_instance == null) {
      _instance = new ProvincesUtil._internal();
    }
    return _instance;
  }

  static const String CHINA_NAME = "assets/china.json";

  static const String CHINA_LEVEL = "0";
  static const String PROVINCE_LEVEL = "1";
  static const String CITY_LEVEL = "2";
  static const String AREA_LEVEL = "3";

  static const String BJ_ID = "110000"; //北京
  static const String TJ_ID = "120000"; //天津
  static const String HE_ID = "130000"; //河北
  static const String SX_ID = "140000"; //山西
  static const String NM_ID = "150000"; //内蒙古
  static const String LN_ID = "210000"; //辽宁
  static const String JL_ID = "220000"; //吉林
  static const String HL_ID = "230000"; //黑龙江
  static const String SH_ID = "310000"; //上海
  static const String JS_ID = "320000"; //江苏
  static const String ZJ_ID = "330000"; //浙江
  static const String AH_ID = "340000"; //安徽
  static const String FJ_ID = "350000"; //福建
  static const String JX_ID = "360000"; //江西
  static const String SD_ID = "370000"; //山东
  static const String HA_ID = "410000"; //河南
  static const String HB_ID = "420000"; //河北
  static const String HN_ID = "430000"; //湖南
  static const String GD_ID = "440000"; //广东
  static const String GX_ID = "450000"; //广西
  static const String HI_ID = "460000"; //海南
  static const String CQ_ID = "500000"; //重庆
  static const String SC_ID = "510000"; //四川
  static const String GZ_ID = "520000"; //贵州
  static const String YN_ID = "530000"; //云南
  static const String XZ_ID = "540000"; //西藏
  static const String SN_ID = "610000"; //陕西
  static const String GS_ID = "620000"; //甘肃
  static const String QH_ID = "630000"; //青海
  static const String NX_ID = "640000"; //宁夏
  static const String XJ_ID = "650000"; //新疆
  static const String TW_ID = "710000"; //台湾
  static const String HK_ID = "810000"; //香港
  static const String MO_ID = "820000"; //澳门
  static const String DYD_ID = "900000"; //钓鱼岛

  static const List<String> WIPEOFF_DYD = [DYD_ID]; //去除钓鱼岛
  static const List<String> WIFEOFF_GHT = [TW_ID, HK_ID, MO_ID, DYD_ID]; //去除港澳台

  ProvincesBean provincesBean;
  List<ProvincesBean> provincesBeans;
  List<List<ProvincesBean>> cityBeans;
  List<List<List<ProvincesBean>>> areaBeans;
  bool isCreate = false;

  List<String> _mWipeOffProvinces = WIPEOFF_DYD;
  bool _isUpdate = false;
  bool _isSort = false;
  bool _isMunicipal = false;

  ProvincesUtil wipeOffProvinces(List<String> wipeOffProvincesBeans) {
    _mWipeOffProvinces = wipeOffProvincesBeans ?? [];
    _isUpdate = true;
    return this;
  }

  ProvincesUtil isSort(bool sort) {
    _isSort = sort;
    _isUpdate = true;
    return this;
  }

  ProvincesUtil isMunicipal(bool municipal) {
    _isMunicipal = municipal;
    _isUpdate = true;
    return this;
  }

  bool isWipeOffProvince(String id) {
    for (int i = 0; i < _mWipeOffProvinces.length; i++) {
      if (_mWipeOffProvinces[i] == id) {
        return true;
      }
    }
    return false;
  }

  Future getProvincesData(BuildContext context, OnObtainCallback callback) async {
    if (provincesBeans != null && provincesBeans.length > 0 && cityBeans != null && cityBeans.length > 0 && areaBeans != null && areaBeans.length > 0 && !_isUpdate) {
      if (callback != null) callback.onObtainSuccess(provincesBeans, cityBeans, areaBeans);
    } else {
      try {
        _isUpdate = false;
        provincesBeans = [];
        cityBeans = [];
        areaBeans = [];

        String jsonStr = await DefaultAssetBundle.of(context).loadString(CHINA_NAME);
        List jsonList = json.decode(jsonStr);
        List<ProvincesBean> beans = jsonList.map((item) {
          return ProvincesBean.fromJson(item);
        }).toList();

        List<ProvincesBean> pBeans = [];
        List<ProvincesBean> cBeans = [];
        List<ProvincesBean> aBeans = [];

        beans.forEach((item) {
          if (item.levelType == PROVINCE_LEVEL && !isWipeOffProvince(item.id)) {
            pBeans.add(item);
          } else if (item.levelType == CITY_LEVEL) {
            cBeans.add(item);
          } else if (item.levelType == AREA_LEVEL) {
            aBeans.add(item);
          } else if (item.levelType == CHINA_LEVEL) {
            provincesBean = item;
          }
        });

        if (_isSort) {
          pBeans.sort((lhs, rhs) {
            return lhs.jianPin.compareTo(rhs.jianPin);
          });
        }

        provincesBeans = pBeans;

        provincesBeans.forEach((item) {
          String provincesID = item.id; //省份ID
          List<ProvincesBean> oneProvincesCityBeans = [];
          List<List<ProvincesBean>> oneProvincesAreaBeans = [];
          for (int i = 0; i < cBeans.length; i++) {
            ProvincesBean cityBean = cBeans[i];
            String cityID = cityBean.id;
            if (cityBean.parentId == provincesID) {
              List<ProvincesBean> oneCityAreaBeans = [];
              oneProvincesCityBeans.add(cityBean);
              for (int i1 = 0; i1 < aBeans.length; i1++) {
                ProvincesBean areaBean = aBeans[i1];
                if (areaBean.parentId == cityID) {
                  oneCityAreaBeans.add(areaBean);
                  aBeans.removeAt(i1);
                  i1--;
                }
              }
              oneProvincesAreaBeans.add(oneCityAreaBeans);
              cBeans.removeAt(i);
              i--;
            }
          }
          areaBeans.add(oneProvincesAreaBeans);
          cityBeans.add(oneProvincesCityBeans);
        });

        if (_isMunicipal) {
          List<List<ProvincesBean>> tempBeans = [];
          for (int i = 0; i < cityBeans.length; i++) {
            List<ProvincesBean> items = cityBeans[i];
            bool replace = false;
            int replaceIndex = 0;
            String pId = '';
            for (int j = 0; j < items.length; j++) {
              ProvincesBean bean = items[j];
              if (bean.parentId == BJ_ID || bean.parentId == TJ_ID || bean.parentId == SH_ID || bean.parentId == CQ_ID) {
                replace = true;
                replaceIndex = j;
                pId = bean.parentId;
                break;
              }
            }
            if (replace) {
              List<ProvincesBean> chinaTempBeans = [];
              for (ProvincesBean bean in areaBeans[i][replaceIndex]) {
                bean.parentId = pId;
                chinaTempBeans.add(bean);
              }
              tempBeans.add(chinaTempBeans);
            } else {
              tempBeans.add(items);
            }
          }
          cityBeans = tempBeans;
        }
        isCreate = true;
      } catch (e) {
        isCreate = false;
      }

      if (isCreate) {
        callback.onObtainSuccess(provincesBeans, cityBeans, areaBeans);
      } else {
        callback.onObtainFailed();
      }
    }
  }

  //是否为直辖市
  static bool isMunicipality(ProvincesBean province) {
    return province.id == BJ_ID || province.id == TJ_ID || province.id == SH_ID || province.id == CQ_ID;
  }
}
