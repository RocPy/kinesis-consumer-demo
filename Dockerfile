FROM openjdk:oraclelinux7

# Update packages 
RUN yum update -y && \
    yum upgrade -y && \
    # Install Python 3 dependencies (and more)
    yum -y install which libc6 libstdc++6 ca-certificates tar openssh-server curl make wget gcc openssl-devel bzip2-devel libffi-devel

# Install Python 3
RUN cd /opt && \
    wget https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tgz && \
    tar xzf Python-3.8.2.tgz && \
    cd Python-3.8.2 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    rm -f /opt/Python-3.8.2.tgz && \
    cd /usr/local/bin && \
    cp python3.8 python

# Install application dependencies
COPY Pipfile* /app/
WORKDIR /app

RUN python -m pip install --upgrade pip && \
    python -m pip install pipenv && \
    pipenv lock --dev --requirements > requirements-dev.txt && \
    pipenv lock --requirements > requirements.txt && \
    python -m pip install -r requirements-dev.txt && \
    python -m pip install -r requirements.txt

# Elastic Beanstalk requires at least one open port
EXPOSE 5678

# Copy the app into the container
COPY . /app/

WORKDIR /app/kinesis_consumer

# Ensure the entry point is executable 
RUN chmod +x ./run-consumer-docker.sh

CMD ["./run-consumer-docker.sh"]
