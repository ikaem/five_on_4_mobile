import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_screens_key_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/auto_route/auto_route_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

// TODO this is very temp
// TODO this needs testing

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        key: AuthScreensKeyConstants.REGISTER_SCREEN.value,
        child: Scaffold(
          // TODO there is no back icon here for some reason - i guess go router is configured incorrectly
          appBar: AppBar(
            title: const Text("Register"),
          ),
          body: Column(
            children: [
              const Text(
                "Register Screen",
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO navigate to login screen
                  // context.go("/non-auth/login");
                  // TODO this should work too?
                  // context.go("/non-auth");
                  context.navigateTo(const LoginRoute());
                },
                child: const Text("Login"),
              ),
            ],
          ),
        )
        // child: const Text(
        //   "Register Screen",
        // ),
        );
  }
}


/* 


              switch (fullPath) {
                case "/non-auth/register":
                  return "/non-auth/register";
                default:
                  return "/non-auth/";
              }




 */





/*



              if (fullPath == "/non-auth/register") {
                return "/non-auth/register";
              }

              return "/non-auth";





  */