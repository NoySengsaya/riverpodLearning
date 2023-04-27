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
}
