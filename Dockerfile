FROM python:3
WORKDIR /opt/app-data
COPY requirements.txt /opt/app-data
RUN pip install --no-cache-dir -r requirements.txt

FROM ubuntu
CMD echo "docker is running"
