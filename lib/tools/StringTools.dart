// String listToString(List<String> list){
//   if(list==null){
//     return null;
//   }
//   StringBuilder result = new StringBuilder();
//   boolean first = true;
//   //第一个前面不拼接","
//   for(String string :list) {
//     if(first) {
//       first=false;
//     }else{
//       result.append(",");
//     }
//     result.append(string);
//   }
//   return result.toString();
// }

String changeStringList(List<String> list) {
  String tempString = '';
  list.forEach((element) {
    tempString += element;
  });
  return tempString;
}

// String changeType(List<String> list) {
//   String tempString = '';
//   list.forEach((element) {
//     tempString += ' ${element}';
//   });
//   // tempString.replaceFirst(' ', '');
//   return tempString;
// }
