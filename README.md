![header](https://i.imgur.com/oSU3rY0.png)
# the_country_number
A small library for flutter written in pure dart (doesn't use libphonenumber) which parses a phone number or iso2 code of a country to give you some vitals about the country *(thanks for everyone who contributed to the data [here](https://gist.github.com/Goles/3196253))*
#### go *[here](https://github.com/ondbyte/the_country_number_widgets)* for a flutter input widget which is based on this

*if you need to skip null-safety, use version 0.9.0*

this library is a singleton so you can use the library right-away
```dart
final theNumber = TheCountryNumber().parse();
```
if you have the complete international number as string
```dart
//a united arab emirates number
final _numberString = "+971565656565";
final theNumber = TheCountryNumber().parse(internationalNumber:_numberString);
print(theNumber.dialCode);//prints +971
print(theNumber.number);//prints 565656565
```
further the parsed number contains a `TheCountry` object which provides some useful vitals
```dart
final country = theNumber.country;
print(country.englishName);//prints United Arab Emirates
print(country.localName);//prints دولة الإمارات العربية المتحدة (hope spelling is correct)
print(country.currency);//prints AED
//etc
```
you can parse `TheNumber` with other properties as well, but the number component will be missing
```dart
final theNumber = TheCountryNumber().parseNumber(iso2Code: "IN");
print(theNumber.dialCode);//prints the international dial-code for this country "+91"
print(theNumber.number); //prints empty
//access country details
final country = theNumber.country;
print(country.englishName);//prints India
print(country.localName);//prints भारत (hope spelling is correct)
print(country.currency);//prints INR
```
further you can parse realtime in flutter on input data changed
```dart
final numberWithCountryDetails = TheCountryNumber().parse(iso2Code:"AE");
//parse realtime when data is available
onChanged(s){
  ///consider s = "565656565";
  if(s.isEmpty()){
    return;
  }
  final newNumber = numberWithCountryDetails.addNumber(s);
  //check if the length is valid for the given country
  if(newNumber.isValidLength){
    //do something
    print(newNumber.dialCode);//prints +971
    print(newNumber.internationalNumber);//prints +971565656565
  }
}
```
*keep in mind that some countries support phone numbers of multiple lengths, which is supported too*

final theNumber = TheCountryNumber().parse();
```
if you have the complete international number as string
```dart
//a united arab emirates number
final _numberString = "+971565656565";
final theNumber = TheCountryNumber().parse(internationalNumber:_numberString);
print(theNumber.dialCode);//prints +971
print(theNumber.number);//prints 565656565
```
further the parsed number contains a `TheCountry` object which provides some useful vitals
```dart
final country = theNumber.country;
print(country.englishName);//prints United Arab Emirates
print(country.localName);//prints دولة الإمارات العربية المتحدة (hope spelling is correct)
print(country.currency);//prints AED
//etc
```
you can parse `TheNumber` with other properties as well, but the number component will be missing
```dart
final theNumber = TheCountryNumber().parseNumber(iso2Code: "IN");
print(theNumber.dialCode);//prints the international dial-code for this country "+91"
print(theNumber.number); //prints empty
//access country details
final country = theNumber.country;
print(country.englishName);//prints India
print(country.localName);//prints भारत (hope spelling is correct)
print(country.currency);//prints INR
```
further you can parse realtime in flutter on input data changed
```dart
final numberWithCountryDetails = TheCountryNumber().parse(iso2Code:"AE");
//parse realtime when data is available
onChanged(s){
  ///consider s = "565656565";
  if(s.isEmpty()){
    return;
  }
  final newNumber = numberWithCountryDetails.addNumber(s);
  //check if the length is valid for the given country
  if(newNumber.isValidLength){
    //do something
    print(newNumber.dialCode);//prints +971
    print(newNumber.internationalNumber);//prints +971565656565
  }
}
```
*keep in mind that some countries support phone numbers of multiple lengths, which is supported too*


Note: This license has also been called the "New BSD License" or "Modified BSD License". See also the 2-clause BSD License.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

<a href="https://www.buymeacoffee.com/ondbyte" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

Copyright 2020 www.yadunandan.xyz
### sponsored by www.bigmints.com
