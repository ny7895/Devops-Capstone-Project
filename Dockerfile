FROM python:3.9-slim

# Creta working folder and install the needed Dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

#copy app contents
COPY service/ ./service/

#switch user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Run service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]