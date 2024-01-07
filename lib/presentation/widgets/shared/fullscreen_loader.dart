import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando películas',
      'Cargando palomitas de maíz',
      'Cargando populares',
      'Llamando a mi crush',
      'Esto está tardando más de lo esperado :('
    ];

    return Stream.periodic(const Duration(milliseconds: 2000), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Espere por favor',
          style: textStyle.titleMedium,
        ),
        const SizedBox(height: 30),
        CircularProgressIndicator(
          strokeWidth: 2,
          color: colors.primary,
        ),
        const SizedBox(height: 30),
        StreamBuilder(
          stream: getLoadingMessages(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text(
                'Cargando ...',
                style: textStyle.titleSmall,
              );
            }

            return Text(
              snapshot.data!,
              style: textStyle.titleSmall,
            );
          },
        )
      ],
    ));
  }
}
