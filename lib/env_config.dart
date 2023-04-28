enum EnvName {
  dev,

  prod,

  sit,

  uat,
}

class Env {
  // get env name
  static EnvName get envName => EnvName.values.byName(
        const String.fromEnvironment(
          'FLUTTER_ENV_NAME',
          defaultValue: 'dev',
        ),
      );

  // get pocketbase url
  static String get pbUrl => const String.fromEnvironment('FLUTTER_PB_URL');
}
