import { useState, useEffect } from 'react'
import { weatherApiClient } from './services/weatherService.ts';
import './App.css'
import type { WeatherForecast } from './client/models/index.ts';

function App() {
 const [forecasts, setForecasts] = useState<WeatherForecast[]>([]);
 const [loading, setLoading] = useState(true)
 const [error, setError] = useState<string | null>(null)

useEffect(() => {
  const loadForecasts = async () => {
    try {
      const data = await weatherApiClient.weatherforecast.get();
      if (data) {
        console.log('Forecast data:', data);
        setForecasts(data);
        setLoading(false);
      }
    } catch (error) {
      console.error('Failed to load weather forecasts:', error);
      setError('Failed to load weather forecasts');
      setLoading(false);
    }
  };
  
  loadForecasts();
}, []);

  if (loading) {
    return <div className="loading">Loading weather data...</div>
  }

  if (error) {
    return (
      <div className="error">
        <h2>Error</h2>
        <p>{error}</p>
        <button onClick={() => window.location.reload()}>Retry</button>
      </div>
    )
  }

  return (
    <div className="weather-app">
      <h1>Weather Forecast</h1>
      <div className="weather-table-container">
        <table className="weather-table">
          <thead>
            <tr>
              <th>Date</th>
              <th>Location</th>
              <th>Temperature (°C)</th>
              <th>Temperature (°F)</th>
              <th>Summary</th>
            </tr>
          </thead>
          <tbody>
            {forecasts.map((forecast, index) => {
              // Access data from additionalData with capitalized keys
              const data = forecast.additionalData as any;
              return (
                <tr key={data?.Id || index}>
                  <td>{data?.Date || 'N/A'}</td>
                  <td>{data?.Location || 'N/A'}</td>
                  <td>{data?.TemperatureC !== null && data?.TemperatureC !== undefined ? `${data.TemperatureC}°C` : 'N/A'}</td>
                  <td>{data?.TemperatureF !== null && data?.TemperatureF !== undefined ? `${data.TemperatureF}°F` : 'N/A'}</td>
                  <td>{data?.Summary || 'N/A'}</td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </div>
  )
}

export default App
