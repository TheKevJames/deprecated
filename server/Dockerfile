FROM python:3.6.2-alpine

EXPOSE 80
RUN apk add --no-cache build-base gcc libffi-dev linux-headers openssl-dev

COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

ENV GOOGLE_APPLICATION_CREDENTIALS /run/secrets/google_service_creds

COPY . /app

CMD ["python", "-m", "app"]
