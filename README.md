This is a [Next.js](https://nextjs.org/) project bootstrapped with [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app).

## Getting Started


This is a Dockerized Next.js application with separate Dockerfiles for development and production.

Open the .env file and set the NEXT_PUBLIC_BACKEND_URL and NEXT_PUBLIC_META_API_KEY environment variables to the appropriate values.

NEXT_PUBLIC_BACKEND_URL=https://metanewsapi.com/
NEXT_PUBLIC_META_API_KEY=your_api_key_here
Note: You can obtain a free API key by signing up at https://metanewsapi.com/signup.

Development
To run the application in development mode, follow these steps:

Install Docker and Docker Compose if you haven't already.
Clone the repository.
Navigate to the project root directory.
Change the target and NODE_ENV in docker-compose.yml to development
Build and start the Docker containers by running docker-compose build and docker compose up -d or docker compose up
The application will be available at http://localhost:3000.
Production
To run the application in production mode, follow these steps:

Install Docker if you haven't already.
Clone the repository.
Navigate to the project root directory.
Change the target and NODE_ENV in docker-compose.yml to production
Build the Docker image by running docker-compose build and docker compose up -d or docker compose up
The application will be available at http://localhost:3000

Tests
To run the tests for this app, run the following command:

docker compose run --rm app yarn test

This will start a new container and run the tests inside it.
