import 'package:boilerplate_project/myIp/models/myIp_model.dart';
import 'package:http/http.dart';

class MyIpServices {
  Future<MyIpModel> getMyIp() async {
    var url = Uri.parse("https://api.ipify.org?format=json");
    var response =
        await get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      MyIpModel myIp = myIpFromJson(response.body);
      return myIp;
    } else {
      throw 'There was an unknown error while processing the request. Please try again.';
    }
  }
}
