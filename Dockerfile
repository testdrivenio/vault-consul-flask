###########
# BUILDER #
###########

# Base Image
FROM python:3.10 as builder

# Install Requirements
COPY requirements.txt /
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /wheels -r requirements.txt


#########
# FINAL #
#########

# Base Image
FROM python:3.10-slim

# Install curl
RUN apt-get update && apt-get install -y curl

# Create directory for the app user
RUN mkdir -p /home/app

# Create the app user
RUN groupadd app && useradd -g app app

# Create the home directory
ENV HOME=/home/app
ENV APP_HOME=/home/app/web
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install Requirements
COPY --from=builder /wheels /wheels
COPY --from=builder requirements.txt .
RUN pip install --no-cache /wheels/*

# Copy in the Flask code
COPY . $APP_HOME

# Chown all the files to the app user
RUN chown -R app:app $APP_HOME

# Change to the app user
USER app

# run server
CMD gunicorn --log-level=debug -b 0.0.0.0:5000 manage:app
