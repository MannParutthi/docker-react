# For Production environment -> Volume is not required as this is PROD env and no changes are done on the fly
# We need only the build folder in the container and not the source code for the production environment

# Stage 1 - Builder Phase -> Output will be build folder
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Stage 2 - Run Server Phase -> Use the output from Stage 1
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# No need to specify the CMD as the default CMD of nginx image is to start the nginx server


#  docker run -p 8081:80 <image_id> => to run the container with port mapping (80 => default port of nginx server)