import 'package:get/get.dart';
import 'network_manager.dart';

class HomeApi extends NetworkManager {
  static HomeApi get to => Get.find();

/*


  /// 로그인....`
  Future<bool> reqLogin(var params) async {
    var userModel = UserModel();

    try {
      final response =
      await HttpUtil.getDio().post('shem/login.sm', data: params);

      if (response.data['rtnCd'] == "00") {
        userModel = UserModel.fromJson(response.data['rtnData']['userInfo']);

        GlobalService.to.authToken = userModel.tokn;

        HttpUtil.setToken(token: userModel.tokn);
        await Utils.getStorage.write('userId', params['userId']);
        await Utils.getStorage.write('userPw', params['userPw']);
        await Utils.getStorage.write('authToken', userModel.tokn);
        GlobalService.to.setLoginInfo(userModel: userModel);
        return true;
      } else {
        Utils.gErrorMessage('${response.data['rtnMsg']}', title: '로그인 실패');
      }
    } on DioError catch (e) {
      Get.log('reqTest - login error');
      //commonError(e);
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 신고유형 불러오기
  Future<List<dynamic>> reqReportType() async {
    List<dynamic> typeModelList = [];

    var params = {
      'cdGrp': "PRPS_TYPE_CD",
    };

    try {
      final response = await HttpUtil.getDio()
          .post('cmon/code/searchCmonCdList.sm', data: params);

      if (response.data['rtnCd'] == "00") {
        for (int i = 0; i < response.data['rtnData']['result'].length; i++) {
          typeModelList.add(response.data['rtnData']['result'][i]);
        }

        return typeModelList;
      } else {
        Utils.gErrorMessage('Data Load Fail!', title: '신고유형 불러오기 실패');
      }
    } on DioError catch (e) {
      Get.log('reqTest - type error');
      //commonError(e);
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return typeModelList;
  }

  /// 신고장소 불러오기
  Future<List<dynamic>> reqReportPlace() async {
    List<dynamic> placeModelList = [];

    var params = {
      'cdGrp': "PLACE1_CD",
    };

    try {
      final response = await HttpUtil.getDio()
          .post('cmon/code/searchCmonCdList.sm', data: params);

      if (response.data['rtnCd'] == "00") {
        for (int i = 0; i < response.data['rtnData']['result'].length; i++) {
          placeModelList.add(response.data['rtnData']['result'][i]);
        }

        return placeModelList;
      } else {
        Utils.gErrorMessage('Data Load Fail!', title: '신고유형 불러오기 실패');
      }
    } on DioError catch (e) {
      Get.log('reqTest - place error');
      //commonError(e);
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return placeModelList;
  }

  /// 신고라인 불러오기
  Future<List<dynamic>> reqReportLine() async {
    List<dynamic> lineModelList = [];

    var params = {
      'cdGrp': "PLACE2_CD",
    };

    try {
      final response = await HttpUtil.getDio()
          .post('cmon/code/searchCmonCdList.sm', data: params);

      if (response.data['rtnCd'] == "00") {
        for (int i = 0; i < response.data['rtnData']['result'].length; i++) {
          lineModelList.add(response.data['rtnData']['result'][i]);
        }

        return lineModelList;
      } else {
        Utils.gErrorMessage('Data Load Fail!', title: '신고유형 불러오기 실패');
      }
    } on DioError catch (e) {
      Get.log('reqTest - line error');
      //commonError(e);
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return lineModelList;
  }

  /// 조직트리 불러오기.
  Future<OrganizationTreeModel> reqOrganizationTree() async {
    var organizationTreeModel = OrganizationTreeModel();

    Get.log('organizationTreeModelList');

    try {
      if (APP_CONST.LOCAL_JSON_MODE) {
        Get.log('로컬모드 제이슨없어 ㅠ');
        // var urlPath = 'assets/json/login.json';
        // final jsonResponse = await localJsonPaser(urlPath);
        // loginModel = LoginModel.fromJson(jsonResponse);
      } else {
        Get.log('서버모드');
        final response = await HttpUtil.getDio()
            .get('ses/cmon/searchOrgTree.sm' //, queryParameters: params
        );
        organizationTreeModel = OrganizationTreeModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      Get.log('reqTest - tree error');
      //commonError(e);
    } catch (err) {
      Get.log('reqOrganizationTree = ${err.toString()}');
    }
    return organizationTreeModel;
  }

  /// 조직도 불러오기.
  Future<OrganizationModel> reqOrganization() async {
    var organizationModel = OrganizationModel();

    Get.log('organizationModelList');

    try {
      if (APP_CONST.LOCAL_JSON_MODE) {
        Get.log('로컬모드 제이슨없어 ㅠ');
        // var urlPath = 'assets/json/login.json';
        // final jsonResponse = await localJsonPaser(urlPath);
        // loginModel = LoginModel.fromJson(jsonResponse);
      } else {
        Get.log('서버모드');

        final response = await HttpUtil.getDio()
            .get('ses/cmon/searchOrgPersonTree.sm' //, queryParameters: params
        );
        organizationModel = OrganizationModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      Get.log('reqTest - tree map error');
      //commonError(e);
    } catch (err) {
      Get.log('reqOrganization = ${err.toString()}');
    }
    return organizationModel;
  }

  /// 안전신문고 제보하기.
  Future<bool> reqReport({required var formData}) async {
    try {
      Dio _dio = await HttpUtil.getDio();
      _dio.options.headers['Content-Type'] = 'multipart/form-data';

      final response =
      await _dio.post('sps/api/proposal/register.sp', data: formData);

      if (response.data['rtnCd'] == "00") {
        _dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '신고하기 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - report error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 신고 내역 불러오기.
  Future<List<dynamic>> reqReportList(params) async {
    List<dynamic> reportList = [];
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/getList.sp', data: params);


      if (response.data['rtnCd'] == "00") {
        for (int i = 0;
        i < response.data['rtnData']['resultList'].length;
        i++) {
          if (params['stepCd'] == '10') {
            if (response.data['rtnData']['resultList'][i]['statusCd'] ==
                '0200') {
              reportList.add(response.data['rtnData']['resultList'][i]);
            }
          } else if (params['stepCd'] == '20') {
            if (response.data['rtnData']['resultList'][i]['statusCd'] ==
                '0300') {
              reportList.add(response.data['rtnData']['resultList'][i]);
            }
          } else if (params['stepCd'] == '30') {
            if (response.data['rtnData']['resultList'][i]
            ['statusCd'] ==
                '0400' ||
                response.data['rtnData']['resultList'][i]['statusCd'] ==
                    '0500' ||
                response.data['rtnData']['resultList'][i]['statusCd'] ==
                    '0600') {
              reportList.add(response.data['rtnData']['resultList'][i]);
            }
          } else {
            if (response.data['rtnData']['resultList'][i]['statusCd'] ==
                '0700') {
              reportList.add(response.data['rtnData']['resultList'][i]);
            }
          }
        }

        return reportList;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '신고하기 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - reportlist error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return reportList;
  }

  /// 신고 상세목록 가져오기.
  Future<dynamic> reqReportDetail(params) async {
    dynamic reportData = null;
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/getDetail.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        reportData = response.data['rtnData']['detail'];

        return reportData;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '신고하기 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - detail error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return reportData;
  }

  /// 신고 진행 통계 가져오기.
  Future<dynamic> reqMyBoard(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/getStepStatus.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        Map map = Map<String, dynamic>.from(response.data['rtnData']);
        Get.log(map.toString());
        return map;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '신고하기 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - step error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return;
  }

  /// 조치 부서 배정.
  Future<bool> reqAssignTeam(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/updateActionOrg.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '담당팀 배정 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - action team error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 조치 인원 배정.
  Future<bool> reqAssignPeople(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/updateActionUser.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '담당팀 배정 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - action people error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 안전신문고 조치 등록/수정 하기.
  Future<bool> reqAction({required var formData}) async {
    try {
      Dio _dio = await HttpUtil.getDio();
      _dio.options.headers['Content-Type'] = 'multipart/form-data';

      final response = await _dio.post('sps/api/proposal/updateActionDetail.sp',
          data: formData);

      if (response.data['rtnCd'] == "00") {
        _dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '신고하기 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - action error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 조치 부서 팀장 승인 - 0600으로 이동
  Future<bool> teamLeaderAssign(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/updateActionOrgApproved.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '담당팀 배정 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - teamleader assign error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 안전직원 승인 - 0700으로 이동
  Future<bool> safetyEmpAssign(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/updateToComplete.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '담당팀 배정 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - safety emp error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 안전직원 신고 미승인
  Future<bool> notAssign(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/refuse.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '미승인 처리 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - safety emp error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  /// 작성자 신고 철회
  Future<bool> reportDrop(params) async {
    try {
      final response = await HttpUtil.getDio()
          .post('sps/api/proposal/withdraw.sp', data: params);

      if (response.data['rtnCd'] == "00") {
        return true;
      } else {
        Utils.gErrorMessage('잠시 후 다시 시도해주세요.', title: '신고 철회 실패!');
      }
    } on DioError catch (e) {
      Get.log('reqTest - safety emp error');
    } catch (err) {
      Get.log('reqLogin = ${err.toString()}');
    }

    return false;
  }

  Future<VersionModel> reqMobileVersion() async {
    var versionModel = VersionModel();

    try {
      final response = await HttpUtil.getDio().post(
        'api/public/v1/getAppInfo.sp',
      );

      if (response.data['rtnCd'] == "00") {
        versionModel = VersionModel.fromJson(response.data);

        return versionModel;
      } else {
        Utils.gErrorMessage('${response.data['rtnMsg']}', title: '버전 로드 실패');
      }
    } on DioError catch (e) {
      Get.log('reqVersion - version load error');
      //commonError(e);
    } catch (err) {
      Get.log('reqVersion = ${err.toString()}');
    }

    return versionModel;
  }

   */
}
