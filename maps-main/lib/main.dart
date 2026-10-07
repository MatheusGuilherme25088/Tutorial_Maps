import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
    runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pontos no Mapa',
        home: MainApp(),
    ));
}

class MainApp extends StatefulWidget {
    const MainApp({super.key});

    @override
    State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
    final LatLng _pontoInicial = const LatLng(
        -22.7130000,
        -46.8180000,
    );

    LatLng? _pontoClicado;

    String mensagem = 'Clique em algum lugar no mapa';

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Obter Coordenadas no Mapa'),
            ),
            body: Column(
                children: [
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                            'Origem @${_pontoInicial.latitude}, ${_pontoInicial.longitude}',
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(mensagem),
                    ),
                    Expanded(
                        child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _pontoInicial,
                                zoom: 14,
                            ),
                            onTap: (LatLng latLng) {
                                setState(() {
                                    _pontoClicado = latLng;
                                    mensagem =
                                        'Destino: @${latLng.latitude}, ${latLng.longitude}';
                                });
                            },
                            markers: {
                                Marker(
                                    markerId: const MarkerId('origem'),
                                    position: _pontoInicial,
                                ),
                                if (_pontoClicado != null)
                                    Marker(
                                        markerId: const MarkerId('destino'),
                                        position: _pontoClicado!,
                                    ),
                            },
                        ),
                    ),
                ],
            ),
        );
    }
}