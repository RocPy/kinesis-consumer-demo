# kinesis-consumer-demo

This project contains an example Kinesis consumer application using the [KCL for Python](https://github.com/awslabs/amazon-kinesis-client-python) 

A corresponding producer demo application can be found at https://github.com/RocPy/kinesis-producer-word-putter

The `kclpy_helper.py`, `sample_aggregation_app.py`, and `kinesis_consumer.properties` where taken from the above repository. Note that if you use the example it the sample folder from that repository, make sure you change the same script names, because the pip library `amazon-kclpy` includes them and will prevent your scripts from being run.

- `kinesis_consumer` - The application
    - `kclpy_helper.py` - Builds the command line command to start Java
    - `kinesis_consumer.properties` - Configuration passed to the sample_aggregation_app.py via the Java application
    - `mystream_agregate.py` - Sample aggregation logic
    - `mystream_config.py` - Sample application configuration handling
    - `mystream_config.json` - Sample application configuration
    - `process_stream.py` - The Python KCL application
    - `run-consumer-docker.sh` - The entry point used by the Docker container
    - `run-consumer.sh` - Used to run the application outside of Docker 
- `docker-buld.sh` - Build the Docker image
- `docker-run.sh` - Run the Docker image 
- `docker-shell-container.sh` - Examples of how to shell into a running container
- `docker-shell-image.sh` - Examples of how to shell into a Docker image
- `Dockerfile` - The current Docker image configuration
- `Pipfile` - Manages Python library dependencies


## Environment

The application uses [Pipenv](https://github.com/pypa/pipenv) to manage packages and the development virtual environment for Python.

After cloning, run the following from the root of the project. The `--dev` option will include the `[dev-packages]` from the Pipfile.

```bash
pipenv install --dev
```

The primary IDE used to create this project was [VS Code](https://docs.aws.amazon.com/toolkit-for-vscode/latest/userguide/welcome.html)

Within VS Code make sure you are using the virtual environment created by Pipenv. This can be selected by clicking the Python version indication in the lower left corner of the VS Code window. If the Python version is not folowed by a virtual environment namne the virtual environment is not being used. 

## Development Credentials

Local development depends on 2 environment variables
- `LOCAL_KINESIS_ACCESS_KEY_ID`
- `LOCAL_KINESIS_SECRET_ACCESS_KEY`

These are used in both `kinesis_consumer/run-consumer.sh` and `docker-run.sh`. In each instance the 2 variables are converted to `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` respectively. 
- `kinesis_consumer/run-consumer.sh` - For running the application outside of Docker. Sets the local `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables and runs the output of `kinesis_consumer/kclpy_helper.py`
- `docker-run.sh` - For running the application within a Docker container. Sets the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables in the Docker container instance.


## Debugging

To debug:

1. `docker-build.sh` 
1. `docker-run.sh`
1. Wait for the console output to start the worker loop, and then display the message "Skipping unexpected line on STDOUT for shard shardId-000000000000: import ptvsd"
1. Start the VS Code debugger using the "Python: Remote Docker Attach" configuration

When the application is started with a `DEBUG` environment variable, the [`ptvsd`](https://github.com/microsoft/ptvsd) library is attempted to be loaded. Examples of how to include the `DEBUG` environment variable can be found in `kinesis_consumer/run-consumer.sh` and `docker-run.sh`.

The `ptvsd` library is only available to the application if the `[dev-packages]` are installed, see the [Environment](#environment) section above.  

To enable the use of this library in the Docker container, port 5678 is exposed in the `Dockerfile` and `docker-run.sh`. This port the default used by the VS Code debugger.

**NOTE:** Many of the examples found in the AWS documentation and forums like Stack Overflow refrence the use of `ptvsd.enable_attach(address=('0.0.0.0', 5678), redirect_output=True)` to enable the library in code. This pattern did not work for whatever reason, and therefore this project uses the default `ptvsd.enable_attach()`.


## Logging

Application logs are configured to be saved to `/var/log/wordgetter/`. These can be viewed by shelling into the container. There's a helper script for this called `docker-shell-container.sh`.


## Application Configuration

The `kinesis_consumer/kinesis_consumer.properties` file contains the configuration for Java application. It identifies the script to run, `kinesis_consumer/process_stream.py` in this case, and the stream name and region among others.


## Running The Application

The `docker-run.sh` script has an example of how to run the application Docker. 

Using the Docker `docker run` example requires a `docker build` be run before, if any changes are made. It's recommended that the `docker-build.sh` is used to ensure the correct `Dockerfile` is used. 
