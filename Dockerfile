FROM python:3.10-bullseye

RUN echo "=== Installing OS dependencies..." \
  && apt update -y \
  && apt install -y --no-install-recommends \
  build-essential \
  software-properties-common \
  curl \
  libpq-dev

WORKDIR /app
COPY requirements.txt .
COPY app.py .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
#TODO update this to be a secretmanager secret
ENV DB_HOST=prd-peregrine.ct8sm8simg2y.us-east-1.rds.amazonaws.com 
ENV DB_PORT=5432
ENV DB_NAME=peregrine
#TODO update this to be a secretmanager secret
ENV DB_USER=peregrine 
#TODO update this to be a secretmanager secret
ENV DB_PASSWORD=kOljW25YbWipFW5Xl322 

CMD ["sh", "-c", "flask run --port=${DB_PORT:-5000}"]
