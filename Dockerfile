FROM python:3.11.4-bullseye

WORKDIR /app

# Installing dependencies
RUN pip install --user poetry
ENV PATH="/root/.local/bin:${PATH}"

#COPY poetry.lock /app/
COPY pyproject.toml /app/

RUN poetry lock
RUN poetry install

# Copy core project
COPY docs /app/docs
COPY src /app/src
