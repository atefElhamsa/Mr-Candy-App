// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mr_candy/core/shared_widgets/app_bar_widget.dart';
// import 'package:mr_candy/features/home/presentation/views/widgets/best_seller_widget.dart';
//
// class CategoryDetailsScreen extends StatelessWidget {
//   const CategoryDetailsScreen({super.key, required this.title});
//
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 100.h,
//         leading: const SizedBox(),
//         flexibleSpace: AppBarWidget(name: title),
//       ),
//       body: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 2),
//         itemBuilder: (context, index) {
//           return const BestSellerWidget();
//         },
//         itemCount: 8,
//       ),
//     );
//   }
// }
