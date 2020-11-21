#!/bin/bash

debug="True"

#####################
# with DEBUG variable

docker run --name=log-consumer-container -it --rm -e AWS_ACCESS_KEY_ID=$LOCAL_KINESIS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$LOCAL_KINESIS_SECRET_ACCESS_KEY -e DEBUG=$debug -p 5678:5678  log-consumer-image
