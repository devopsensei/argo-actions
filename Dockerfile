# Stage 1: Build the app
FROM node:18-alpine as build

WORKDIR /app

# Only copy necessary files to leverage Docker cache
COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2: Serve the app
FROM node:18-alpine

# Install serve globally (you can also include in dependencies)
RUN npm install -g serve

WORKDIR /app

COPY --from=build /app/build ./build

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]
