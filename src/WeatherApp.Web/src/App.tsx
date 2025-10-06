import { useState, useEffect } from 'react'
import { weatherService } from './services/weatherService'
import type { WeatherForecast } from './services/weatherService'
import './App.css'

function App() {
  const [weatherData, setWeatherData] = useState<WeatherForecast[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const fetchWeatherData = async () => {
      try {
        setLoading(true)
        setError(null)
        const data = await weatherService.getForecast()
        setWeatherData(data)
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to fetch weather data')
      } finally {
        setLoading(false)
      }
    }

    fetchWeatherData()
  }, [])

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
            {weatherData.map((forecast) => (
              <tr key={forecast.id}>
                <td>{new Date(forecast.date).toLocaleDateString()}</td>
                <td>{forecast.location}</td>
                <td>{forecast.temperatureC}°C</td>
                <td>{forecast.temperatureF}°F</td>
                <td>{forecast.summary}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}

export default App
