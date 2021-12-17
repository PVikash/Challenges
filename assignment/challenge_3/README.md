### Challenge 3

#### Problem Statement
We have a nested object, we would like a function that you pass in the object and a key and get back the value. How this is implemented is up to you.

Example Inputs

    object = {“a”:{“b”:{“c”:”d”}}}

    key = a/b/c


    
    object = {“x”:{“y”:{“z”:”a”}}}

    key = x/y/z


#### Solution
This program fetch given key in the given nested object.
    This program requires below 2 arguments at run time.
    
    1 - (mandatory) nested object.
    2 - (mandatory) key that need to be fetched from given nested object.

It returns value/s corresponding to given object and key.

To run this use below command - 

    python challenge3/object_parser.py <object> <key>
e.g.

    python challenge3/object_parser.py {\"a1\":{\"b1\":{\"c1\":\"d1\",\"c2\":\"d2\"}}} b1

This will return list of values corresponding to given object and key.

##### Tests
This solution also contains unittest cases in _challenge_3/unittest/test_obj_parser.py_