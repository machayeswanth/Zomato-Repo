# Stage 1: Build the React app
FROM node:16-slim AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the built app
FROM node:16-slim

WORKDIR /app
COPY --from=builder /app/build ./build
COPY package*.json ./
RUN npm install --only=production

EXPOSE 3000
CMD ["npm", "start"]

