# Production version of web container exploiting nginx
# Use this image when building
FROM node:16-alpine as builder 

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Use this image to run server in production, here there is no need to define the phase with "as" keyword, it's the last one anyway
FROM nginx
# COPY from previous phase
COPY --from=builder /app/build /usr/share/nginx/html
# Done, with nginx no need to startup the nginx as the image will do it for us
