import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/weather_repo.dart';
import 'package:flutter_application_1/logic/list_interested_city.dart/interested_cities_bloc.dart';
import 'package:flutter_application_1/logic/list_weather/list_weather_bloc.dart';
import 'package:flutter_application_1/presentation/search_delegate/local_search_delegate.dart';
import 'package:flutter_application_1/presentation/widgets/current_weather_card.dart';
import 'package:flutter_application_1/presentation/widgets/forecast_weather_widget.dart';
import 'package:flutter_application_1/presentation/widgets/weather_by_hours.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/list_city.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var textController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<InterestedCitiesBloc>(context)
        .add(InterestedCitiesStarted());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add city"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              BlocProvider.of<ListWeatherBloc>(context)
                  .add(ListWeatherStarted());
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              focusNode: FocusNode(),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                if (value.isEmpty) {
                  BlocProvider.of<ListWeatherBloc>(context)
                      .add(ListWeatherSearchTextChangedEvent(value));
                }
              },
              onSubmitted: (value) {
                BlocProvider.of<ListWeatherBloc>(context)
                    .add(ListWeatherSearchTextChangedEvent(value));
              },
              controller: textController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Search for cities",
                  prefixIcon: const Icon(Icons.search)),
            ),
            // IconButton(
            //     onPressed: () {
            //       showSearch(
            //           context: context,
            //           delegate: CitySeacrh(updateSearchResults));
            //     },
            //     icon: const Icon(Icons.search)),
            const SizedBox(
              height: 15,
            ),
            ListCity(),
          ],
        ),
      ),
    );
  }
}

class EnterCityWidget extends StatelessWidget {
  const EnterCityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
