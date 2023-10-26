// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1_weather_app/modules/weather_screen/cubit/cubit.dart';
import 'package:flutter_application_1_weather_app/modules/weather_screen/cubit/states.dart';
import 'package:flutter_application_1_weather_app/shared/component/component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// import '../../model/current_weather_model.dart';
import '../../model/forecast_weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
  }

  List<ListElement>? todayList = [];
  List<ListElement> nextDaysList = [];
  // List<ListElement> nextDaysList = [];
  // List<num> sundayList = [];
  num tempAvg = 1;
  num sum = 0;
  int? testIndex;

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('EEEE'); // 'EEEE' gives the full day name
    String dayName = formatter.format(now);

    DateFormat apiDateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime apiDateTime = apiDateFormat.parse("2023-10-27 18:00:00");

    DateFormat formattedDateFormat = DateFormat("EEEE - HH:mm");

    return BlocConsumer<WeatherCubit, WeatherStates>(
      builder: (context, state) {
        WeatherCubit cubit = WeatherCubit.get(context);
        return Scaffold(
          body: cubit.forecastModel != null
              ? Stack(
                  children: [
                    if (cubit.currentModel!.main!.temp!.round() - 273.15 <= 23)
                      Image.asset(
                        "assets/images/darksky.jpg",
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                      )
                    else
                      Image.asset(
                        "assets/images/lightSky.jpg",
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                      ),
                    Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          cubit.forecastModel != null,
                      fallbackBuilder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      widgetBuilder: (context) => ListView(
                        children: [
                          Center(
                            child: Text(
                              "${cubit.forecastModel?.city?.country}.${cubit.forecastModel?.city?.name}",
                              style: GoogleFonts.abel(
                                fontSize: 40,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          currentTemp(cubit.currentModel!.main!, true),
                          Center(
                            child: Text(
                              cubit.currentModel?.weather?[0].description ??
                                  "error",
                              style: GoogleFonts.abel(
                                fontSize: 30,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          //current Container-----------------------------------------------------
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(255, 197, 207, 206)
                                    .withOpacity(0.3),
                              ),
                              width: double.infinity,
                              height: 200,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  String formattedDateTime =
                                      formattedDateFormat.format(
                                    todayList?[index].dtTxt ?? DateTime.now(),
                                  );
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formattedDateTime,
                                          style: GoogleFonts.abel(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (todayList![index]
                                                        .main!
                                                        .temp!
                                                        .round() -
                                                    273.15 >=
                                                22 &&
                                            todayList![index]
                                                        .main!
                                                        .temp!
                                                        .round() -
                                                    273.15 <=
                                                27)
                                          const Image(
                                            image: AssetImage(
                                                "assets/images/clear.png"),
                                            width: 50,
                                            height: 50,
                                          )
                                        else if (todayList![index]
                                                    .main!
                                                    .temp!
                                                    .round() -
                                                273.15 >
                                            27)
                                          const Image(
                                            image: AssetImage(
                                              "assets/images/hotSun.png",
                                            ),
                                            width: 50,
                                            height: 50,
                                          )
                                        else if (todayList![index]
                                                        .main!
                                                        .temp!
                                                        .round() -
                                                    273.15 <
                                                22 &&
                                            todayList![index]
                                                        .main!
                                                        .temp!
                                                        .round() -
                                                    273.15 >=
                                                18)
                                          const Image(
                                            image: AssetImage(
                                                "assets/images/raining.png"),
                                            width: 50,
                                            height: 50,
                                          )
                                        else if (todayList![index]
                                                    .main!
                                                    .temp!
                                                    .round() -
                                                273.15 <
                                            18)
                                          const Image(
                                            image: AssetImage(
                                                "assets/images/snow2.png"),
                                            width: 50,
                                            height: 50,
                                          ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          textBaseline: TextBaseline.alphabetic,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              (todayList![index].main!.temp! -
                                                      273.15)
                                                  .round()
                                                  .toString(),
                                              style: GoogleFonts.abel(
                                                  fontSize: 25,
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "C",
                                              style: GoogleFonts.abel(
                                                fontSize: 10,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 15,
                                ),
                                itemCount: todayList?.length ?? 0,
                              ),
                            ),
                          ),
                          //forecast Container-----------------------------------------------------------------------------------
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 197, 207, 206)
                                          .withOpacity(0.3),
                                ),
                                width: double.infinity,
                                height: 200,
                                child: ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    String formattedDateTime =
                                        formattedDateFormat.format(
                                      cubit.forecastModel?.list?[index].dtTxt ??
                                          DateTime.now(),
                                    );
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (cubit.forecastModel!.list![index]
                                                          .main!.temp!
                                                          .round() -
                                                      273.15 >=
                                                  22 &&
                                              cubit.forecastModel!.list![index]
                                                          .main!.temp!
                                                          .round() -
                                                      273.15 <=
                                                  27)
                                            const Image(
                                              image: AssetImage(
                                                  "assets/images/clear.png"),
                                              width: 50,
                                              height: 50,
                                            )
                                          else if (cubit.forecastModel!
                                                      .list![index].main!.temp!
                                                      .round() -
                                                  273.15 >
                                              27)
                                            const Image(
                                              image: AssetImage(
                                                  "assets/images/hotSun.png"),
                                              width: 50,
                                              height: 50,
                                            )
                                          else if (cubit
                                                          .forecastModel!
                                                          .list![index]
                                                          .main!
                                                          .temp!
                                                          .round() -
                                                      273.15 <
                                                  22 &&
                                              cubit.currentModel!.main!.temp!
                                                          .round() -
                                                      273.15 >=
                                                  18)
                                            const Image(
                                              image: AssetImage(
                                                  "assets/images/raining.png"),
                                              width: 50,
                                              height: 50,
                                            )
                                          else if (cubit.forecastModel!
                                                      .list![index].main!.temp!
                                                      .round() -
                                                  273.15 <
                                              18)
                                            const Image(
                                              image: AssetImage(
                                                  "assets/images/snow2.png"),
                                              width: 50,
                                              height: 50,
                                            ),
                                          currentTemp(
                                              cubit.forecastModel?.list?[index]
                                                  .main,
                                              false),
                                          Text(
                                            formattedDateTime,
                                            style: GoogleFonts.abel(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 5,
                                  ),
                                  itemCount:
                                      cubit.forecastModel?.list?.length ?? 0,
                                ),
                              ),
                            ),
                          ),
                          defualtTxtForm(
                              controller: searchController,
                              type: TextInputType.text,
                              label: "City",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "search must not be empty";
                                }
                                return null;
                              },
                              prefixIcon: Icons.search_rounded,
                              radius: 10,
                              fontWeight: FontWeight.bold,
                              iconColor: Colors.white,
                              fontColor: Colors.white,
                              borderColor: Colors.white.withOpacity(0.0),
                              onSubmitted: (value) {
                                if (value.isEmpty) {
                                  WeatherCubit.get(context).city = "amman";
                                  cubit.getForecastWeather();
                                  cubit.getWeather();
                                } else {
                                  todayList?.clear();
                                  WeatherCubit.get(context).city = value;
                                  cubit.getForecastWeather();
                                  cubit.getWeather();
                                }
                              }),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {
        WeatherCubit cubit = WeatherCubit.get(context);
        if (state is ForeCastWeatherSuccessState) {
          if (cubit.forecastModel != null) {
            List<ListElement> itemsToRemove = [];
            cubit.forecastModel?.list?.forEach(
              (e) {
                DateFormat format = DateFormat('EEEE');
                String dayForecast = format.format(
                  e.dtTxt ?? DateTime.now(),
                );
                if (dayForecast == dayName) {
                  todayList?.add(e);
                  itemsToRemove.add(e);
                }
              },
            );
            cubit.forecastModel?.list
                ?.removeWhere((e) => itemsToRemove.contains(e));
            print("todaylist: $todayList");
          }
        }
        if (state is WeatherErrorState) {
          Fluttertoast.showToast(
            msg: "somthing went wrong try again",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red,
            fontSize: 16,
          );
        }
      },
    );
  }

  Widget currentTemp(dynamic model, bool isCurrent) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isCurrent)
            Text(
              (model.temp! - 273.15).round().toString(),
              style: GoogleFonts.abel(
                fontSize: 70,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            )
          else
            Text(
              (model.temp! - 273.15).round().toString(),
              style: GoogleFonts.abel(
                fontSize: 40,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          Text(
            "C",
            style: GoogleFonts.abel(
              fontSize: 20,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      );
}
