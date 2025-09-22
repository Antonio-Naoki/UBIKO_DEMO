import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/core/config/theme/app_colors.dart';
import './location_bloc.dart';
import './utils/custom_marker.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // The GoogleMapController is used to programmatically control the map.
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    // Sets the default location and then fetches the user's real location.
    context.read<LocationBloc>().add(GoToDefaultLocation());
    context.read<LocationBloc>().add(FetchLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubiko'),
        backgroundColor: AppColors.primaryColor, // 👈 color aquí
      ),
      body: Stack(
        children: [
          BlocConsumer<LocationBloc, LocationState>(
            listener: (context, state) {
              if (state is LocationLoaded) {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(state.position.latitude, state.position.longitude),
                    15.0,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LocationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LocationLoaded) {
                final position =
                    LatLng(state.position.latitude, state.position.longitude);

                return FutureBuilder<BitmapDescriptor>(
                  future: createUserMarker(), // 👈 icono personalizado
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                      },
                      initialCameraPosition: CameraPosition(
                        target: position,
                        zoom: 15.0,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: position,
                          infoWindow: const InfoWindow(
                            title: 'Usted está aquí',
                          ),
                          icon: snapshot.data!, // 👈 marcador personalizado
                        ),
                      },
                      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                        Factory<EagerGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                    );
                  },
                );
              } else if (state is LocationError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return const Center(
                    child: Text(
                        'Presione el botón de ubicación para obtener su ubicación.'));
              }
            },
          ),
          Positioned(
            right: 16.0,
            bottom: 110.0,
            child: FloatingActionButton(
              onPressed: () {
                context.read<LocationBloc>().add(FetchLocation());
              },
              heroTag: 'recenter',
              child: const Icon(Icons.center_focus_strong),
            ),
          ),
        ],
      ),
    );
  }
}
