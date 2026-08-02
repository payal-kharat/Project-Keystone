# React MySQL Demo App

A full-stack CRUD application built with **React.js**, **Node.js (Express)**, and **MySQL**. The application is containerized using **Docker**, managed with **Docker Compose**, and the React frontend is served through **NGINX**.

---

## Features

- CRUD operations for Student records
- React frontend
- Express.js REST API
- MySQL database
- Dockerized application
- Docker Compose for multi-container deployment
- NGINX for serving the React production build

---

## Tech Stack

- React.js
- Node.js
- Express.js
- MySQL
- Docker
- Docker Compose
- NGINX

---

## Images

### Add Student

![Home Page](./Frontend/src/ss1.png)

### Add Student

![Add Student](./Frontend/src/ss2.png)

### Student Added Successfully

![Student Added](./Frontend/src/ss3.png)

### Updated Student List

![Updated Student List](./Frontend/src/ss4.png)

---

## Run Locally

### Install Dependencies

```bash
# Backend
npm install

# Frontend
cd frontend
npm install
```

### Start the Application

```bash
# Backend
node server.js

# Frontend
npm start
```

---

## Docker Deployment

Build and start all services

```bash
docker compose up --build
```

Run in detached mode

```bash
docker compose up -d
```

Stop all containers

```bash
docker compose down
```

---

## NGINX

The React application is served using **NGINX** inside the frontend container.

NGINX is responsible for:

- Serving the React production build
- Handling client-side routing
- Delivering static assets efficiently

---

## Application Architecture

```text
Browser
   │
   ▼
NGINX
   │
   ▼
React Frontend
   │
   ▼
Node.js API
   │
   ▼
MySQL Database
```

---

## Application URLs

**Frontend (AWS Application Load Balancer)**

```
http://<your-alb-dns-name>

**Backend API**

```
http://localhost:5000
```

---

## Useful Docker Commands

```bash
docker compose up --build
docker compose up -d
docker compose down
docker compose logs
docker ps
```

---

## License

This project is licensed under the MIT License.
