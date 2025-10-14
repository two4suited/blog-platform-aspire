import "@typespec/http";

using Http;
@service(#{
  title: "Weather API",
})
@server("http://localhost:5008", "Development server")
namespace WeatherAPI;

@doc("Represents a weather forecast for a specific location and date")
model WeatherForecast {
  @doc("Unique identifier for the weather forecast")
  id: string;
  
  @doc("Date of the weather forecast")
  date: plainDate;
  
  @doc("Temperature in Celsius")
  temperatureC: int32;
  
  @doc("Temperature in Fahrenheit (calculated)")
  temperatureF: int32;
  
  @doc("Weather summary description")
  summary?: string;
  
  @doc("Geographic location of the forecast")
  location: string;
}

@doc("Standard error response")
@error
model ErrorResponse {
  @doc("Error code")
  code: string;

  @doc("Human-readable error message")
  message: string;

  @doc("Additional error details")
  details?: string;

  @doc("Timestamp when error occurred")
  timestamp: utcDateTime;

  @doc("Request ID for tracking")
  requestId?: string;
}

@doc("Bad request error") 
model BadRequestError extends ErrorResponse {
  code: "BAD_REQUEST";
}

@doc("List of weather forecasts")
model WeatherForecastList {
  @doc("Array of weather forecast items")
  items: WeatherForecast[];
}



@route("/weatherforecast")
@tag("Weather")
interface WeatherForecasts {
  /** Get all weather forecasts */
  @get 
  op listForecasts(): {
    @statusCode statusCode: 200;
    @body forecasts: WeatherForecast[];
  } | {
    @statusCode statusCode: 500;
    @body error: ErrorResponse;
  };

  /** Add a new weather forecast */
  @post
  op addForecast(
    @body forecast: WeatherForecast
  ): {
    @statusCode statusCode: 201;
    @body createdForecast: WeatherForecast;
  } | {
    @statusCode statusCode: 400;
    @body error: BadRequestError;
  } | {
    @statusCode statusCode: 500;
    @body error: ErrorResponse;
  };
}
