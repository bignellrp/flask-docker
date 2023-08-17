# Use a base image
FROM python:3.9

# Set working directory
WORKDIR /app

# Clone the conf files into the docker container
RUN git clone --branch preprod --single-branch https://github.com/bignellrp/footyapp.git /app

# Copy the app config into the docker container
COPY gunicorn_conf.py /app/gunicorn_conf.py

# Install dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt

# Set environment variables
ENV WEB_CONCURRENCY=1
ENV PYTHONUNBUFFERED=1

# Expose port
EXPOSE 80

# Command to run the application
CMD ["gunicorn", "--conf", "gunicorn_conf.py", "--bind", "0.0.0.0:80", "main:app"]
