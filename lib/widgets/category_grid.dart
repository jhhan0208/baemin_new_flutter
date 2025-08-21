import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../screens/search_results_screen.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '카테고리',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  '음식배달에서 더보기 >',
                  style: TextStyle(
                    color: AppColors.baeminMint,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryItem(context, categories[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, CategoryItem category) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SearchResultsScreen(searchQuery: category.name),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Icon(
              category.icon,
              color: category.color,
              size: 28,
            ),
          ),
          SizedBox(height: 8),
          Text(
            category.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class CategoryItem {
  final String name;
  final IconData icon;
  final Color color;

  CategoryItem({
    required this.name,
    required this.icon,
    required this.color,
  });
}

final List<CategoryItem> categories = [
  CategoryItem(
      name: '한그릇', icon: Icons.restaurant, color: AppColors.accentPurple),
  CategoryItem(name: '카페·디저트', icon: Icons.cake, color: Colors.pink),
  CategoryItem(
      name: '돈까스·회', icon: Icons.set_meal, color: AppColors.accentOrange),
  CategoryItem(name: '중식', icon: Icons.ramen_dining, color: Colors.brown),
  CategoryItem(name: '한식', icon: Icons.rice_bowl, color: AppColors.baeminMint),
  CategoryItem(
      name: '패스트푸드', icon: Icons.fastfood, color: AppColors.accentGreen),
  CategoryItem(
      name: '분식', icon: Icons.local_pizza, color: AppColors.accentOrange),
  CategoryItem(
      name: '양식', icon: Icons.restaurant_menu, color: AppColors.accentRed),
  CategoryItem(name: '치킨', icon: Icons.fastfood, color: AppColors.rating),
  CategoryItem(name: '찜·탕', icon: Icons.soup_kitchen, color: Colors.brown),
];
