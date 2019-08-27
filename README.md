# Supported tags and respective `Dockerfile` links

- [`5.1.20`, `5.1`, `5`, `latest` (*5/Dockerfile*)](https://github.com/elasticdog/tiddlywiki-docker/blob/master/5/Dockerfile)
- [`5.1.19` (*5/Dockerfile* @ ae02af4)](https://github.com/elasticdog/tiddlywiki-docker/blob/ae02af419ead75508c7e1abcf75d00d79c0192b8/5/Dockerfile)
- [`5.1.18` (*5/Dockerfile* @ 2ead91d)](https://github.com/elasticdog/tiddlywiki-docker/blob/2ead91df276b99724e795c96cdd59e26c367d8d9/5/Dockerfile)
- [`5.1.17` (*5/Dockerfile* @ fdac15a)](https://github.com/elasticdog/tiddlywiki-docker/blob/fdac15a3a930365c98e3474492465e77e0148c55/5/Dockerfile)

## TiddlyWiki Docker

[TiddlyWiki][] is a self-contained JavaScript wiki that's useful as a non-linear notebook for capturing, organizing, and sharing complex information. These container images are for [running TiddlyWiki as a Node.js application][on-nodejs], which improves syncing and saving functionality over the single file version.

[![Build Status](https://circleci.com/gh/elasticdog/tiddlywiki-docker/tree/master.svg?style=svg)](https://circleci.com/gh/elasticdog/tiddlywiki-docker/tree/master)

See the [TiddlyWiki release notes][] for details on specific versions. Automated builds of these images are published to [`elasticdog/tiddlywiki` on Docker Hub][].

[TiddlyWiki]: https://tiddlywiki.com/
[on-nodejs]: https://tiddlywiki.com/#TiddlyWiki%20on%20Node.js:%5B%5BTiddlyWiki%20on%20Node.js%5D%5D%20%5B%5BUsing%20TiddlyWiki%20on%20Node.js%5D%5D
[TiddlyWiki release notes]: https://tiddlywiki.com/#Releases
[`elasticdog/tiddlywiki` on Docker Hub]: https://hub.docker.com/r/elasticdog/tiddlywiki/

## Usage

These Docker images are meant to replicate the functionality of the `tiddlywiki` CLI executable. As a sanity check, you can expect the following command to display the version number of TiddlyWiki:

    docker run -it --rm elasticdog/tiddlywiki --version

That said, there are a few caveats to consider when using a Docker-ized version of this command:

- **Port Publishing**  
  The _Dockerfile_ exposes port 8080 from the container, but you must bind to `0.0.0.0` rather than the default `127.0.0.1` (localhost) when running the HTTP server interface, or connectivity won't work from the host.

- **Data Persistence**  
  If you actually want to persist your tiddlers, you'll need to [get them out of the container][]; you can use either volumes or bind mounts. In the container, there is a predefined data volume under `/tiddlywiki` that is used as the default working directory.

- **Ownership Permissions**  
  If you do use a _bind mount_, don't forget that the process running within the **container** will change the **host** filesystem. You should run the container with the `--user` option so that files are created with the desired ownership.

To facilitate handling these things, you can write short wrapper scripts for common scenarios...

> _NOTE: Advanced versions of these example scripts can be found in the [**contrib** directory][] of the source repository._

[get them out of the container]: https://docs.docker.com/storage/
[**contrib** directory]: https://github.com/elasticdog/tiddlywiki-docker/tree/master/contrib

### Interactive Wrapper

For the scenario where you want to run commands interactively, you could create something like the following wrapper script:

```bash
#!/usr/bin/env bash

docker run --interactive --tty --rm \
	--publish 127.0.0.1:8080:8080 \
	--mount "type=bind,source=${PWD},target=/tiddlywiki" \
	--user "$(id -u):$(id -g)" \
	elasticdog/tiddlywiki \
	"$@"
```

#### Interactive Example

Assuming the interactive wrapper script is named `tiddlywiki-docker` and exists in the current directory, you can initialize and serve a new wiki using the following commands:

1. Create a folder for a new wiki that includes the server-related components:
   ```
   $ ./tiddlywiki-docker mynewwiki --init server
   Copied edition 'server' to mynewwiki
   ```

2. Start the TiddlyWiki server:
   ```
   $ ./tiddlywiki-docker mynewwiki --listen host=0.0.0.0
   Serving on 0.0.0.0:8080
   (press ctrl-C to exit)
    syncer-server-filesystem: Dispatching 'save' task: $:/StoryList
    filesystem: Saved file /tiddlywiki/mynewwiki/tiddlers/$__StoryList.tid
   ```

3. Edit the TiddlyWiki by navigating to <http://localhost:8080> in your host's web browser. You should follow the _Getting Started_ instructions to make sure that your changes are being reliably saved.

4. Stop the TiddlyWiki server by pressing `<Ctrl-C>` back in the terminal.

See `./tiddlywiki-docker --help` for more details.

### Background Wrapper

For the scenario where you want to run commands in the background (e.g. to serve an existing wiki), you could create something like the following wrapper script:

```bash
#!/usr/bin/env bash

readonly WIKIFOLDER=$1

docker run --detach --rm \
	--name tiddlywiki \
	--publish 127.0.0.1:8080:8080 \
	--mount "type=bind,source=${PWD},target=/tiddlywiki" \
	--user "$(id -u):$(id -g)" \
	elasticdog/tiddlywiki \
	"$WIKIFOLDER" \
	--listen host=0.0.0.0
```

#### Background Example

Assuming the background wrapper script is named `tiddlywiki-serve` and exists in the current directory, you can serve an existing wiki using the following commands:

1. Start the TiddlyWiki server:
   ```
   $ ./tiddlywiki-serve mynewwiki
   9b76d1be260f9e19406cbdec9f5dd4d087ce87d81f345da4eb6d23723e928043
   ```

2. You can see that the TiddlyWiki server is still running in the background:
   ```
   $ docker ps --latest
   CONTAINER ID        IMAGE                          COMMAND                  CREATED                  STATUS              PORTS                      NAMES
   9b76d1be260f        elasticdog/tiddlywiki:latest   "/sbin/tini -- tiddl…"   Less than a second ago   Up 23 seconds       127.0.0.1:8080->8080/tcp   tiddlywiki
   ```

3. Edit the TiddlyWiki by navigating to <http://localhost:8080> in your host's web browser.

4. Stop the TiddlyWiki server:
   ```
   docker stop tiddlywiki
   ```

## Contributing

The TiddlyWiki Docker project welcomes contributions from everyone. If you're thinking of helping out, please read the [guidelines for contributing][contributing].

[contributing]: https://github.com/elasticdog/tiddlywiki-docker/blob/master/CONTRIBUTING.md

## License

tiddlywiki-docker is provided under the terms of the [MIT License][].

Copyright &copy; 2018&ndash;2019, [Aaron Bull Schaefer](mailto:aaron@elasticdog.com).

[MIT License]: https://en.wikipedia.org/wiki/MIT_License
