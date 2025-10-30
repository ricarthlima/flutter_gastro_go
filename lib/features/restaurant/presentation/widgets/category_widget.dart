import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../helpers/category_model.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  const CategoryWidget({
    super.key,
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: (isSelected) ? AppColors.main : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 2, color: AppColors.main),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 6,
        children: [
          Image.asset(category.imagePath, height: 48),
          Text(
            category.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
