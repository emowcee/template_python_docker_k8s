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
