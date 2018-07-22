Contributing to TiddlyWiki Docker
=================================

We welcome contributions from everyone. Here are the guidelines if you're
thinking of helping out...

Where to Start
--------------

Contributions to TiddlyWiki Docker should be made in the form of GitHub [pull
requests][]. Each PR will be reviewed by a core contributor (someone with
permission to approve patches) and either merged, or given feedback for changes
that would be required. _All contributions should follow this process, even
those from core contributors._

This project uses the GitHub [issue tracker][] to organize all known bugs,
feature requests, community questions, etc. If you'd like to work on an issue,
please leave a comment so we can assign it to you. This is to prevent
duplicated effort toward solving the same problem. We're glad to mentor
contributors as well, so if you'd like some guidance or clarification, just
ask!

[pull requests]: https://help.github.com/articles/using-pull-requests/
[issue tracker]: https://github.com/elasticdog/tiddlywiki-docker/issues

Development
-----------

The TiddlyWiki Docker project adheres to the ["Fork & Pull"][] model of
development; fork the repository and then create a local clone of your fork to
begin your work.

["Fork & Pull"]: https://help.github.com/articles/fork-a-repo/

### Prerequisites

You'll need the following software installed on your machine:

  - [Docker CE](https://www.docker.com/community-edition)
  - [dgoss](https://github.com/aelsabbahy/goss/tree/master/extras/dgoss)

### Build and Test

The `latest` version of the _Dockerfile_ is stored in the top-level of the
repository, but is a symlink to the most recent **major version file**, which
exists in a subdirectory.

To build the Docker image and test it, run the following commands:

    $ cd tiddlywiki-docker/
    $ docker build -t tiddlywiki .
    $ cd tests/
    $ dgoss run tiddlywiki --server

> For version bumps, don't forget to adjust the list of supported tags at the
> top of the _[README][]_.

[README]: https://github.com/elasticdog/tiddlywiki-docker/blob/master/README.md

### Pushing to Docker Hub

Once a pull request has passed the tests and been reviewed by a core
contributor, it will be merged into the `master` branch. This will
[automatically trigger][] CircleCI to build and subsequently push the image
(with the appropriate tags) to Docker Hub.

> To prevent untested changes from being deployed, the "automated builds"
> feature of Docker Hub itself is used strictly to sync the documentation.

[automatically trigger]: https://github.com/elasticdog/tiddlywiki-docker/blob/master/.circleci/config.yml

Reporting Issues
----------------

Follow these steps for filing useful bug reports:

1. Figure out how to reproduce the bug.
2. Make sure your software is up-to-date to see whether the bug has already
   been fixed.
3. Check if the bug has been previously reported in the [issue tracker][].
4. Finally, [open a new issue][] and provide detailed information regarding the
   bug and your environment.

Your report should minimally include:

  - the precise steps to reproduce the bug
  - the expected results and actual results
  - the versions of software you're running

If you have multiple issues, please file separate bug reports.

[open a new issue]: https://github.com/elasticdog/tiddlywiki-docker/issues/new

Conventions
-----------

### Git Workflow

Please **do not rewrite history** (rebase/amend/etc.) once you've filed a pull
request. At that point, the code on your branch should be considered public,
and rewriting history will inhibit collaboration. Read the [Branches section
of _Git DMZ Flow_][no-rebase] if you want a more detailed explanation.

[no-rebase]: https://gist.github.com/djspiewak/9f2f91085607a4859a66#branches

### Coding Style

TiddlyWiki Docker tries to respect the current conventions use by the Docker
community at large...that said, don't get too hung up on style. If there's
a major style issue with your code, we'll suggest some fixes to make before
approving your pull request. If there's a minor style issue, it's likely that
we'll merge your code as-is and someone might clean it up later.

We do include an [.editorconfig file][] in order to facilitate basic formating
consistency. See the [EditorConfig][] website for details, and to check if your
preferred text editor is supported.

[.editorconfig file]: https://github.com/elasticdog/tiddlywiki-docker/blob/master/.editorconfig
[EditorConfig]: http://editorconfig.org/
