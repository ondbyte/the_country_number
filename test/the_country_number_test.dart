
import 'package:the_country_number/the_country_number.dart';

main() async {
  final tmp = TheCountryNumber().parseNumber(iso2Code: "IN");
  print(tmp.toString());
}
