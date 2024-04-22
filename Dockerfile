FROM cgr.dev/chainguard/python:latest-dev@sha256:38d707e270b539b46a0bd385d387a38c699856eec465983f176315778588571c as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --user
FROM cgr.dev/chainguard/python:latest@sha256:5048e0f5ef4cea6086790b1aa415553b80b3857f3a0c15326e8ad51a13d55ce4
WORKDIR /app

# Make sure you update Python version in path
COPY --from=builder /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages

COPY . .

ENTRYPOINT [ "python", "/app/noisy.py", "--config", "/app/config.json"]