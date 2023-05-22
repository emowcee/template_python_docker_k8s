Sure, here's a README.md for the above:

---
# Simple Flask App Deployment on Kubernetes

This project demonstrates how to containerize a simple Flask application, build a Docker image, and deploy it on a Kubernetes cluster.

## Getting Started

These instructions will guide you to run this project on your local machine for development and testing purposes.

### Prerequisites

Ensure you have the following installed on your local system:

- Python 3.9
- Docker
- Kubernetes (Minikube for local development)
- kubectl

### Clone the repository

```sh
git clone https://github.com/your_username/flask-on-k8s.git
cd flask-on-k8s
```

Replace `your_username` with your actual GitHub username.

### Application Setup

The Flask application is defined in the `app.py` file and the required modules are listed in `requirements.txt`.

```python
# app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0')
```

### Containerization

We use Docker to containerize our application. The `Dockerfile` describes the image to be built.

```Dockerfile
# Dockerfile
# Start from a base Python 3.9 image
FROM python:3.9

# Set working directory in the container
WORKDIR /app

# Add requirements file to the working directory
ADD requirements.txt .

# Install the application dependencies
RUN pip install -r requirements.txt

# Add the rest of the code
ADD . /app

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
```

Build the Docker image with the following command:

```sh
docker build -t your_username/flask-image:latest .
```

Push the image to DockerHub:

```sh
docker push your_username/flask-image:latest
```

Replace `your_username` with your DockerHub username.

### Kubernetes Deployment

The `flask-deployment.yaml` file describes the Kubernetes Deployment and Service.

```yaml
# Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: flask-app
  template:
    metadata:
      labels:
        app: flask-app
    spec:
      containers:
      - name: flask-app
        image: your_username/flask-image:latest
        ports:
        - containerPort: 5000

---
# Service
apiVersion: v1
kind: Service
metadata:
  name: flask-service
spec:
  selector:
    app: flask-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 5000
  type: LoadBalancer
```

Apply the deployment with `kubectl`:

```sh
kubectl apply -f flask-deployment.yaml
```

## Testing

Check if the Pods, Deployment, and Service are running:

```sh
kubectl get pods
kubectl get deployment
kubectl get service
```

The output should show the `flask-app` deployment, the 3 pods, and the `flask-service`. Access the application by entering the external IP of the `flask-service` in your web browser.

---

I hope this helps! Let me know if you have any questions.
