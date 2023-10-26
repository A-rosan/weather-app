abstract class WeatherStates {}

class WeatherInitialState extends WeatherStates {}

class WeatherLoadingState extends WeatherStates {}

class WeatherSuccessState extends WeatherStates {}

class WeatherErrorState extends WeatherStates {}

class ForeCastWeatherLoadingState extends WeatherStates {}

class ForeCastWeatherSuccessState extends WeatherStates {}

class ForeCastWeatherErrorState extends WeatherStates {}
