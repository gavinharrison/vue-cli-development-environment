# VueJs CLI development environment

This docker image is a fully fledged vue cli development environment without having the need to have the vue cli installed on your computer.

- GitHub : <https://github.com/gavinharrison/vue-cli-development-environment>
- Dcker Hub : <https://hub.docker.com/r/gavinharrison/vue-cli-development-environment>

whenthe container starts it will automaticaly run the [docker-entrypoint.sh](src/docker-entrypoint.sh) script in this script it runs npm install and then npm start.

## Setup of new project

    docker run -p 8000:8000 -p 8080:8080 -it --entrypoint /bin/bash --rm --name project-name-here -v ${PWD}:/project gavinharrison/vue-cli-development-environment

From here you can run `vue create project-name-here` to create a new vue project.

If you start the container without setting the --entrypoint to /bin/bash.

## Development of an existing project

First open a terminal window and navigate to the project directory

Now run the following to start up the container and start serving your vue project then visit <http://localhost:8080> to access your vue app.

    docker run -p 8000:8000 -p 8080:8080 --rm --name project-name-here -v ${PWD}:/project gavinharrison/vue-cli-development-environment

command break down
`-p 8080:8080` this is the port number binding between the host and container first value is the host and the second is the conainer. port 8080 is the default vue cli web server. you could change this to `-p 80:8080` if you would access the container on the default http port on e.g. `http://localhost/`

`-p 8000:8000` this is the port number binding between the host and the container first value is the host and the seconds is the container. port 8000 is the default vue ui dashboard.

`--rm` this removes the container once the container is stopped. Remove this from the above command if you would like the container to persist.

`--name project-name-here` this is an easy to remember name for the conatainer for when trying to access the container later to run vue commands.

`-v ${PWD}:/project` this is to connect the current directory to the projects folder within the docker container to allow local developmnet for the applications files.

Now to execute vue cli commands open another terminal and run the following. This will give you a shell in the container directaly.

    docker exec -it project-name-here /bin/bash

## Troubleshooting

If your issue is not mentioned below check the [Github Repository Issues](https://github.com/gavinharrison/vue-cli-development-environment/issues) to see if it has been raised there <https://github.com/gavinharrison/vue-cli-development-environment/issues>

If you are getting a unable to connect or connection was dropped then make sure that the `vue ui` command has the argument `--host 0.0.0.0` this will attach the web server to the container to be accessible externaly of the container as by default the web server restricts to localhost only connections and as we are connecting through the docker proxy we are not localhost hence the reason to opening it to all connections.

If you get the below error this is because the docker-entrypoint.sh script was unable to locate the package.json file during the instalation of the node_modules.

    $ docker run -p 8000:8000 -p 8080:8080 -it --rm --name project-name-here -v ${PWD}:/project gavinharrison/vue-cli-development-environment /bin/bash

    npm WARN saveError ENOENT: no such file or directory, open '/project/package.json'
    npm notice created a lockfile as package-lock.json. You should commit this file.
    npm WARN enoent ENOENT: no such file or directory, open '/project/package.json'
    npm WARN project No description
    npm WARN project No repository field.
    npm WARN project No README data
    npm WARN project No license field.

    up to date in 0.414s
    found 0 vulnerabilities

    npm ERR! code ENOENT
    npm ERR! syscall open
    npm ERR! path /project/package.json
    npm ERR! errno -2
    npm ERR! enoent ENOENT: no such file or directory, open '/project/package.json'
    npm ERR! enoent This is related to npm not being able to find a file.
    npm ERR! enoent 

    npm ERR! A complete log of this run can be found in:
    npm ERR!     /root/.npm/_logs/2020-07-14T02_21_40_542Z-debug.log
