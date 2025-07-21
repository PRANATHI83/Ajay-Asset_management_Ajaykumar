# Use official Node.js image
FROM node:18

# Create app directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the backend source code
COPY . .

# Expose backend port
EXPOSE 3007

# Start the backend server
CMD ["node", "server.js"]

