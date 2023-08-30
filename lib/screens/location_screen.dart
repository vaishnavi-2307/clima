import 'package:clima_flutter_app/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clima_flutter_app/utilities/constants.dart';

import 'widgets/retry_widget.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(weatherProvider).when(
            data: (weatherData) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('images/location_background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
                constraints: const BoxConstraints.expand(),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '${weatherData.temperature}',
                              style: kTempTextStyle,
                            ),
                            Text(
                              weatherData.weatherIcon,
                              style: kConditionTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          '${weatherData.weatherMessage} in ${weatherData.cityName}',
                          textAlign: TextAlign.right,
                          style: kMessageTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) {
              return RetryWidget(
                onPressed: () => ref.refresh(weatherProvider),
              );
            },
          ),
      resizeToAvoidBottomInset: false,
    );
  }
}
