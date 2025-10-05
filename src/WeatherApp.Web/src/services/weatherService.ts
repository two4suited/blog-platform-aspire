export interface WeatherForecast {
  date: string;
  temperatureC: number;
  temperatureF: number;
  summary: string;
  location: string;
}

export const weatherService = {
  async getForecast(): Promise<WeatherForecast[]> {
   const response = await fetch('/api/weatherforecast');
    if (!response.ok) {
      throw new Error('Failed to fetch weather data');
    }
    return response.json();
  }
};