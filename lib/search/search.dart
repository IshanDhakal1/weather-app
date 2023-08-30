import 'package:flutter/material.dart';
import 'package:weather_app/weather/weather_screen.dart';

class Search extends SearchDelegate<String>{

  List<String> names;

  Search({required this.names,});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
          onPressed: (){
            query= '';
          },
          icon: Icon(Icons.clear)
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, '');
        },
        icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return showSearchResult();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return showSearchResult();
  }

  Widget showSearchResult(){
    List<String> searchResultList= query.isEmpty
        ? []
        : names.where((cityName) => cityName.toLowerCase()
        .contains((query.toLowerCase()))).toList();
    return Container(
      child: searchResultList.isEmpty
          ? Center(child: Text("No Result found", style: TextStyle(color: Colors.lightGreen[400]),))
          : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: searchResultList.length,
            itemBuilder: (context, index){
              String cityName= searchResultList[index];
              return WeatherScreen(cityName);
            }
          ),
    );
  }
}