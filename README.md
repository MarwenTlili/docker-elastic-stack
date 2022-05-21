# Elastic stack (ELK) on Docker

Based on the official Docker images from Elastic:

* [Filebeat](https://github.com/elastic/beats/tree/master/filebeat)
* [Elasticsearch](https://github.com/elastic/elasticsearch/tree/master/distribution/docker)
* [Logstash](https://github.com/elastic/logstash/tree/master/docker)
* [Kibana](https://github.com/elastic/kibana/tree/master/src/dev/build/tasks/os_packages/docker_generator)
* [Elastalert2](https://github.com/jertel/elastalert2)

## Requirements

### Host setup

* [Docker Engine][docker-install] 
* [Docker Compose][compose-install] 
* 8 GB of RAM

*:information_source: Especially on Linux, make sure your user has the [required permissions][linux-postinstall] to
interact with the Docker daemon.*

By default, the stack exposes the following ports:
* 5044: Logstash Beats input
* 5000: Logstash TCP input
* 9600: Logstash monitoring API
* 9200: Elasticsearch HTTP
* 9300: Elasticsearch TCP transport
* 5601: Kibana

**environment variables .env**  
```console
# es, logstash, kibana versions  
ELASTIC_VERSION=7.15.2  
# elastalert (put your elastic search desired host name)  
ES_HOST='elasticsearch-host-name'  
ES_PORT=9200  
ES_USERNAME='elastic'  
ES_PASSWORD='elastic'  
# logstash  
LOGSTASH_INTERNAL_PASSWORD='logstash'  
# kibana  
KIBANA_SYSTEM_PASSWORD='kibana'  
# postfix  
HOSTNAME='mail.gpro.com'  
```

## Usage

**:warning: You must rebuild the stack images with `docker-compose build` whenever you switch branch or update the
[version](#version-selection) of an already existing stack.**

### Bringing up the stack

Clone this repository onto the Docker host that will run the stack, then start the stack's services locally using Docker
Compose:

```console
$ docker-compose up -d
```

Give Kibana about a minute to initialize, then access the Kibana web UI by opening <http://localhost:5601> in a web
browser and use the following (default) credentials to log in:

* user: *elastic*
* password: *elastic*

*:information_source: Upon the initial startup, the `ES_PASSWORD`, `LOGSTASH_INTERNAL_PASSWORD` and `KIBANA_SYSTEM_PASSWORD` Elasticsearch
users are intialized with the values of the passwords defined in the [`.env`](.env) file (_"elastic"_, _"logstash"_, _"kibana"_ by default). The
first one is the [built-in superuser][builtin-users], the other two are used by Kibana and Logstash respectively to
communicate with Elasticsearch. This task is only performed during the _initial_ startup of the stack. To change users'
passwords _after_ they have been initialized, please refer to the instructions in the next section.*

### Filebeat
install it where the system you want to monitor, enable apache module (apache config example in filebeat/modules.d/apache.yml), then use filebeat.yml config provided in this repository
```
./filebeat modules enable apache
./filebeat -c filebeat.yml -e
```
