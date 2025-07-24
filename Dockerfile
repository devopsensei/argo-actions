FROM node:18-slim

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Optional: skip CI warning during build
RUN CI=false npm run build

EXPOSE 3000

RUN npm install -g serve
CMD ["serve", "-s", "build", "-l", "3000"]
