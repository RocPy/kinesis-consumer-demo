
import json

stream_config = None

def load_config():
    global stream_config

    fileName = "mystream_config.json"  

    with open(fileName, "r") as configFile:
        config_file_content = configFile.read()
        stream_config = json.loads(config_file_content)

load_config()