import 'package:clima_flutter_app/screens/widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/weather_provider.dart';
import 'location_screen.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(weatherProvider);

    return Scaffold(
      body: Center(
        child: weatherData.when(
          data: (_) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LocationScreen(),
                ),
              );
            });
            return const SizedBox();
          },
          loading: () => const SpinKitDoubleBounce(
            color: Colors.white,
            size: 100,
          ),
          error: (error, stackTrace) {
            return RetryWidget(
              onPressed: () => ref.refresh(weatherProvider),
            );
          },
        ),
      ),
    );
  }
}
