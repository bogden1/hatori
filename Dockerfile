FROM python:3
WORKDIR /app
COPY docs /app/docs
COPY serv /app/serv
COPY launch.sh /app
RUN pip install --no-cache-dir -r serv/requirements.txt
RUN pip install --no-cache-dir twisted
CMD ["/bin/bash", "launch.sh"]
