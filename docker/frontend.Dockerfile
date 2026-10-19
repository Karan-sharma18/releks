
FROM node:20-bookworm-slim AS build

WORKDIR /app

# Copy package files and React path configuration
COPY package.json package-lock.json ./
COPY jsconfig.json ./

# Install dependencies
RUN npm ci

# Copy frontend source files
COPY public/ ./public/
COPY src/ ./src/
COPY readmeData/ ./readmeData/

# Build the React application
RUN npm run build

# Production stage: serve the build using Nginx
FROM nginx:alpine

COPY --from=build /app/build/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
