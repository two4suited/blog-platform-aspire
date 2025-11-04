import { AnonymousAuthenticationProvider } from '@microsoft/kiota-abstractions';
import { FetchRequestAdapter } from '@microsoft/kiota-http-fetchlibrary';
import { createWeatherApiClient } from '../client/weatherApiClient.ts';

// Create an anonymous authentication provider (no auth required)
const authProvider = new AnonymousAuthenticationProvider();

// Create the HTTP adapter with the auth provider
const adapter = new FetchRequestAdapter(authProvider);

// Set the base URL for your API
// Uses '/api' to leverage Vite's proxy configuration for local development
adapter.baseUrl = '/api';

// Create and export the configured client
export const weatherApiClient = createWeatherApiClient(adapter);