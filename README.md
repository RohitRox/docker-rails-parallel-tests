This is a sample docker rails app to demonstrate how we can run our specs across multiple containers.

### Get Started
     make setup # build docker image, sets up databases
     make server # starts container rails server
     make rspec # run all specs in a single container
     make parallelspecs # invokes parallel test script; ./docker/parallel-specs.sh; fires multiples containers to runs tests listed in ./docker/parallel-specs.tsv

More commands in `./makefile`
    
### How does this work?

The script in `./bin/parallel` is a shell tool for executing jobs in parallel. 

`./docker/parallel-specs.sh` invokes `./docker/docker-spec-run.sh` alsong with params from the rows listed in `./docker/parallel-specs.tsv` with number of jobs defined by -j.

In our case, we have 4 rows in `./docker/parallel-specs.tsv` so we would like to have `-j4` that will fire 4 containers.

`./docker/docker-spec-run.sh` invokes actual `docker-compose run` command to start and run the spec, indirectly through `./docker/spec-runner.sh`.

Through the process, we have to make sure of two things: make sure container names does not conflict and generate a new database for each container so that test run data won't collide. For this purpose, we have some code to build container name in `./docker/docker-spec-run.sh` and code to create a new db from existing test db template and use that for rspec run in `./docker/spec-runner.sh`.

