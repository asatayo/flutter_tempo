 import 'preferences/shared_preferences.dart';
String? selectedService = 'Hotel';
bool isHouse = true;
bool isRental = false;
initList() async {
   String? selectedOption = await AppData().getString("NAME");
   if(selectedOption!=null){
     selectedService = selectedOption;
   }
  isHouse = await AppData().getBool("ISHOUSE");
  isRental = await AppData().getBool("ISRENTAL");
 }