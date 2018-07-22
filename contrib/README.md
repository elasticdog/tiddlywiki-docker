TiddlyWiki Docker contrib
=========================

Any code in this directory is not officially supported, and may change or be
removed at any time without notice.

Demo Session
------------

    $ tiddlywiki-docker mynewwiki --init server
    Copied edition 'server' to mynewwiki

    $ tiddlywiki-serve mynewwiki/
    container "tw-mynewwiki" listening at http://localhost:32791

    $ tiddlywiki-serve mynewwiki/ --stop
    stopping container "tw-mynewwiki"

    $ env TIDDLYWIKI_DOCKER_PORT=8080 tiddlywiki-serve mynewwiki/
    container "tw-mynewwiki" listening at http://localhost:8080

    $ tiddlywiki-docker mynewwiki/ --render "[!is[system]]" "[encodeuricomponent[]addprefix[static/]addsuffix[.html]]"
      syncer-server-filesystem: Dispatching 'save' task: $:/StoryList
      filesystem: Saved file /tiddlywiki/mynewwiki/tiddlers/$__StoryList.tid

    $ tree -F --noreport mynewwiki/
    mynewwiki/
    ├── output/
    │   └── static/
    │       └── Demo%20Session%20Tiddler.html
    ├── tiddlers/
    │   ├── $__StoryList.tid
    │   └── Demo\ Session\ Tiddler.tid
    └── tiddlywiki.info
