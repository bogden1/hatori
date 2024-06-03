FROM python:3
WORKDIR /app
COPY docs docs
COPY serv serv
COPY launch.sh .

FROM node:8-alpine
WORKDIR /app
COPY --from=0 /app/docs docs
ARG BACKEND_ADDR=localhost
ARG BACKEND_PORT=5000
WORKDIR docs/page/topic
RUN sed -i "s#^const ENDPOINT = \"http://localhost:5000/\"#const ENDPOINT = \"http://${BACKEND_ADDR}:${BACKEND_PORT}/\"#" src/index.js
RUN npx webpack --config webpack.config.js

FROM python:3
WORKDIR /app
COPY --from=1 /app/docs docs
COPY --from=0 /app/serv serv
COPY --from=0 /app/launch.sh .
RUN pip install --no-cache-dir -r serv/requirements.txt
RUN pip install --no-cache-dir twisted
ARG BACKEND_PORT
ARG FRONTEND_PORT
ENV BACKEND_PORT=${BACKEND_PORT:-5000}
ENV FRONTEND_PORT=${FRONTEND_PORT:-5001}
CMD ["/bin/bash", "launch.sh"]
