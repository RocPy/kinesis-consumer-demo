
from datetime import datetime, timezone

class StreamAggregate(object):
    
    def __init__(self):

        self.first_item_recived = None
        self.groups = {}

    def add_data(self, data_item):

        if (self.first_item_recived is None):
            self.first_item_recived = datetime.now(timezone.utc)

        key = data_item[:2]
        if (key not in self.groups):
            self.groups[key] = []

        self.groups[key].append(data_item)
        