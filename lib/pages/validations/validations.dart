class ValidateInputs{
  
 static bool isValid(String input, String type) {
    if (type == 'phone') {
      return input.length == 10 || input.length == 13;
    } else {
      return input.length >= 4;
    }
  }
  // bool isValid( input, String type) {
  //   if (type == 'phone') {
  //     return input.length == 10 || input.length == 13;
  //   } else {
  //     return input.length >= 4;
  //   }
  // }
}