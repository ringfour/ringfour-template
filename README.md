# Ringfour App template

This App prints a configurable greeting and exits. It uses Python's standard
library and needs no robot capabilities.

## Try the Python file

This checks your edit without a robot or Docker:

```sh
python3 main.py
GREETING="Hello from my App" python3 main.py
ringfour-cli app validate .
```

## Build the App image

The CLI installer installs the CLI only. This App's `app.json` pins a separate
Python wheel bundle; even this small starter must have that bundle available
for `app build`. Fetch and verify it once, then build:

```sh
ringfour-cli app bundle fetch .
ringfour-cli app build .
```

The fetch command reads the exact version and checksum in `app.json`, downloads
`python-artifacts.tar.gz` from the latest complete Platform release, verifies
the release checksum and every pinned bundle file, and saves it under
`${XDG_DATA_HOME:-$HOME/.local/share}/ringfour/python-artifacts/0.1.1.dev0`.
If the bundle is already there, it verifies and reuses it without a download.
Until a Platform release contains that archive, use a verified local bundle:

```sh
ringfour-cli app build . --wheels /path/to/0.1.1.dev0
```

The default Docker target is the release image. The `development` target is
for a Ringfour App development session; see the
[development guide](https://github.com/ringfour/ringfour-platform/blob/main/docs/app-development.md).

## Run it on a robot

Running the Python file above is only a local check. A Ringfour App runs after
its image is published, imported into your workspace, installed on an enrolled
robot, and started there. Sign in and select your workspace first:

```sh
ringfour-cli login
ringfour-cli org list
ringfour-cli org select <organization-id>
ringfour-cli robot list
```

Edit `app.json` before publishing: set `app_key`, display text, and a registry
repository reachable from both your build machine and the robot. The included
`127.0.0.1:5000` repository is only for a same-host local registry. Then run:

```sh
ringfour-cli app publish . --visibility unlisted
ringfour-cli app import <revision-id>
ringfour-cli app install <revision-id> --robot <robot-id>
ringfour-cli app operation <operation-id> --wait
ringfour-cli app start <installation-id>
ringfour-cli app logs <run-id> --follow
```

Use the revision, operation, installation, and run IDs printed by the preceding
commands. The Daemon supplies the `GREETING` setting when the App starts. Use
`ringfour-cli app installations --robot <robot-id>` to find an installation
again. To publish changed source or metadata later, increment `release` in
`app.json`; published releases are immutable.

Edit `main.py` to change behavior. When adding release files, include them in
`build.files`, the Dockerfile, and the Docker ignore allowlist.
