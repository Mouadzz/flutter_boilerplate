import 'package:boilerplate_project/app/app.dart';
import 'package:boilerplate_project/myIp/bitcoinPrice.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders myIpPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(MyIpPage), findsOneWidget);
    });
  });
}
