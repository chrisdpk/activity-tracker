FROM python:3.6-alpine

RUN adduser -D trackr

WORKDIR /home/trackr

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn pymysql

COPY app app
COPY migrations migrations
COPY trackr.py config.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP trackr.py

RUN chown -R trackr:trackr ./
USER trackr

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
