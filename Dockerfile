FROM python:3.10-alpine3.17

COPY /src /datalogger

RUN apk add -U tzdata tmux htop
ENV TZ=Europe/Berlin

RUN pip install -r /datalogger/requirements.txt
ADD crontab /etc/cron.d/crontab-datalogger
RUN chmod 0644 /etc/cron.d/crontab-datalogger
RUN crontab /etc/cron.d/crontab-datalogger

CMD ["crond", "-f"]