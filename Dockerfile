FROM python:2.7.13

RUN apt-get update && apt-get install -y zip && 
    pip install git+https://github.com/fugue/emulambda.git
