FROM node:8.1.2-alpine

# Set multiple labels at once, using line-continuation characters to break long lines
LABEL vendor=snow_owl \
      com.sreenath="0.0.1-beta" \
      com.sreenath.version.release-date="2017-01-01"

# Add the contents of the current working directory to /app
ADD ./package.json /tmp/package.json
RUN cd /tmp && npm install

ADD ./process.json /app/
ADD ./ /app/
RUN cp -a /tmp/node_modules /app/

# Install the required dependencies
RUN npm install pm2 -g

WORKDIR /app
# Command to start the build process
CMD ["pm2", "start", "process.json", "--no-daemon"]