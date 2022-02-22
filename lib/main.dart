import 'package:azkar1/cubit/cubit.dart';
import 'package:azkar1/cubit/states.dart';
import 'package:azkar1/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'constants.dart';
import 'network/local/cash_helper.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();

  bool? isDark=CashHelper.getBool(key: 'isDarkMode');
  runApp(App(isDark : (isDark==null)? false : isDark));
}

class App extends StatelessWidget {
  final bool isDark;

  App({required this.isDark}) ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AzkarCubit()..changeMode(fromShared:  isDark),
        child: BlocConsumer<AzkarCubit,AzkarStates>(
          listener: (context, state) {

          },
          builder:(context,state){

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
              theme: ThemeData(
                  appBarTheme: AppBarTheme(
                      backgroundColor: Colors.blueAccent,
                      titleTextStyle: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),



                      centerTitle: true,
                      elevation: 0
                  ),
                  primaryColor: Colors.blueAccent,
                  accentColor: Colors.lightBlue[900],
                  cardColor: Colors.lightGreen,
                  canvasColor: Colors.white,

                  scaffoldBackgroundColor: Colors.white
              ),
              darkTheme:ThemeData.dark().copyWith(
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.brown[800],
                  titleTextStyle: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 22.0,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                  ),

                  centerTitle: true,
                  elevation: 2,
                  iconTheme:IconThemeData(
                    color: Colors.grey[400],
                  ),

                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                primaryColor:Colors.black.withOpacity(.3) ,
                accentColor:Colors.black.withOpacity(.7) ,
                cardColor:Colors.black.withOpacity(.2),
                canvasColor: Colors.grey[300],
                scaffoldBackgroundColor: Colors.brown[800],

              ),
              themeMode:

              AzkarCubit.get(context).isDarkMode ? ThemeMode.light: ThemeMode.dark

              ,
            );
          },
        )
    );


  }
}
