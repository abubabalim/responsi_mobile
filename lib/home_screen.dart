import 'package:flutter/material.dart';
import 'package:responsi_ife/api_data_source.dart';
import 'package:responsi_ife/list_meal_screen.dart';
import 'package:responsi_ife/model/category_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Category'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadCategory(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something Went Wrong!!'),
            );
          }
          if (snapshot.hasData) {
            CategoryModel ctgModel = CategoryModel.fromJson(snapshot.data);
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: ctgModel.categories!.length,
              itemBuilder: (context, index) {
                Categories category = ctgModel.categories![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListMealScreen(category: category.strCategory!),
                      ),
                    );
                  },
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            category.strCategoryThumb!,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            category.strCategory!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
