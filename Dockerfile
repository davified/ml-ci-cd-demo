# Use an official Python runtime as a parent image
FROM python:3.5-jessie

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app
ADD ./gcp_ml_ci_cd_demo.json /app/

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

EXPOSE 8888

# Run app.py when the container launches
CMD ["python", "train.py"]
