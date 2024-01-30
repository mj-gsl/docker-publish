# Stage 1: Node.js-Basisimage zum Bauen der App
FROM node:lts as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY ./ ./
RUN npm run build
# Stage 2: Serve the app with Nginx
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
