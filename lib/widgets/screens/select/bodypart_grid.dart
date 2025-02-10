// import 'package:flutter/material.dart';
//
// import '../../../models/ui/ncs_meta.dart';
// import 'bodypart_card.dart';
//
// class BodyPartGrid extends StatelessWidget {
//   final String selectedItem;
//   final String selectedBodyParts;
//   final NcsMetaData uiData;
//   final Function(String, String) onSubtypeSelected;
//
//   const BodyPartGrid({
//     super.key,
//     required this.selectedItem,
//     required this.selectedBodyParts,
//     required this.uiData,
//     required this.onSubtypeSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final article = uiData.articles.firstWhere((a) => a.name == selectedItem);
//     return GridView.count(
//       shrinkWrap: true,
//       crossAxisCount: 2,
//       childAspectRatio: 1.5,
//       mainAxisSpacing: 16,
//       crossAxisSpacing: 16,
//       children: article.subtypes!
//           .map((subtype) => BodyPartCard(
//                 subtype: subtype,
//                 isSelected: selectedBodyParts == subtype.name,
//                 onTap: () => onSubtypeSelected(subtype.name, subtype.id),
//               ))
//           .toList(),
//     );
//   }
// }
