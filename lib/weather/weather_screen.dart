
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/config/question.dart';
import 'weather_bloc.dart';
import 'weather_state_event.dart';

class WeatherScreen extends StatefulWidget {
  final String cityName;
  final BuildContext _previousContext;

  WeatherScreen(this.cityName, this._previousContext);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Color col = Colors.white;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Question()),
                );
              },
              icon: Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            return const Center(child: Text('Loading weather...'));
          } else if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            final weather = state.weather;

            if(weather.temperature<=18){
              col = Colors.white;
            }else if(weather.temperature>18 && weather.temperature<=32){
              col = Colors.blue;
            }else{
              col =Colors.red;
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(weather.city,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.thermostat,color: col),
                                Text('${weather.temperature}°C'),
                              ],
                            ),
                            Text(weather.description),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          }
          else if (state is WeatherError) {
            return Center(child: Text(state.error));
          }
          return Text("Something went wrong");
        },

      ),
    );
  }

  // void loadWeatherData() {
  //   _newsBloc = BlocProvider.of<WeatherBloc>(widget._previousContext);
  //   _newsBloc.add(WeatherRequested(widget.cityName));
  // }
}


// class WeatherScreen extends StatelessWidget {
//   late final   WeatherBloc _newsBloc;
//   Color col=Colors.white;
//   final String cityName;
//   WeatherScreen(this.cityName);
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     if(cityName.isEmpty){
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>Question()));
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather'),
//         centerTitle: true,
//         actions:[
//           Padding(
//             padding: const EdgeInsets.only(right: 50),
//             child: IconButton(
//               onPressed:(){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Question()));
//               },
//               icon: Icon(Icons.add, color: Colors.black),
//             ),
//           ),
//           //SizedBox(height: 10,),
//
//         ],
//
//       ),
//
//       body: BlocBuilder<WeatherBloc, WeatherState>(
//         builder: (context, state) {
//
//           if (state is WeatherInitial) {
//             return const Center(child: Text('Loading weather...'));
//           }
//           else if (state is WeatherLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           else if (state is WeatherLoaded) {
//             final weather = state.weather;
//
//             if(weather.temperature<=18){
//               col = Colors.white;
//             }else if(weather.temperature>18 && weather.temperature<=32){
//               col = Colors.blue;
//             }else{
//               col =Colors.red;
//             }
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 child: SizedBox(
//                   height: 100,
//                   width: MediaQuery.of(context).size.width,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Text(weather.city,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//                             SizedBox(height: 5,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.thermostat,color: col),
//                                 Text('${weather.temperature}°C'),
//                               ],
//                             ),
//                             Text(weather.description),
//                           ],
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           } else if (state is WeatherError) {
//             return Center(child: Text(state.error));
//           }
//           else  return Text("Something went wrong");
//         },
//       ),
//     );
//   }
//
//   loadWeatherData(BuildContext context) {
//     _newsBloc = BlocProvider.of<WeatherBloc>(context);
//     _newsBloc.add(WeatherRequested(cityName));
//
//   }
// }
