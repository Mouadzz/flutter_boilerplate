import 'package:bloc_test/bloc_test.dart';
import 'package:boilerplate_project/myIp/bitcoinPrice.dart';
import 'package:boilerplate_project/myIp/services/myIp_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMyIp extends MockBloc implements MyIpServices {}

void main() {
  late MyIpServices services;
  setUp(() {
    services = MockMyIp();
  });

  group('MyIp Bloc', () {
    test('initial state is MyIpInitial', () {
      expect(
          MyIpBloc(service: MyIpServices()).state, equals(isA<MyIpInitial>()));
    });

    blocTest<MyIpBloc, MyIpState>(
      'emits [MyIpLoading] when GetMyIp is added',
      build: () => MyIpBloc(service: MyIpServices()),
      act: (bloc) => bloc.add(GetMyIp()),
      expect: () => [isA<MyIpLoading>()],
    );

    blocTest<MyIpBloc, MyIpState>(
      'emits [MyIpLoaded] when GetMyIp is added and data Arrived',
      build: () => MyIpBloc(service: MyIpServices()),
      act: (bloc) => bloc.add(GetMyIp()),
      wait: Duration(seconds: 3),
      expect: () => [isA<MyIpLoading>(), isA<MyIpLoaded>()],
    );

    blocTest<MyIpBloc, MyIpState>(
      'emits [MyIpError] when GetMyIp is added and an exception was thrown',
      build: () => MyIpBloc(service: services),
      act: (bloc) => bloc.add(GetMyIp()),
      setUp: () {
        when(() => services.getMyIp()).thenThrow(
          (_) => 'Errorrr',
        );
      },
      wait: Duration(seconds: 3),
      expect: () => [isA<MyIpLoading>(), isA<MyIpError>()],
    );
  });
}
