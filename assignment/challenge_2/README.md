### Challenge 2

#### Problem Statement
We need to write code that will query the meta data of an instance within AWS and provide a json formatted output. The choice of language and implementation is up to you.
###### Bonus Points
_The code allows for a particular data key to be retrieved individually._

#### Solution
This program retrieve complete metadata or specific attribute of a given compute instance on GCP.

It takes below 2 arguments at run time.
        
    1 - (mandatory) name of the GCE instance for which metadata is requested.
    2 - (optional) specific attribute name for the given GCE instance.

It returns the complete metadata or specific attribute in json format based on input.

To run this program use below command - 

    python challenge2/get_metadata.py <instance-name> <attribute>
For e.g. 

    python challenge2/get_metadata.py my-instance zone

This will return metadata as a json object.