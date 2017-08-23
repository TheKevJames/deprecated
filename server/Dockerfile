FROM python:3.6.2-alpine

EXPOSE 80

COPY requirements.txt /src/requirements.txt
RUN pip install --no-cache-dir -r /src/requirements.txt

COPY . /src

CMD ["python", "/src/run.py"]
