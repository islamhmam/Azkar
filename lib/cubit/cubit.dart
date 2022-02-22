import 'package:azkar1/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/local/cash_helper.dart';

class AzkarCubit extends Cubit<AzkarStates>{
  AzkarCubit() : super(InitialState());

  static AzkarCubit get(context)=> BlocProvider.of(context);

  bool isDarkMode=false;



  void changeMode({bool? fromShared}){
print('chang mode 1');
    if(fromShared != null){
      isDarkMode=fromShared;
      print('chang mode 2');


    }else {
      isDarkMode = !isDarkMode;
      print('chang mode 3');

    }
    CashHelper.putBool(key: 'isDarkMode', value: isDarkMode).then((value) {
      print('chang mode 4');

      emit(ChangeModeState());

    });


  }





}