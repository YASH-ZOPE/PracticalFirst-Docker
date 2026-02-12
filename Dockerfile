# Step 1: Use official nginx base image
FROM nginx:alpine

# Step 2: Remove default nginx html
RUN rm -rf /usr/share/nginx/html/*

# Step 3: Copy our HTML file
COPY index.html /usr/share/nginx/html/

# Step 4: Expose port 80
EXPOSE 80

# Step 5: Start nginx
CMD ["nginx", "-g", "daemon off;"]
