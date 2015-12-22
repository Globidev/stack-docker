# stack-docker
A dockerized Haskell [stack](https://github.com/commercialhaskell/stack)

## Usage
Start by creating your stack image and volume (only needed once):
```sh
./build.sh
```

You can then copy the `stack` script in your `$PATH` somewhere like `/usr/local/bin`. This allows you to invoke it almost seamlessly.
