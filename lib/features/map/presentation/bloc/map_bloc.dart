import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:myapp/core/error/failures.dart';
import 'package:myapp/features/map/domain/usecases/get_current_location.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetCurrentLocation getCurrentLocation;

  MapBloc({required this.getCurrentLocation}) : super(MapInitial()) {
    on<GetCurrentLocationEvent>(_onGetCurrentLocation);
  }

  Future<void> _onGetCurrentLocation(
    GetCurrentLocationEvent event,
    Emitter<MapState> emit,
  ) async {
    emit(MapLoading());
    final failureOrLocation = await getCurrentLocation();
    failureOrLocation.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(const MapError('Could not fetch location. Please check your device location settings.'));
        } else {
          emit(const MapError('An unexpected error occurred.'));
        }
      },
      (location) {
        log('Location fetched: ${location.latitude}, ${location.longitude}');
        emit(MapLoaded(initialPosition: LatLng(location.latitude, location.longitude)));
      },
    );
  }
}
