# getting base image (ubuntu)
FROM python:3.5-slim

MAINTAINER qobiljon <qobiljon.toshnazarov@gmail.com>
WORKDIR /code

COPY ./ /code/
RUN pip install -r /code/requirements.txt
CMD ["python", "server.py"]
