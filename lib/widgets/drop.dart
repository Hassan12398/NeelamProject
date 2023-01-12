//  Container(
//             height: 60,
//             decoration: BoxDecoration(
//                 color: gerror == '' ? Colors.transparent : Colors.red,
//                 // border: Border.all(
//                 //   color: Colors.black,
//                 // ),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 15,
//                       offset: Offset(0, 2),
//                       spreadRadius: 0)
//                 ],
//                 borderRadius: BorderRadius.circular(15)),
//             child: Card(
//               elevation: 0,
//               borderOnForeground: true,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 12),
//                 child: Center(
//                     child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Icon(
//                       Icons.person,
//                       color: Colors.green,
//                     ),
//                     Container(
//                       width: 200,
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                             isExpanded: true,
//                             isDense: true,
//                             value: valuechanges,
//                             items: [
//                               DropdownMenuItem(
//                                   value: '',
//                                   child: Text(
//                                     'Select gender',
//                                     style: TextStyle(
//                                       fontFamily: 'Poppins',
//                                       fontSize: ConstanceData.SIZE_TITLE16,
//                                       color: AllCoustomTheme
//                                           .getBlackAndWhiteThemeColors(),
//                                     ),
//                                   )),
//                               ...genderList.map<DropdownMenuItem<String>>((e) {
//                                 return DropdownMenuItem(
//                                   child: Text(e),
//                                   value: e,
//                                 );
//                               }),
//                             ],
//                             onChanged: (v) {
//                               print(v);
//                               setState(() {
//                                 valuechanges = v!;
//                               });
//                             }),
//                       ),
//                     ),
//                   ],
//                 )),
//               ),
//             ),
//           ),

