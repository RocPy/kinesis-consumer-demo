#!/bin/bash

export AWS_ACCESS_KEY_ID=$LOCAL_KINESIS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$LOCAL_KINESIS_SECRET_ACCESS_KEY

if [ ! -z "$DEBUG" ]; then
    echo "Debugging"
fi
if [ -z "$DEBUG" ]; then
    echo "Not debugging"
fi

kcl_command="$(python kclpy_helper.py --print_command --java /usr/bin/java --properties kinesis_consumer.properties)"

eval $kcl_command