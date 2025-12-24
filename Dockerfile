# Stage 1: Build
FROM node:20-alpine AS build

WORKDIR /app

COPY . .
RUN corepack enable
RUN yarn install

# Build the application
RUN yarn build

# Stage 2: Run
FROM nginx:alpine

# Copy nginx config template for env substitution
COPY nginx.conf /etc/nginx/templates/nginx.conf.template

# Copy build artifacts
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80 8080 8443 8446

CMD ["nginx", "-g", "daemon off;"]
