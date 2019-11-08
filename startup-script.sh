#!/usr/bin/python

from oauth2client.client import GoogleCredentials
from googleapiclient import discovery
import pprint
import json

credentials = GoogleCredentials.get_application_default()
compute = discovery.build('compute', 'v1', credentials=credentials)

project = 'NTI-300'
zone = 'us-centtral1-a'
name = 'test'

def list_instances(compute, project, zone):
	result = compute.instances().list(project=project, zone=zone).execute()
	return result['items']
	
def create_instance(compute, project, zone, name):
	startup_script = open('startup-script.sh', 'r').read()
	image_response = compute.images().getFromFamily(
		project='centos-cloud', family='centos-7').execute()
		
	source_disk_image = image_response['selfLink']
	machine_type = "zone/%s/machineTypes/f1-micro" % zone
	
config = {
	'name': name,
	'machineType': machine_type,
		
	#specify the boot disk and the image as a source_disk_image
	'disk': [
		{
			'boot': True,
			'autoDelete': True,
			'initializeParams': {
				'sourceImage': source_disk_image,
			}
		}
	],
		
	#specify network interface with NAT to access the public
	#internet
	'networkInterfaces': [{
		'network': 'global/networks/default',
		'accessConfigs': [
			{'type': 'ONE_TO_ONE_NAT', 'name': 'External NAT'}
		]
	}],
		
	'serviceAccounts': [{
		'email': 'default',
		'scopes': [
			'https://www.googleapis.com/auth/devstorage.read_write',
			'https://www.googleapis.com/auth/logging.write'
		]
	}],
		
	#Enable http/https for select instances
	"labels": {
	"http-server": "",
	"https-server": ""
	},
		
	"tags": {
	"items": [
	"http-server": "",
	"https-server": ""
	]
	},
		
	#metadata is readable from the instances and allow
	#you to pass config from deployment script to instances
	'metadata': {
		'items': [{
			
			#startup script is automattily exectued by the instance upon startup
			'key': 'startup-script',
			'value': startup_script
		}]
	}
}

	return compute.instances().insert(
		project=project,
		zone=zone,
		body=config).execute()
		
newinstance = create_instance(compute, project, zone, name)
instances = list_instances(compute, project, zone)

pprint.pprint(newinstance)
pprint.pprint(instances)
