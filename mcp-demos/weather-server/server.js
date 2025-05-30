import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';

// Simple weather data for demo purposes
const WEATHER_DATA = {
  'seattle': {
    temp: 55,
    condition: 'Rainy',
    humidity: 85,
    wind: '10 mph SW',
    forecast: 'Rain continuing throughout the week'
  },
  'los angeles': {
    temp: 75,
    condition: 'Sunny',
    humidity: 40,
    wind: '5 mph W',
    forecast: 'Clear skies for the next 5 days'
  },
  'new york': {
    temp: 62,
    condition: 'Partly Cloudy',
    humidity: 60,
    wind: '15 mph NE',
    forecast: 'Scattered clouds, possible rain tomorrow'
  },
  'miami': {
    temp: 82,
    condition: 'Humid',
    humidity: 75,
    wind: '8 mph E',
    forecast: 'Hot and humid with afternoon thunderstorms'
  },
  'chicago': {
    temp: 48,
    condition: 'Windy',
    humidity: 55,
    wind: '20 mph NW',
    forecast: 'Cold front moving in, temperatures dropping'
  },
  'denver': {
    temp: 45,
    condition: 'Clear',
    humidity: 30,
    wind: '12 mph W',
    forecast: 'Clear and cold, possible snow in mountains'
  }
};

class WeatherServer {
  constructor() {
    this.server = new Server(
      {
        name: 'weather-server',
        version: '1.0.0',
      },
      {
        capabilities: {
          tools: {},
        },
      }
    );

    this.setupHandlers();
  }

  setupHandlers() {
    // List available tools
    this.server.setRequestHandler(ListToolsRequestSchema, async () => ({
      tools: [
        {
          name: 'get_weather',
          description: 'Get current weather for a city',
          inputSchema: {
            type: 'object',
            properties: {
              city: {
                type: 'string',
                description: 'The city name (e.g., "Seattle", "New York")',
              },
            },
            required: ['city'],
          },
        },
        {
          name: 'list_cities',
          description: 'List all available cities with weather data',
          inputSchema: {
            type: 'object',
            properties: {},
          },
        },
      ],
    }));

    // Handle tool calls
    this.server.setRequestHandler(CallToolRequestSchema, async (request) => {
      const { name, arguments: args } = request.params;

      switch (name) {
        case 'get_weather': {
          const city = args.city?.toLowerCase();
          
          if (!city) {
            return {
              content: [
                {
                  type: 'text',
                  text: 'Error: City name is required',
                },
              ],
            };
          }

          const weather = WEATHER_DATA[city];
          
          if (!weather) {
            return {
              content: [
                {
                  type: 'text',
                  text: `Weather data not available for "${args.city}". Available cities: ${Object.keys(WEATHER_DATA).join(', ')}`,
                },
              ],
            };
          }

          return {
            content: [
              {
                type: 'text',
                text: `Weather in ${args.city}:
🌡️  Temperature: ${weather.temp}°F
☁️  Condition: ${weather.condition}
💧 Humidity: ${weather.humidity}%
💨 Wind: ${weather.wind}
📅 Forecast: ${weather.forecast}`,
              },
            ],
          };
        }

        case 'list_cities': {
          const cities = Object.keys(WEATHER_DATA)
            .map(city => city.charAt(0).toUpperCase() + city.slice(1))
            .join(', ');
          
          return {
            content: [
              {
                type: 'text',
                text: `Available cities with weather data: ${cities}`,
              },
            ],
          };
        }

        default:
          return {
            content: [
              {
                type: 'text',
                text: `Unknown tool: ${name}`,
              },
            ],
          };
      }
    });
  }

  async run() {
    const transport = new StdioServerTransport();
    await this.server.connect(transport);
    console.error('Weather MCP server running on stdio');
  }
}

// Start the server
const server = new WeatherServer();
server.run().catch(console.error);