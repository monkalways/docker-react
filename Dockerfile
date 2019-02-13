FROM node:alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install > /dev/null
COPY . .
RUN npm run builder

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]