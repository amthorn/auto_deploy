FROM ubuntu:latest
MAINTAINER avthorn@cisco.com
ARG COMMAND
ARG CRON

# Install Cron
RUN apt-get update
RUN apt-get -y install cron make git vim

# Install Python 3.6.6
RUN apt-get install -y python3-pip
RUN pip3 install jinja2

# Add crontab file in the cron directory
ADD crontab.template crontab.template
ADD inject.py /deploy/inject.py
RUN python3 /deploy/inject.py "/etc/cron.d/hello-cron" "${CRON}" "${COMMAND}"

# Add deployment files
ADD deploy.sh /deploy/deploy.sh
ADD pull_and_deploy.sh /deploy/pull_and_deploy.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron

# Give execution rights to deployment files
RUN chmod +x /deploy/deploy.sh /deploy/pull_and_deploy.sh

# Apply to crontab
RUN crontab /etc/cron.d/hello-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

RUN mkdir /root/.ssh
RUN echo 'Host github.com\n\
    StrictHostKeyChecking no' >> /root/.ssh/config

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
