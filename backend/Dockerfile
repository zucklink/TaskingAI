# Use a specific version for reproducibility
FROM python:3.10.12-slim

# Set environment variables
ENV PYTHONPATH=/code/ \
  PYTHONIOENCODING=utf-8 \
  API_RUN_ENV=docker \
  TERM=xterm-256color \
  PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /code

# Copy only the requirements.txt first to leverage Docker cache
COPY ./requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt

# Install NLTK and download required data
RUN pip3 install --no-cache-dir nltk && \
    mkdir -p /usr/local/share/nltk_data && \
    python -m nltk.downloader -d /usr/local/share/nltk_data punkt

# Copy the rest of the application
COPY ./app ./app
COPY ./tkhelper ./tkhelper
COPY ./resources ./resources

# Expose port 8000
EXPOSE 8000

# Command to run the application using gunicorn
CMD gunicorn --bind 0.0.0.0:8000 \
         --preload \
         --access-logfile - \
         --error-logfile - \
         --worker-connections 200 \
         -k uvicorn.workers.UvicornWorker \
         app.fastapi_app:app
