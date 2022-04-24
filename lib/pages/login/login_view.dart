import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'package:fluffychat/config/themes.dart';
import 'package:fluffychat/widgets/layouts/login_scaffold.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'login.dart';

class LoginView extends StatelessWidget {
  final LoginController controller;

  const LoginView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !controller.loading,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: Text(
          L10n.of(context)!.logInTo(Matrix.of(context)
              .getLoginClient()
              .homeserver
              .toString()
              .replaceFirst('https://', '')),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Builder(builder: (context) {
        return AutofillGroup(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  readOnly: controller.loading,
                  autocorrect: false,
                  autofocus: true,
                  onChanged: controller.checkWellKnownWithCoolDown,
                  controller: controller.usernameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  style: FluffyThemes.loginTextFieldStyle,
                  autofillHints:
                      controller.loading ? null : [AutofillHints.username],
                  decoration: FluffyThemes.loginTextFieldDecoration(
                    prefixIcon: const Icon(
                      Icons.account_box_outlined,
                      color: Colors.black,
                    ),
                    errorText: controller.usernameError,
                    hintText: L10n.of(context)!.emailOrUsername,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  readOnly: controller.loading,
                  autocorrect: false,
                  autofillHints:
                      controller.loading ? null : [AutofillHints.password],
                  controller: controller.passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: !controller.showPassword,
                  onSubmitted: controller.login,
                  style: FluffyThemes.loginTextFieldStyle,
                  decoration: FluffyThemes.loginTextFieldDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outlined,
                      color: Colors.black,
                    ),
                    errorText: controller.passwordError,
                    suffixIcon: IconButton(
                      tooltip: L10n.of(context)!.showPassword,
                      icon: Icon(
                        controller.showPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.black,
                      ),
                      onPressed: controller.toggleShowPassword,
                    ),
                    hintText: L10n.of(context)!.password,
                  ),
                ),
              ),
              Hero(
                tag: 'signinButton',
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: controller.loading
                        ? null
                        : () => controller.login(context),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white.withAlpha(200),
                      onPrimary: Colors.black,
                      shadowColor: Colors.white,
                    ),
                    child: controller.loading
                        ? const LinearProgressIndicator()
                        : Text(L10n.of(context)!.login),
                  ),
                ),
              ),
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.white)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      L10n.of(context)!.or,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const Expanded(child: Divider(color: Colors.white)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed:
                      controller.loading ? () {} : controller.passwordForgotten,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white.withAlpha(156),
                    onPrimary: Colors.red,
                    shadowColor: Colors.white,
                  ),
                  child: Text(L10n.of(context)!.passwordForgotten),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
