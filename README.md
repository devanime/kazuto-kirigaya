# Mostly Paper Co README

## Getting Started: Local Environment

Clone the repository, and run:

```shell
make
```

This will:

1. Spin up the docker container.
2. Install all dependencies.
3. Run the build process.
4. Initialize local WP<span style="color:red">*</span>.
5. Open a migration dialog to pull staging<span style="color:red">*</span>.

<sup><span style="color:red">*</span> first run only</sup>

## Requirements

- [Docker](https://formulae.brew.sh/formula/docker)
- [Colima](https://github.com/abiosoft/colima)
- [DDEV](https://ddev.readthedocs.io/en/stable/)

See https://github.com/sitdev/ddev/ for more info.

## Useful Commands

| Command                | Description                                                                                                                                                            |
|------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `make help `           | Shows info about most of the available make commands.                                                                                                                  |
| `make`                 | Spins up the ddev container, runs the full build, and starts a migration dialog on first run.                                                                          |
| `make start`           | Spins up the ddev container.                                                                                                                                           |
| `make stop`            | Stops all running ddev containers.                                                                                                                                     |
| `make install`         | Installs all of the dev dependencies for composer and yarn.                                                                                                            |
| `make build`           | Runs the development build.                                                                                                                                            |
| `make watch`           | Runs the watch task.                                                                                                                                                   |
| `make update`          | Runs composer update and updates the ddev config.                                                                                                                      |
| `make clean`           | Cleans the build and installed dependencies.                                                                                                                           |
| `make local-init`      | Creates the local-config.php file and initializes the WP database with basic defaults using wp-cli.                                                                    |
| `make xdebug`          | Toggles Xdebug status (off by default). Works out of the box with phpstorm, but you will need to clear any previous xdebug mappings under Preferences > PHP > Servers. |

