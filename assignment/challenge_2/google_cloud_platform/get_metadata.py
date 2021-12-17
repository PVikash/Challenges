# Author: Vikash Pareek
# Date: 2021/12/17

"""
    This program retrieve complete metadata or specific attribute of a given compute instance on GCP.
    It takes below 2 arguments at run time.
        #1 - (mandatory) name of the GCE instance for which metadata is requested.
        #2 - (optional) specific attribute name for the given GCE instance.
"""
import logging
import shlex
import subprocess
import sys


def get_gce_metadata(instance_name, attribute=""):
    """
    This function provides metadata for a given instance name of GCE and an attribute key (optional)
    returns the metadata of that instance.

    @:param - instance_name: name of the GCE instance for which metadata need to retrieve.
    @:param - key: (optional) attribute name if any specific attribute required for given GCE instance.
    @:returns: complete metadata for a given instance or a specific attribute if key is given as a json object.
    """
    # Getting zone information of given GCE instance.
    zone_cmd = "gcloud compute instances list --filter=\"name=( '" + instance_name + \
               "')\" --format \"get(zone)\""
    zone = subprocess.check_output(shlex.split(zone_cmd))

    # Getting metadata for given GCE instance
    metadata_cmd = "gcloud compute instances describe " + instance_name + \
                   " --flatten='metadata[ " + attribute + "]' --zone=" + zone + " --format json"
    gce_metadata = subprocess.check_output(shlex.split(metadata_cmd))
    return gce_metadata


if __name__ == '__main__':
    logging.basicConfig(level=logging.NOTSET)
    logger = logging.getLogger("instance_metadata")
    if len(sys.argv) < 2:
        logger.error('No run time arguments are given, please provide below arguments: \n'
                      'instance_name (mandatory), attribute (optional)')
        logger.info("For example- \n"
                    + sys.argv[0] + " <instance-name> <zone>")
        exit(0)
    gce_instance_name = sys.argv[1]
    metadata_attribute = sys.argv[2] if len(sys.argv) > 2 else ""
    logger.info(get_gce_metadata(gce_instance_name, metadata_attribute))
