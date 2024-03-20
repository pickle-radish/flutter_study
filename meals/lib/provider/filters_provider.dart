import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarianFree,
  veganFree,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarianFree: false,
          Filter.veganFree: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activFilters[Filter.vegetarianFree]! && !meal.isVegetarian) {
      return false;
    }
    if (activFilters[Filter.veganFree]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
