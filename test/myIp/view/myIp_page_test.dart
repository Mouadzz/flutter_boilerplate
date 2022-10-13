import 'package:bloc_test/bloc_test.dart';
import 'package:boilerplate_project/myIp/bitcoinPrice.dart';
import 'package:boilerplate_project/myIp/services/myIp_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/helpers.dart';

class MockMyIp extends MockBloc implements MyIpServices {}

void main() {
  late MyIpServices services;
  late MyIpBloc myIpBloc;
  setUp(() {
    services = MockMyIp();
    myIpBloc = MyIpBloc(service: services);
  });

  group('MyIpPage', () {
    testWidgets('renders MyIpView', (tester) async {
      await tester.pumpApp(const MyIpPage());
      expect(find.byType(MyIpView), findsOneWidget);
    });
  });

  group('MyIpView', () {
    testWidgets('renders current count', (tester) async {
      // when(() async => await services.getMyIp()).thenAnswer(
      //   (_) async => MyIpModel(ip: "42"),
      // );
      await tester.pumpApp(
        BlocProvider.value(
          value: myIpBloc,
          child: const MyIpView(),
        ),
      );
      expect(find.text("My ip address"), findsOneWidget);
    });
  });
}
