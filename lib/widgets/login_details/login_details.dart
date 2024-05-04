import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_flutter/auth_provider.dart';
import 'package:web_flutter/locator.dart';
import 'package:web_flutter/routing/route_names.dart';
import 'package:web_flutter/services/navigation_service.dart';
import 'package:web_flutter/utils/responsiveLayout.dart';

class LoginDetails extends StatelessWidget {
  const LoginDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFAA00FF),
            Color.fromARGB(255, 135, 90, 86),
            Color.fromARGB(255, 229, 255, 0),
          ],
        ),
      ),
      child: ResponsiveLayout(
        largeScreen: DesktopView(),
        mediumScreen: TabletView(),
        smallScreen: MobileView(),
      ),
    );
  }
}

class DesktopView extends StatelessWidget {
  const DesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            'Авторизация',
            style: TextStyle(
              color: Colors.white,
              fontSize: 80,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jura',
            ),
          ),
          Expanded(
            child: Center(
              child: LoginCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class TabletView extends StatelessWidget {
  const TabletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                'Авторизация',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jura',
                ),
              ),
              Center(
                child: LoginCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Авторизация',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jura',
                ),
              ),
              Center(
                child: LoginCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginCard extends StatelessWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = ResponsiveLayout.isSmallScreen(context);
        final isMedium = ResponsiveLayout.isMediumScreen(context);
        final double cardWidth = 957;
        final double cardHeight = 544;
        final double contentPadding = 30.0;
        final double textFieldWidth = 557;
        final double textFieldHeight = 85;
        final double buttonMinWidth = 302;
        final double buttonMinHeight = 74;
        final double titleFontSize = 40.0;
        final double subtitleFontSize = 32.0;
        final double subtitleFontSizeSmall = 25.0;
        final double buttonFontSize = 64.0;

        return Card(
          color: Color.fromRGBO(53, 50, 50, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            width: isMobile || isMedium ? 857 : cardWidth,
            height: isMobile || isMedium ? 444 : cardHeight,
            padding: EdgeInsets.all(contentPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: (isMobile) ? contentPadding / 2 : 0),
                Container(
                  width: textFieldWidth,
                  height: isMobile
                      ? textFieldHeight * 0.7
                      : isMedium
                          ? textFieldHeight * 0.7
                          : textFieldHeight,
                  child: TextFormField(
                    cursorColor: Colors.white,
                    controller: authProvider.emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile || isMedium
                          ? titleFontSize * 0.6
                          : titleFontSize,
                      fontFamily: 'Jura',
                    ),
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(216, 216, 216, 1),
                        fontSize: isMobile || isMedium
                            ? titleFontSize * 0.6
                            : titleFontSize,
                        fontFamily: 'Jura',
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(100, 100, 100, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: (isMobile) ? contentPadding / 2 : 40),
                Container(
                  width: textFieldWidth,
                  height: isMobile
                      ? textFieldHeight * 0.7
                      : isMedium
                          ? textFieldHeight * 0.7
                          : textFieldHeight,
                  child: TextFormField(
                    cursorColor: Colors.white,
                    controller: authProvider.passwordController,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile || isMedium
                          ? titleFontSize * 0.6
                          : titleFontSize,
                      fontFamily: 'Jura',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Пароль',
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(216, 216, 216, 1),
                        fontSize: isMobile || isMedium
                            ? titleFontSize * 0.6
                            : titleFontSize,
                        fontFamily: 'Jura',
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(100, 100, 100, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: (isMobile) ? contentPadding / 2 : 40),
                Text(
                  'Нет аккаунта?',
                  style: TextStyle(
                    color: Color.fromRGBO(216, 216, 216, 1),
                    fontSize: isMobile || isMedium
                        ? subtitleFontSize * 0.75
                        : subtitleFontSize,
                    fontFamily: 'Jura',
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: 'Зарегистрироваться',
                    style: TextStyle(
                      color: Color.fromRGBO(136, 51, 166, 1),
                      fontSize: isMobile
                          ? subtitleFontSizeSmall * 0.8
                          : isMedium
                              ? subtitleFontSizeSmall * 0.8
                              : subtitleFontSizeSmall,
                      fontFamily: 'Jura',
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        locator<NavigationService>().navigateTo(RegisterRoute);
                      },
                  ),
                ),
                SizedBox(height: (isMobile) ? contentPadding / 2 : 50),
                ElevatedButton(
                  onPressed: () {
                    authProvider.loginUser(context);
                  },
                  child: Text(
                    'Войти',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile || isMedium
                          ? buttonFontSize * 0.75
                          : buttonFontSize,
                      fontFamily: 'Jura',
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Color.fromRGBO(216, 216, 216, 1),
                    backgroundColor: Color.fromRGBO(100, 100, 100, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    minimumSize: Size(
                      buttonMinWidth,
                      isMobile || isMedium
                          ? textFieldHeight * 0.7
                          : buttonMinHeight,
                    ),
                  ),
                ),
                SizedBox(height: (isMobile) ? contentPadding / 2 : 0),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(53, 50, 50, 1),
      height: 70,
      width: double.infinity,
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'ооо ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontFamily: 'Jura',
                ),
              ),
              TextSpan(
                text: '"ФТ-Групп"',
                style: TextStyle(
                  color: Color.fromRGBO(142, 51, 174, 1),
                  fontSize: 35,
                  fontFamily: 'Jura',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
