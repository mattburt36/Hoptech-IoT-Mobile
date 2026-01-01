abstract final class ThingsboardAppConstants {
  // Hoptech ThingsBoard Server
  static const thingsBoardApiEndpoint = String.fromEnvironment(
    'thingsboardApiEndpoint',
    defaultValue: 'https://iot.hoptech.co.nz',
  );
  static const thingsboardOAuth2CallbackUrlScheme = String.fromEnvironment(
    'thingsboardOAuth2CallbackUrlScheme',
    defaultValue: 'io.hoptech.iot.auth',
  );
  static const thingsboardIOSAppSecret = String.fromEnvironment('thingsboardIosAppSecret');
  static const thingsboardAndroidAppSecret = String.fromEnvironment('thingsboardAndroidAppSecret');
  static const ignoreRegionSelection = thingsBoardApiEndpoint != '';
}
