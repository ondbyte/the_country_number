import 'package:the_country_number/the_country_number.dart';

void main(){
  //String to parse (internationalNumber)
  final s = "+915656565656";
  //
  //String to parse (dialCode)
  final b = "+91";
  //
  //get details about s
  final sNumber = TheCountryNumber().parseNumber(internationalNumber: s);
  //check if the value is actually a TheNumber
  if(sNumber.isNotANumber()){
    //not a TheNumber
    return;
  }
  print(sNumber.isValidLength); //prints true
  print(sNumber.country.englishName);//prints india
  print(sNumber.hasNumber);//prints true
  //
  //get details about s
  final bNumber = TheCountryNumber().parseNumber(dialCode: b);
  //check if the value is actually a TheNumber
  if(bNumber.isNotANumber()){
    //not a TheNumber
    return;
  }
  print(bNumber.isValidLength); //prints false
  print(bNumber.country.englishName);//prints india
  print(bNumber.hasNumber);//prints false
}