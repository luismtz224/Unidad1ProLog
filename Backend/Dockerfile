FROM python:3.14-slim

WORKDIR /srv

# primero las dependencias, para que Docker las reutilice entre builds
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app app

EXPOSE 8000

# --proxy-headers: respeta X-Forwarded-Proto/For que manda nginx / el túnel
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--proxy-headers", "--forwarded-allow-ips", "*"]
