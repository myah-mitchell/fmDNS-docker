# Quick reference
**About**: Unofficial Dockerization of the facileManager.com fmDNS module.

**Maintained by**: [micah-mitchell](https://github.com/micah-mitchell) (*not* the WillyXJ or the facileManager Team)

**Where to get help**:  This projects GitHub Issues or facileManager Issues if not related to docker

**Docker Hub Link**: https://hub.docker.com/r/micahmitchell/fmdns

**GitHub Link**: https://github.com/micah-mitchell/fmDNS-docker


# Supported tags and respective `Dockerfile` links
* [`latest`](https://github.com/micah-mitchell/fmDNS-docker/blob/main/Dockerfile), [`5.2.0`](https://github.com/micah-mitchell/fmDNS-docker/blob/main/Dockerfile)

# What is facileManger?

As quoted from facileManger.com; "facileManager is a modular suite of web apps built with the system administrator in mind. Say good-bye to manual management of services running on multiple servers. [Learn more](http://www.facilemanager.com/learn/) about what this suite can do for you."

![facilemanager logo](https://user-images.githubusercontent.com/47770376/153337478-4883286f-9308-4fd1-9e5c-a43cb6deac8c.png)

# Related Projects?

facileManager is just the web interface to which you can enable multiple modules. Each of these modules can run as their own container.

**fmDNS** : https://hub.docker.com/r/micahmitchell/fmdns

# How to use this image

The basic pattern for starting a drupal instance is:

```
$ docker run -d --name fmdns -p 80:80 -p 53:53/udp -p 53:53/tcp \
    -e FACILE_MANAGER_HOST=<fmDNS_Manager> \
    -e FACILE_CLIENT_SERIAL_NUMBER=1000 \
    -e FACILE_CLIENT_URL=<fmDNS_URL> \
   --hostname=<FQDN> \
   micahmitchell/fmdns`
```

## Volumes
By default, this image does not include any volumes. As all data is stored in facileManagers MySQL database, there is no data to keep from inside fmDNS

## ... via docker stack deploy or docker-compose
### docker-compose.yml
```yaml
  fmdns:
    image: micahmitchell/fmdns:latest
    hostname: ${fmDNS_URL}
    container_name: fmdns
    networks:
      - frontend
    volumes:
      - "/etc/timezone:/etc/timezone:ro"
      - "/etc/localtime:/etc/localtime:ro"
      - ./fmdns-log:/var/log/bind
    ports:
      - ${fmDNS_External_IP}:53:53/udp
      - ${fmDNS_External_IP}:53:53/tcp
      - 80:80
    stop_grace_period: 1m
    restart: unless-stopped
    environment:
      FACILE_MANAGER_HOST: ${fmDNS_Manager}
      FACILE_CLIENT_SERIAL_NUMBER: ${fmDNS_Serial}
      FACILE_CLIENT_URL: ${fmDNS_URL}

networks:
    frontend:
```
### .env
```
#fmDNS
fmDNS_URL=ns01.example.com
fmDNS_Manager=dns.example.com
fmDNS_Serial=1000
fmDNS_External_IP=###.###.###.###
```

# License
Due to this being an unoffical dockerization of the facilemanager.com web interface, we will be using the same as their project: https://github.com/WillyXJ/facileManager/blob/master/LICENSE

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

# Honorable Mentions

The layout and style of this Read-Me was directly influanced and copied from https://hub.docker.com/_/drupal

The following GitHub users and their projects that helped get this image to the state it is at. (If either of you would like to be added as co-maintainers please message me)
* https://github.com/erindru/fmDNS-docker
* https://github.com/MeCJay12/facileManager-docker
