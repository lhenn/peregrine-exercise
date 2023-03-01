FROM python:3.10-bullseye

RUN echo "=== Installing OS dependencies..." \
  && apt update -y \
  && apt install -y --no-install-recommends \
  build-essential \
  software-properties-common \
  curl \
  libpq-dev

#
# Complete the Dockerfile so it can run the simple Flask webapp
#