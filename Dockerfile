FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY pyproject.toml README.md uv.lock ./
COPY s13code/ ./s13code/
COPY proofs/ ./proofs/

# Install python package
RUN pip install --no-cache-dir .

# Hugging Face Spaces port is 7860
EXPOSE 7860

# Run s14code serve on 0.0.0.0:7860
CMD ["s14code", "serve", "--host", "0.0.0.0", "--port", "7860"]
