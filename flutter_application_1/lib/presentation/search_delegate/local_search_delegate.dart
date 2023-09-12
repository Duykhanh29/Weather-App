import 'package:flutter/material.dart';
import 'package:flutter_application_1/logic/list_weather/list_weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitySeacrh extends SearchDelegate {
  final Function(List<String>) updateResults;

  CitySeacrh(this.updateResults);
  List<String> cities = [
    "Madrid",
    "London",
    "Berlin",
    "Paris",
    "Lisbon",
    "Manchester",
    "Munich",
    "Liverpool",
    "Califonia",
    "New York",
    "Washington DC",
    "Ha Noi",
    "Seoul"
  ];
  final listSuggestion = [
    "Madrid",
    "London",
    "Berlin",
    "Paris",
    "Lisbon",
    "Manchester",
    "Munich",
    "Liverpool",
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = cities.where((element) {
      return element.toLowerCase().contains(query.toLowerCase());
    }).toList();

    // BlocProvider.of<ListWeatherBloc>(context)
    //     .add(ListWeatherSearchTextChangedEvent(query));
    updateResults(results);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = query.isEmpty
        ? listSuggestion
        : cities.where((element) {
            return element.toLowerCase().contains(query.toLowerCase());
          }).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestion[index]),
        );
      },
      itemCount: suggestion.length,
    );
  }
}
