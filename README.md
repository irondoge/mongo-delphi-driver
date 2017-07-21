FreePascal mongoDB driver
======
This is a FreePascal mongoDB driver based on the original Delphi package [mongo-delphi-driver](https://github.com/gerald-lindsly/mongo-delphi-driver).

## Dependencies

The project obviously depends on the same [mongo-c-driver](https://github.com/mongodb/mongo-c-driver/tree/1.7.0-rc0) than the original package. But compilation from pre-compiled binaries is not available yet.

## Building steps

* `unzip mongo-c-driver.zip`
* `cd mongo-c-driver-master`
* `cp src/env.c src/env_posix.c`
* `cp src/env.c src/env_standard.c`
* `make ALL_CFLAGS="-D_POSIX_C_SOURCE=200112L"`
