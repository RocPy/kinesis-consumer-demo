#!/bin/bash

if [ ! -z "$DEBUG" ]; then
    echo "Debugging"
elif [ -z "$DEBUG" ]; then
    echo "Not debugging"
fi

kcl_command="$(python kclpy_helper.py --print_command --java /usr/bin/java --properties kinesis_consumer.properties)"

eval $kcl_command