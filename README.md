# stack-docker
A dockerized Haskell [stack](https://github.com/commercialhaskell/stack)

## Usage
Start by creating your stack image and volume (only needed once):
```sh
./build.sh
```

You can then copy the `stack` script in any of your projects' directories and invoke it normally.

Example of how to bootstrap a new project:
```sh
cd /path/to/my/new/project
cp /path/to/stack-docker/stack .
./stack new --bare project simple
./stack setup
./stack build --file-watch
```
