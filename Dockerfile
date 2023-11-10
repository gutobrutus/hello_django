FROM python:3.10.12-slim

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

RUN addgroup --system appuser && \
    adduser --system --shell /bin/false --ingroup appuser appuser && \
    chown -R appuser:appuser /app

COPY --chown=appuser:appuser requirements.txt .

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY --chown=appuser:appuser . .

USER appuser

EXPOSE 8888

CMD ["gunicorn", "hello_django.wsgi:application", "--bind", "0.0.0.0:8888"]