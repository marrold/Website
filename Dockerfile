FROM python:3.7-buster

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      python3-dev libxml2-dev libxslt1-dev libffi-dev git glpk-utils postgresql-client \
      libx11-xcb1 libxcomposite1 \
      libxcursor1 libxdamage1 libxi6 libxtst6 libnss3 libcups2 \
      libxrandr2 libasound2 libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install pipenv

COPY Pipfile Pipfile.lock Makefile /app/
WORKDIR /app

RUN make update
RUN pipenv run pyppeteer-install

ENV SHELL=/bin/bash
ENTRYPOINT ["./docker/dev_entrypoint.sh"]
