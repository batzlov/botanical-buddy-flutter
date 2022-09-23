import 'package:flutter/cupertino.dart';

import 'package:gartenjeden/screens/welcome.dart';
import 'package:gartenjeden/screens/authenticated/tab_navigation.dart';
import 'package:gartenjeden/services/auth_service.dart';

import '../models/user.dart';

class App extends StatefulWidget {
  const App({ Key? key }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AuthService auth = AuthService();
  late dynamic authUser;
  String authToken = "";
  var tokenWasFetched = false;

  @override
  void initState() {
    auth.getToken().then((token) {
      setState(() {
          if(token != null) {
            authToken = token;
            auth.getUserFromLocalStorage().then((user) {
              authUser = user;          
            });
            tokenWasFetched = true;
          }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(authToken != "" && tokenWasFetched) {
      return const TabNavigation();
    } else {
      return const Welcome();
    }
  }
}