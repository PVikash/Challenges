# Author: Vikash Pareek
# Date: 2021/12/17

"""
    This program fetch given key in the given nested object.
    This program requires below 2 arguments at run time.
        #1 - (mandatory) nested object.
        #2 - (mandatory) key that need to be fetched from given nested object.
"""

import json
import logging
import sys


def get_value_from_obj(obj, key):
    """
    This function recursively traverse given object to find the given key.
    @:param - obj: nested object that need to be traversed.
    @:param - key: key that need to be searched in the given object.
    @:returns - value/s corresponding to given key.
    """
    for k, v in obj.items():
        if k == key:
            yield v
        if isinstance(v, dict):
            for result in get_value_from_obj(v, key):
                yield result


if __name__ == '__main__':
    logging.basicConfig(level=logging.NOTSET)
    logger = logging.getLogger("object_parser")
    if len(sys.argv) != 3:
        logger.error('It expects 2 run time arguments, please provide below arguments: \n'
                     'object (mandatory), key (mandatory)')
        logger.info("For example- \n"
                    + sys.argv[0] + " {\"a1\":{\"b1\":{\"c1\":\"d1\",\"c2\":\"d2\"}}} c3")
        exit(0)
    obj = json.loads(sys.argv[1])
    key = sys.argv[2]
    logger.info(f"Given parameters are\nobject = {obj}\nkey = {key}")
    # obj = {"a1": {"b1": {"c1": "d1", "c2": "d2"}}}
    # key = 'b1'
    logger.info(f"Value for given request is \n{list(get_value_from_obj(obj, key))}")
