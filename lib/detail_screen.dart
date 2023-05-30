import 'package:flutter/material.dart';
import 'package:responsi_ife/model/meal_detail_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'api_data_source.dart';

class DetailScren extends StatelessWidget {
  final String idMeal;
  const DetailScren({super.key, required this.idMeal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Detail'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadMealDetail(idMeal),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something Went Wrong!!'),
            );
          }
          if (snapshot.hasData) {
            MealDetailModel detailMeal =
                MealDetailModel.fromJson(snapshot.data);
            Meals meal = detailMeal.meals!.first;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      meal.strMeal!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(meal.strMealThumb!),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Category : ${meal.strCategory!}'),
                  Text('Area : ${meal.strArea!}'),
                  const SizedBox(height: 20),
                  Text(meal.strInstructions!),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () => _launchUrl(meal.strYoutube!),
                      child: const Text('Lihat Youtube'),
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> _launchUrl(String mealUrl) async {
    Uri url = Uri.parse(mealUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
