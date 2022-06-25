import 'package:app/model/category.dart';
import 'package:app/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../view/products.dart';

class CategoryGridView extends StatelessWidget {
  const CategoryGridView({
    Key key,
    @required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: 4 * SizeConfig.widthSizeMultiplier),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2 * SizeConfig.widthSizeMultiplier,
              mainAxisSpacing: 2.2 * SizeConfig.heightSizeMultiplier,
              childAspectRatio: .85,
            ),
            itemCount: categories == null ? 0 : categories.length,
            itemBuilder: (context, index) {
              var category = categories[index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Products(
                      category: category,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: 1.5 * SizeConfig.widthSizeMultiplier),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(
                        3 * SizeConfig.widthSizeMultiplier),
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      children: [
                        Expanded(
                          // child: Container(
                          //   decoration: BoxDecoration(
                          //     color: Colors.grey,
                          //     image: DecorationImage(
                          //       image: NetworkImage(
                          //         category.image,
                          //       ),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          child: CachedNetworkImage(
                            imageUrl: category.image,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, string, progress) =>
                                    Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.2 * SizeConfig.heightSizeMultiplier),
                          child: Text(
                            category.name,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
