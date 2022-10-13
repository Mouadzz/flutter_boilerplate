import 'dart:developer';
import 'package:boilerplate_project/l10n/l10n.dart';
import 'package:boilerplate_project/myIp/bloc/myip_bloc.dart';
import 'package:boilerplate_project/myIp/services/myIp_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class MyIpPage extends StatelessWidget {
  const MyIpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyIpBloc myIpBloc = MyIpBloc(service: MyIpServices());

    return BlocProvider.value(
      value: myIpBloc,
      child: const MyIpView(),
    );
  }
}

class MyIpView extends StatefulWidget {
  const MyIpView({super.key});

  @override
  State<MyIpView> createState() => _MyIpViewState();
}

class _MyIpViewState extends State<MyIpView> {
  bool isDataLoading = false;
  String myIp = "";

  @override
  void initState() {
    context.read<MyIpBloc>().add(GetMyIp());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.myIpAppBarTitle)),
      body: BlocListener<MyIpBloc, MyIpState>(
        listener: (context, state) {
          setState(() {
            isDataLoading = (state is MyIpLoading);
          });
          if (state is MyIpError) {
            log(state.errorMsg);
          } else if (state is MyIpLoaded) {
            setState(() {
              myIp = state.data.ip ?? "";
            });
          }
        },
        child: Center(
            child: isDataLoading
                ? CircularProgressIndicator()
                : Text(myIp, style: TextStyle(fontSize: 30.sp))),
      ),
    );
  }
}
