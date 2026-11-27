# Ringfour App template

This starter prints a greeting to the App run output and exits. It uses Python's
standard library and requires no robot capabilities.

## Run locally

From the project directory, run:

```sh
python3 main.py
GREETING="Hello from my App" python3 main.py
ringfour-cli app validate .
```

## Make it yours

Edit `app.json` to set your App key, display name, release and image repository.
The example registry address is for local development. On an installed robot,
the Daemon supplies `GREETING` from the installation's `greeting` setting.
Edit `main.py` to change the App. When adding release files, include them in
`build.files`, the Dockerfile and the Docker ignore allowlist.

The default Docker target builds the release. The `development` target runs
source synced into `/workspace` by an App development session. To build a
release, supply the local Python wheel bundle pinned in `app.json`:

```sh
ringfour-cli app build . --wheels /path/to/0.1.1.dev0
```

The CLI verifies the bundle even though this starter uses no optional wheels.
To publish, sign in, select your publisher workspace, and run
`ringfour-cli app publish .` with access to the configured image registry.
Publication defaults to unlisted.
