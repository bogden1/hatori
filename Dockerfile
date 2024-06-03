FROM ubuntu:jammy
RUN apt update
RUN apt -y install npm python3 python3-pip
RUN pip install --no-cache-dir twisted

WORKDIR /app
COPY serv serv
RUN pip install --no-cache-dir -r serv/requirements.txt
COPY docs docs
COPY launch.sh .

ENV BACKEND_ADDR=${BACKEND_ADDR:-localhost}
ENV BACKEND_PORT=${BACKEND_PORT:-5000}
ENV FRONTEND_PORT=${FRONTEND_PORT:-5001}

CMD ["/bin/bash", "launch.sh"]
