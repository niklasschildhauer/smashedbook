# Use an official Node runtime as a parent image
FROM node:14

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in package.json
RUN npm install

# Make port 30005 available to the world outside this container
EXPOSE 30005

# Run the app when the container launches
CMD ["node", "index.js"]
