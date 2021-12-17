# Author: Vikash Pareek
# Date: 2021/12/17

"""
This is a test program to test challenge_3.object_parser utility.
"""

import unittest
import json
from challenge_3.object_parser import get_value_from_obj


class TestObjectParser(unittest.TestCase):
    """
    This class extends unittest.TestCase and contains different test cases to test challenge_3.object_parser
    """
    def setUp(self):
        pass

    # Getting root element of the object.
    def test_root_key(self):
        test_obj = json.loads("{\"a1\":{\"b1\":{\"c1\":\"d1\",\"c2\":\"d2\"}}}")
        key = "a1"
        expected_output = [{'b1': {'c1': 'd1', 'c2': 'd2'}}]
        self.assertEqual(expected_output, list(get_value_from_obj(test_obj, key)))

    # Getting leaf element of the object.
    def test_leaf_key(self):
        test_obj = json.loads("{\"a1\":{\"b1\":{\"c1\":\"d1\",\"c2\":\"d2\"}}}")
        key = "c2"
        expected_output = ['d2']
        self.assertEqual(expected_output, list(get_value_from_obj(test_obj, key)))

    # Getting any element (except root and leaf) of the object.
    def test_middle_key(self):
        test_obj = json.loads("{\"a1\":{\"b1\":{\"c1\":\"d1\",\"c2\":\"d2\"}}}")
        key = "b1"
        expected_output = [{'c1': 'd1', 'c2': 'd2'}]
        self.assertEqual(expected_output, list(get_value_from_obj(test_obj, key)))

    # Getting non existing element of the object.
    def test_non_existing_key(self):
        test_obj = json.loads("{\"a1\":{\"b1\":{\"c1\":\"d1\",\"c2\":\"d2\"}}}")
        key = "e1"
        expected_output = []
        self.assertEqual(expected_output, list(get_value_from_obj(test_obj, key)))

    # Getting an element of the object, which is repeated at multiple level.
    def test_duplicate_key(self):
        test_obj = json.loads("{\"a1\":{\"b1\":{\"c1\":\"d1\",\"b1\":\"d2\"}}}")
        key = "b1"
        expected_result_length = 2
        expected_output = [{'c1': 'd1', 'b1': 'd2'}, 'd2']
        self.assertEqual(expected_output, list(get_value_from_obj(test_obj, key)))

    # Getting an element from the invalid nested object.
    def test_invalid_object(self):
        test_obj = "a1:{b1:{c1:d1,c2:d2}}}"
        key = "a1"
        with self.assertRaises(AttributeError):
            list(get_value_from_obj(test_obj, key))


if __name__ == '__main__':
    unittest.main()
