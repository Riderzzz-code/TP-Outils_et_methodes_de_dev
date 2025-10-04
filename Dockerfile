# Use base redocly image
FROM  redocly/cli AS redocly

# Define the working directory
WORKDIR /usr/src/app

# Copy the openapi file
COPY src/OpenAPI.yaml .

# Generate an HTML File
RUN redocly build-docs OpenAPI.yaml --output=index.html

# Use nginx alpine image 
FROM nginx:alpine

# expose port 80
EXPOSE 80

# Hosting the html file
COPY --from=redocly /usr/src/app/index.html /usr/share/nginx/html