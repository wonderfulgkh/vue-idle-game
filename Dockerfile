# Build stage
FROM docker.io/library/node:18-alpine as build
# FROM node:18-alpine as build
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project files
COPY . .

# Build the project
RUN npm run build

# Production stage
FROM node:18-alpine

WORKDIR /app

# Install a simple HTTP server to serve static files
RUN npm install -g http-server

# Copy built files from build stage
COPY --from=build /app/dist ./dist

# Expose port
EXPOSE 8080

# Start the server
CMD ["http-server", "dist", "-p", "8080", "-c-1"]
