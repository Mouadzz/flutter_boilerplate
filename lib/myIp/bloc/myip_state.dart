part of 'myip_bloc.dart';

@immutable
abstract class MyIpState {}

class MyIpInitial extends MyIpState {}

class MyIpLoading extends MyIpState {}

class MyIpLoaded extends MyIpState {
  final MyIpModel data;
  MyIpLoaded({required this.data});
}

class MyIpError extends MyIpState {
  final String errorMsg;
  MyIpError({required this.errorMsg});
}
