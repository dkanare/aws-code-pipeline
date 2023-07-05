#FROM node:14.15.0 as builder
FROM public.ecr.aws/docker/library/node:14.21.3-alpine as builder
WORKDIR /app
COPY ./package.json ./
RUN npm install --silent
RUN npm install -g @angular/cli
COPY . ./
RUN npm run build
#CMD ["npm", "start"]

## frontend
#FROM nginx:latest
FROM public.ecr.aws/docker/library/nginx:1.25
EXPOSE 3000
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html
