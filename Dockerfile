FROM python:3.13.18-slim-trixie@sha256:e48f59cdba69a3cbd9ed2cf0f348d90d45a8d350d98134cf1070bc106ee9ed90 AS base

FROM base AS development
WORKDIR /workspace
RUN chown 10001:10001 /workspace
LABEL eu.ringfour.development-source="/workspace"
USER 10001:10001
ENTRYPOINT ["python", "/workspace/main.py"]

FROM base AS release
WORKDIR /app
COPY main.py ./
USER 10001:10001
ENTRYPOINT ["python", "/app/main.py"]
