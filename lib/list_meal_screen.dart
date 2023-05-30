import 'package:flutter/material.dart';
import 'package:responsi_ife/detail_screen.dart';
import 'package:responsi_ife/model/meals_model.dart';

import 'api_data_source.dart';

class ListMealScreen extends StatelessWidget {
  final String category;
  const ListMealScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Meal'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadMealByCategory(category),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something Went Wrong!!'),
            );
          }
          if (snapshot.hasData) {
            MealsModel mealsModel = MealsModel.fromJson(snapshot.data);
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: mealsModel.meals!.length,
              itemBuilder: (context, index) {
                Meals meals = mealsModel.meals![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScren(idMeal: meals.idMeal!),
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
                            meals.strMealThumb!,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            meals.strMeal!,
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
