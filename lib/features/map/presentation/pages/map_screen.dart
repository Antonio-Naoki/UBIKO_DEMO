
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:myapp/core/config/theme/app_colors.dart';
import 'package:myapp/features/map/presentation/bloc/map_bloc.dart';
import 'package:myapp/injection_container.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  bool _isMapReady = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => sl<MapBloc>()..add(GetCurrentLocationEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ubiko App',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 4.0,
          actions: [
            // Placeholder for future theme toggle if needed
          ],
        ),
        body: BlocConsumer<MapBloc, MapState>(
          listener: (context, state) {
            if (state is MapLoaded && _isMapReady) {
              _mapController.move(state.initialPosition, 15.0);
            }
          },
          builder: (context, state) {
            if (state is MapLoading || state is MapInitial) {
              return const _LoadingWidget(message: 'Encontrar tu ubicación...');
            } else if (state is MapLoaded) {
              return FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: state.initialPosition,
                  initialZoom: 15.0,
                  onMapReady: () {
                    setState(() {
                      _isMapReady = true;
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: state.initialPosition,
                        child: _PulsingMarker(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is MapError) {
              return _ErrorWidget(
                message: state.message,
                onRetry: () {
                  context.read<MapBloc>().add(GetCurrentLocationEvent());
                },
              );
            } else {
              return _ErrorWidget(
                message: 'Se produjo un error inesperado. Por favor inténtalo de nuevo.',
                onRetry: () {
                  context.read<MapBloc>().add(GetCurrentLocationEvent());
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.read<MapBloc>().add(GetCurrentLocationEvent());
          },
          tooltip: 'Recenter Location',
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          icon: const Icon(Icons.my_location),
          label: const Text('Recenter'),
        ),
      ),
    );
  }
}

class _PulsingMarker extends StatefulWidget {
  final Color color;
  const _PulsingMarker({required this.color});

  @override
  State<_PulsingMarker> createState() => _PulsingMarkerState();
}

class _PulsingMarkerState extends State<_PulsingMarker> with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        children: [
          FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeOut,
              ),
            ),
            child: ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 2.5).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeOut,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withOpacity(0.4),
                ),
              ),
            ),
          ),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryTextColor,
              border: Border.all(color: widget.color, width: 3),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  final String message;
  const _LoadingWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off_outlined,
              size: 80,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 24),
            Text(
              'Error',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Intentar otra vez'),
              style: ElevatedButton.styleFrom(
                foregroundColor: theme.colorScheme.onError,
                backgroundColor: theme.colorScheme.error,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
