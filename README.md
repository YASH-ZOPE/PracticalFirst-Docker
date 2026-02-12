# 🐳 My First Docker Application

A beginner-friendly tutorial to learn Docker by containerizing a simple HTML website using NGINX.

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Step-by-Step Guide](#step-by-step-guide)
- [Understanding Docker Concepts](#understanding-docker-concepts)
- [Container Internals](#container-internals)
- [Cleanup](#cleanup)
- [Troubleshooting](#troubleshooting)

## 🎯 Overview

This project demonstrates how to:
- Create a simple HTML webpage
- Containerize it using Docker
- Serve it using NGINX web server
- Understand port mapping and container management

**What you'll learn:**
- Docker basics
- Creating Dockerfiles
- Building Docker images
- Running containers
- Port mapping
- Container lifecycle management

## ✅ Prerequisites

Before starting, ensure you have:
- Docker Desktop installed ([Download here](https://www.docker.com/products/docker-desktop))
- Basic understanding of HTML
- Terminal/Command Prompt access

**Verify Docker installation:**
```bash
docker --version
```

## 📁 Project Structure

```
PracticalFirst-Docker/
│
├── index.html          # Your HTML webpage
├── Dockerfile          # Docker configuration
└── README.md           # This file
```

## 🚀 Step-by-Step Guide

### Step 1: Create the HTML File

Create a file named `index.html`:

```html
<!DOCTYPE html>
<html>
<head>
    <title>My First Docker App</title>
</head>
<body>
    <h1>Hello Students 🚀</h1>
    <p>This HTML page is running inside Docker!</p>
</body>
</html>
```

### Step 2: Create the Dockerfile

Create a file named `Dockerfile` (no extension):

```dockerfile
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
```

### Step 3: Build the Docker Image

Build your Docker image:

```bash
docker build -t my-html-app .
```

**Command breakdown:**
- `docker build` - Build a Docker image
- `-t my-html-app` - Tag/name the image as "my-html-app"
- `.` - Use current directory as build context

**Verify the image was created:**
```bash
docker images
```

You should see `my-html-app` in the list.

### Step 4: Run the Container

Start your container:

```bash
docker run -d -p 8080:80 --name html-container my-html-app
```

**Command breakdown:**
- `docker run` - Create and start a container
- `-d` - Run in detached mode (background)
- `-p 8080:80` - Map port 8080 (host) to port 80 (container)
- `--name html-container` - Name the container "html-container"
- `my-html-app` - Use the image we built

**Verify the container is running:**
```bash
docker ps
```

### Step 5: View Your Application

Open your browser and navigate to:

```
http://localhost:8080
```

🎉 You should see:
```
Hello Students 🚀
This HTML page is running inside Docker!
```

## 🧠 Understanding Docker Concepts

### Dockerfile Instructions Explained

| Instruction | Purpose | Example |
|-------------|---------|---------|
| `FROM` | Base image to build upon | `FROM nginx:alpine` - Uses lightweight NGINX |
| `RUN` | Execute commands during build | `RUN rm -rf /usr/share/nginx/html/*` |
| `COPY` | Copy files from host to container | `COPY index.html /usr/share/nginx/html/` |
| `EXPOSE` | Document which port the app uses | `EXPOSE 80` |
| `CMD` | Default command to run when container starts | `CMD ["nginx", "-g", "daemon off;"]` |

### Why nginx:alpine?

- **NGINX**: High-performance web server
- **alpine**: Minimal Linux distribution (~5MB vs ~100MB for Ubuntu)
- **Result**: Fast, lightweight container

### Port Mapping Explained

When you use `-p 8080:80`:
- **8080**: Port on your local machine (host)
- **80**: Port inside the container
- Traffic to `localhost:8080` → forwards to container port 80

## 🏗 Container Internals

Understanding the flow:

```
┌─────────────────────────────────────────┐
│         Your Computer (Host)            │
│                                         │
│  Browser → http://localhost:8080       │
└──────────────────┬──────────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │   Port Mapping       │
        │   8080 → 80          │
        └──────────┬───────────┘
                   │
                   ▼
┌──────────────────────────────────────────┐
│         Docker Container                 │
│                                          │
│  ┌────────────────────────────────┐     │
│  │  NGINX Web Server (Port 80)    │     │
│  │                                 │     │
│  │  Serves: index.html             │     │
│  └────────────────────────────────┘     │
│                                          │
└──────────────────────────────────────────┘
```

**Flow:**
1. Browser requests → `localhost:8080`
2. Docker maps → Container port `80`
3. NGINX receives request
4. NGINX serves `index.html`
5. Response travels back to browser

## 🛑 Cleanup

### Stop the Container
```bash
docker stop html-container
```

### Remove the Container
```bash
docker rm html-container
```

### Remove the Image (optional)
```bash
docker rmi my-html-app
```

### One-liner to Stop and Remove
```bash
docker stop html-container && docker rm html-container
```

## 🔧 Troubleshooting

### Port Already in Use
If port 8080 is busy, use a different port:
```bash
docker run -d -p 8081:80 --name html-container my-html-app
```
Then visit `http://localhost:8081`

### Container Name Conflict
If the name is taken, remove the old container:
```bash
docker rm -f html-container
```

### Can't Access localhost:8080
1. Verify container is running: `docker ps`
2. Check logs: `docker logs html-container`
3. Restart container: `docker restart html-container`

## 📚 Useful Docker Commands

| Command | Description |
|---------|-------------|
| `docker ps` | List running containers |
| `docker ps -a` | List all containers (including stopped) |
| `docker images` | List all images |
| `docker logs <container>` | View container logs |
| `docker exec -it <container> sh` | Enter container shell |
| `docker stop <container>` | Stop a container |
| `docker start <container>` | Start a stopped container |
| `docker restart <container>` | Restart a container |
| `docker rm <container>` | Remove a container |
| `docker rmi <image>` | Remove an image |

## 🎓 Next Steps

Now that you've mastered the basics, try:
1. Adding CSS styling to your HTML
2. Creating a multi-page website
3. Using environment variables
4. Creating a docker-compose.yml file
5. Pushing your image to Docker Hub

## 📝 License

This is an educational project - feel free to use and modify!

---

**🎉 Congratulations!** You've successfully dockerized your first web application!
