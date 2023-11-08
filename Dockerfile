FROM node:21-alpine as builder

WORKDIR /app

COPY package.json package-lock.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.25-alpine

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 3000
