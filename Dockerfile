# Use the official Nginx base image
FROM nginx:latest

# Copy custom Nginx configuration file to the container (if you have one)
# Uncomment and edit the path to your configuration file if needed
# COPY ./my-nginx.conf /etc/nginx/nginx.conf

# Expose the default Nginx port
EXPOSE 80

# Optionally, you can add a default index.html file to the container
# COPY ./index.html /usr/share/nginx/html/index.html

# Start Nginx service
CMD ["nginx", "-g", "daemon off;"]
