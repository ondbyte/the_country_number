library the_country_number;

///A library to
import 'dart:convert';

import 'data.dart';

///A small library for flutter written in pure dart (doesn't use libphonenumber)
///which parses a phone number or iso2 code of a country to give you some vitals about the country,
/// this library is a singleton so you can use the library right-away.
///
/// `final theNumber = TheCountryNumber().parse();`
///
/// just use the `TheCountryNumber()` from anywhere to access its methods
class TheCountryNumber {
  static List<_TheCountry> _countries = [];

  /// This is all the available countries this library supports, list can be found in the `data.dart` at the root of lib,
  /// if you need to do changes or add additional data please fork this [repo](https://github.com/ondbyte/the_country_number.git)
  /// and ask [me](https://github.com/ondbyte) to merge
  List<TheCountry> get countries =>
      _countries.map((e) => TheCountry(e)).toList();

  ///parse the list of countries into [_TheCountry] objects and populate [countries]
  TheCountryNumber._init() {
    final dataJ = json.decode(data) as List;
    dataJ.forEach(
      (element) {
        try {
          final c = _TheCountry._fromJson(element);
          _countries.add(c);
        } catch (e) {
          print("error parsing element $element to country");
        }
      },
    );
  }

  /// a single instance of [TheCountryNumber], no new instance will be created
  static final TheCountryNumber _countryNumber = TheCountryNumber._init();

  ///get access to the already created instance of [TheCountryNumber]
  factory TheCountryNumber() {
    return _countryNumber;
  }

  String toString2() {
    return _countries.fold("\n",
        (previousValue, element) => previousValue + element.toString() + "\n");
  }

  ///Returns a [TheNumber],
  ///
  ///Which will further contain all the vitals about the parsed country,
  ///
  ///If you use the [internationalNumber] like `+971565656565` of which `+971` is the dial-code of the country,
  ///the returned [TheNumber] will be a complete object with all the vitals about the country,
  ///
  ///```dart
  /// final _numberString = "+971565656565";`
  /// final theNumber = TheCountryNumber().parse(internationalNumber:_numberString);`
  /// print(theNumber.dialCode);//prints +971
  /// print(theNumber.number);//prints 565656565
  ///```
  ///
  /// If you use anything other than [internationalNumber] to parse for example
  /// [dialCode]
  /// [iso2Code]
  /// [iso3Code]
  /// [currency]
  /// [name]
  /// [englishName]
  /// the returned [TheNumber] will be complete without the [TheNumber.number] & [TheNumber.internationalNumber] component
  /// ```
  /// final theNumber = TheCountryNumber().parseNumber(iso2Code: "IN");
  /// print(theNumber.dialCode);//prints the international dial-code for this country "+91"
  /// print(theNumber.number); //prints empty
  /// //access country details
  /// final country = theNumber.country;
  /// print(country.englishName);//prints India
  /// print(country.localName);//prints भारत (hope spelling is correct)
  /// print(country.currency);//prints INR
  ///```
  /// If the library is unable to parse (which effectively means no data exists for the given parsable data) a [NotANumber] value
  /// will be returned, call [TheNumber.isNotANumber] to check is its a valid [TheNumber]
  TheNumber parseNumber({
    String? internationalNumber,
    String? dialCode,
    String? iso2Code,
    String? iso3Code,
    String? currency,
    String? name,
    String? englishName,
  }) {
    if (_countries.isEmpty) throw Exception("library is not initialized");
    if (!_isNullOrEmpty(internationalNumber)) {
      final tmp = _countries.firstWhere(
        (element) {
          if (_isNullOrEmpty(element.dialCode)) {
            return false;
          } else {
            return internationalNumber?.startsWith(element.dialCode) ?? false;
          }
        },
        orElse: () {
          return _TheCountry();
        },
      );
      return _getNumberForCountry(tmp,
          internationalNumber: internationalNumber);
    }

    if (!_isNullOrEmpty(dialCode)) {
      final tmp = _countries.firstWhere(
        (element) {
          if (_isNullOrEmpty(element.dialCode)) {
            return false;
          } else {
            return element.dialCode == dialCode;
          }
        },
        orElse: () {
          return _TheCountry();
        },
      );
      return _getNumberForCountry(tmp);
    }

    if (!_isNullOrEmpty(iso2Code)) {
      final tmp = _countries.firstWhere((element) {
        if (_isNullOrEmpty(element.iso2Code)) {
          return false;
        } else {
          return element.iso2Code == iso2Code;
        }
      }, orElse: () {
        return _TheCountry();
      });
      return _getNumberForCountry(tmp);
    }
    if (!_isNullOrEmpty(iso3Code)) {
      final tmp = _countries.firstWhere((element) {
        if (_isNullOrEmpty(element.iso3Code)) {
          return false;
        } else {
          return element.iso3Code == iso3Code;
        }
      }, orElse: () {
        return _TheCountry();
      });
      return _getNumberForCountry(tmp);
    }
    if (!_isNullOrEmpty(currency)) {
      final tmp = _countries.firstWhere((element) {
        if (_isNullOrEmpty(element.currency)) {
          return false;
        } else {
          return element.currency == currency;
        }
      }, orElse: () {
        return _TheCountry();
      });
      return _getNumberForCountry(tmp);
    }

    if (!_isNullOrEmpty(name)) {
      final tmp = _countries.firstWhere(
        (element) {
          if (_isNullOrEmpty(element.name)) {
            return false;
          } else {
            return element.name == name;
          }
        },
        orElse: () {
          return _TheCountry();
        },
      );
      return _getNumberForCountry(tmp);
    }

    if (!_isNullOrEmpty(englishName)) {
      final tmp = _countries.firstWhere(
        (element) {
          if (_isNullOrEmpty(element.englishName)) {
            return false;
          } else {
            return element.englishName == englishName;
          }
        },
        orElse: () {
          return _TheCountry();
        },
      );
      return _getNumberForCountry(tmp);
    }
    return NotANumber();
  }

  static bool _isNullOrEmpty(String? s) {
    if (s == null) {
      return true;
    }
    if (s.isEmpty) {
      return true;
    }
    return false;
  }

  ///[TheNumber] from [_TheCountry]
  static TheNumber _getNumberForCountry(_TheCountry country,
      {String? internationalNumber}) {
    final _number = internationalNumber != null
        ? internationalNumber.replaceFirst(country.dialCode, "")
        : "";
    return TheNumber(
      dialCode: country.dialCode,
      number: _number,
      internationalNumber: internationalNumber ?? "",
      country: TheCountry(country),
      hasNumber: internationalNumber != null,
      isValidLength: country.dialLengths.any(
        (element) => element == _number.length,
      ),
    );
  }
}

///A class having all the vitals about a Country's number, this is generally obtained by using `TheCountryNumber().parse()`
class TheNumber {
  ///The dial-code of the Country inlcluding `+` at the start for example `+91` of india or `+1` of USA,
  final String dialCode;

  ///The phone number component without any dial-code
  final String number;

  ///The phone number component with dial-code
  final String internationalNumber;

  ///The vitals of the Country the number belongs to
  final TheCountry country;

  ///Whether this [TheNumber] contains the number component
  final bool hasNumber;

  ///Whether this [TheNumber]'s number component is of correct length
  final bool isValidLength;

  ///A class having all the vitals about a Country's number, this is generally obtained by using `TheCountryNumber().parse()`
  TheNumber({
    this.hasNumber = false,
    this.isValidLength = false,
    this.dialCode = "",
    this.number = "",
    this.internationalNumber = "",
    this.country = const TheCountry(_TheCountry()),
  });

  ///Returns new [TheNumber] by populating [this] with new number provided
  TheNumber? addNumber(String number) {
    return TheCountryNumber()
        .parseNumber(internationalNumber: dialCode + number);
  }

  ///Returns new [TheNumber] by removing the [number] component
  TheNumber? removeNumber() {
    return TheCountryNumber().parseNumber(iso2Code: this.country.iso2);
  }

  bool isNotANumber() {
    return false;
  }

  @override
  String toString() {
    return '''hasNumber: $hasNumber\nvalidLength: $isValidLength\ndialCode: $dialCode\n dialCode: $dialCode\n number: $number\n internationalNumber: $internationalNumber\n$country''';
  }

  @override
  bool operator ==(Object other) {
    if (other is TheNumber) {
      return hashCode == other.hashCode;
    }
    return false;
  }

  @override
  int get hashCode => internationalNumber.hashCode;

  bool get isPlainNumber => false;

  static PlainNumber plainNumber(String number) {
    return PlainNumber(number);
  }
}

///Class having all the vitals about a Country
class TheCountry {
  final _TheCountry _country;

  ///Class having all the vitals about a Country
  const TheCountry(this._country);

  ///Returns the iso2 code of this [TheCountry]
  String get iso2 => _country.iso2Code;

  ///Returns the iso3 code of this [TheCountry]
  String get iso3 => _country.iso3Code;

  ///Returns the currency code of this [TheCountry]
  String get currency => _country.currency;

  ///Returns the capital code of this [TheCountry]
  String get capital => _country.capital;

  ///Returns the h code of this [TheCountry]
  String get englishName => _country.englishName;

  ///Returns the localName code of this [TheCountry]
  String get localName => _country.name;

  @override
  String toString() {
    return '''
      Country:
      $iso2
      $iso3
      $currency
      $capital
      $localName
      $englishName''';
  }
}

class _TheCountry {
  final String name;
  final String dialCode;
  final String iso2Code;
  final String englishName;
  final String iso3Code;
  final String currency;
  final String capital;
  final List<int> dialLengths;

  const _TheCountry({
    this.name = "",
    this.dialCode = "",
    this.iso2Code = "",
    this.englishName = "",
    this.iso3Code = "",
    this.currency = "",
    this.capital = "",
    this.dialLengths = const [],
  });

  static _fromJson(Map<String, dynamic> j) {
    try {
      final lengths = _getDialLengths(
        j["DialLength"],
      );
      return _TheCountry(
        name: j["Name"] ?? "",
        dialCode: j["DialCode"] ?? "",
        iso2Code: j["Iso2"] ?? "",
        englishName: j["EnglishName"] ?? "",
        iso3Code: j["Iso3"] ?? "",
        currency: j["Currency"] ?? "",
        capital: j["Capital"] ?? "",
        dialLengths: List.castFrom(
          lengths,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  static List<int> _getDialLengths(dynamic d) {
    try {
      if (d is String) {
        return [int.parse(d)];
      }
      if (d is int) {
        if (d == -1) {
          return [];
        }
        return [d];
      }
      if (d is Iterable) {
        return List.castFrom(d as List);
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  String toString() {
    return '''$name\n$dialCode\n$iso2Code\n$englishName\n$iso3Code\n$currency\n$capital\n$dialLengths;''';
  }
}

///A class that will be returned when parsing fails
class NotANumber extends TheNumber {
  @override
  bool isNotANumber() {
    return true;
  }
}

class PlainNumber extends TheNumber {
  final String _uNumber;

  PlainNumber(this._uNumber);

  String get number => _uNumber;

  String get internationalNumber => _uNumber;

  @override
  bool get isPlainNumber => true;
}
