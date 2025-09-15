
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import './location_service.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService;

  LocationBloc(this._locationService) : super(LocationInitial()) {
    on<FetchLocation>((event, emit) async {
      emit(LocationLoading());
      try {
        final position = await _locationService.getCurrentPosition();
        emit(LocationLoaded(position));
      } catch (e) {
        emit(LocationError(e.toString()));
      }
    });

    on<GoToDefaultLocation>((event, emit) {
      emit(LocationLoaded(Position(
          latitude: 37.422,
          longitude: -122.084,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0)));
    });
  }
}
