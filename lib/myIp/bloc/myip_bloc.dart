import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:boilerplate_project/myIp/services/myIp_service.dart';
import 'package:boilerplate_project/myIp/models/myIp_model.dart';
import 'package:meta/meta.dart';

part 'myip_event.dart';
part 'myip_state.dart';

class MyIpBloc extends Bloc<MyIpEvent, MyIpState> {
  final MyIpServices service;

  MyIpBloc({required this.service}) : super(MyIpInitial()) {
    on<GetMyIp>(_onGetMyIp);
  }

  FutureOr<void> _onGetMyIp(GetMyIp event, Emitter<MyIpState> emit) async {
    emit(MyIpLoading());
    try {
      MyIpModel data = await service.getMyIp();
      emit(MyIpLoaded(data: data));
    } catch (e) {
      if (e is SocketException || e is HttpException) {
        emit(MyIpError(
            errorMsg:
                'It is not possible to connect to the server at this time.\nThe network connection was lost.'));
      } else {
        emit(MyIpError(errorMsg: e.toString()));
      }
    }
  }
}
