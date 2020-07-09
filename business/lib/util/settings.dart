TempUnit _preferredTempUnit = TempUnit.F;

TempUnit getPreferredTempUnit() {
  return _preferredTempUnit;
}

/// The API deals with temperatures in degrees Celsius. If the user's preferences say they are using Fahrenheit,
/// one should display temps provided by the API through calling [getPrefTemp] and specifying the API-provided value for [degrees].
/// This will then return the temperature value converted to match the user's preferences.
double getPrefTemp(double degrees) {
  return _preferredTempUnit == TempUnit.F ? _cToF(degrees) : degrees;
}

/// The API deals with temperatures in degrees Celsius. If the user's preferences say they are using Fahrenheit,
/// one should set temps provided by the user through calling [setPrefTemp] and specifying the user-provided value for [degrees].
/// This will then return the temperature value converted to celsius (if necessary) which may then be provided to the API.
double setPrefTemp(double degrees) {
  return _preferredTempUnit == TempUnit.F ? _fToC(degrees) : degrees;
}

double _cToF(double degreesCelsius) {
  return (degreesCelsius * 9 / 5) + 32;
}

double _fToC(double degreesFahrenheit) {
  return (degreesFahrenheit - 32) * (5 / 9);
}

enum TempUnit { F, C }
