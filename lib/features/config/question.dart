import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather/weather_screen.dart';

import '../../lists/city_names.dart';
import '../../weather/weather_bloc.dart';
import '../../weather/weather_state_event.dart';

class Question extends StatefulWidget {

  const Question({Key? key}) : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final _formKey = GlobalKey<FormState>();
  static String cityName = "";
  static int count=count+1;
  late final WeatherBloc _newsBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Enter your City Name"),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    cityName = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter City Name';
                  }
                  if (!CityNames.cities.contains(value.toLowerCase())) {
                    return 'City not found';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "City Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color(0xff342800),
                      width: 4,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {

                  // ListView.builder(
                  //   itemCount: count,
                  //   itemBuilder: (context, index) {
                  //     return WeatherScreen(cityName[index]);
                  //   },
                  // );
                  
                  loadWeatherData();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeatherScreen(cityName, context),
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void loadWeatherData() {
    _newsBloc = BlocProvider.of<WeatherBloc>(context);
    _newsBloc.add(WeatherRequested(cityName));
  }

}
