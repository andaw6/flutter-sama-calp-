import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/users/user.dart';
import 'package:wave_odc/models/users/user_info.dart';
import 'package:wave_odc/pages/shared_pages/transfer_form_page/transfer_form_page.dart';
import 'package:wave_odc/services/user/user_service.dart';

abstract class ScannerEvent {}
class StartScan extends ScannerEvent {}
class StopScan extends ScannerEvent {}
class CodeScanned extends ScannerEvent {
  final String code;
  CodeScanned(this.code);
}

abstract class ScannerState {}
class ScannerInitial extends ScannerState {}
class ScannerScanning extends ScannerState {}
class ScannerSuccess extends ScannerState {
  final String code;
  ScannerSuccess(this.code);
}

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(ScannerInitial()) {
    on<StartScan>((event, emit) => emit(ScannerScanning()));
    on<StopScan>((event, emit) => emit(ScannerInitial()));
    on<CodeScanned>((event, emit) => emit(ScannerSuccess(event.code)));
  }
}

class QRCodeScannerPage extends StatelessWidget {
  QRCodeScannerPage({super.key});
  final _authService = locator<UserService>();
  final logger = Logger();

  void veriry(BuildContext context,String code) async{
      UserInfo? user = await _authService.findById(id: code);
      logger.i("Test QRCode");
      logger.i(user);
      if(user != null){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransferFormPage(userInfo: user),
          ),
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScannerBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scanner QR Code'),
        ),
        body: BlocBuilder<ScannerBloc, ScannerState>(
          builder: (context, state) {
            if (state is ScannerSuccess) {
              logger.i(state.code);
              veriry(context, state.code);

              return ResultDisplay(code: state.code);
            }
            return QRViewExample();
          },
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: _buildQrView(context),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Scannez un QR Code pour effectuer un transfert'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            cameraController.toggleTorch();
                            final torchState = cameraController.torchState.value;
                            final isTorchOn = torchState == TorchState.on;
                            print(isTorchOn ? 'Flash On' : 'Flash Off');
                          },
                          child: Text('Flash'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () => cameraController.switchCamera(),
                          child: Text('Changer de caméra'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return MobileScanner(
      controller: cameraController,
      onDetect: (capture) {
        final List<Barcode> barcodes = capture.barcodes;
        for (final barcode in barcodes) {
          if (barcode.rawValue != null) {
            context.read<ScannerBloc>().add(CodeScanned(barcode.rawValue!));
            break;
          }
        }
      },
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}

extension on MobileScannerController {
  get torchState => null;
}

class ResultDisplay extends StatelessWidget {
  final String code;

  const ResultDisplay({Key? key, required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'QR Code Scanné',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 20),
          Text(
            'Contenu: $code',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 40),
          ElevatedButton(
            child: Text('Scanner à nouveau'),
            onPressed: () {
              context.read<ScannerBloc>().add(StartScan());
            },
          ),
        ],
      ),
    );
  }
}
