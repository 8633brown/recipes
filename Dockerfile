FROM python:3.10-alpine3.15 AS tandoor_python

#Install all dependencies.
RUN apk add --no-cache postgresql-libs postgresql-client gettext zlib libjpeg libwebp libxml2-dev libxslt-dev py-cryptography openldap

#Print all logs without buffering it.
ENV PYTHONUNBUFFERED 1

#This port will be used by gunicorn.
EXPOSE 8080

#Create app dir and install requirements.
RUN mkdir /opt/recipes
WORKDIR /opt/recipes

COPY requirements.txt ./

RUN apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev zlib-dev jpeg-dev libwebp-dev openssl-dev libffi-dev cargo openldap-dev python3-dev git && \
    echo -n "INPUT ( libldap.so )" > /usr/lib/libldap_r.so && \
    pip install --upgrade pip && \
    pip install wheel==0.37.1 && \
    pip install setuptools_rust==1.1.2 && \
    pip install -r requirements.txt --no-cache-dir &&\
    apk --purge del .build-deps

#Copy project and execute it.
COPY . ./
RUN chmod +x boot.sh
ENTRYPOINT ["/opt/recipes/boot.sh"]


FROM node:lts-alpine AS tandoor_node

WORKDIR /opt/recipes/vue

COPY ./vue/package.json ./vue/yarn.lock ./
RUN set -eux; \
    yarn install; \
    yarn cache clean;

COPY ./vue ./

CMD ["yarn", "watch"]
