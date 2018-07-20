# TiddlyWiki Docker tests

See <https://github.com/aelsabbahy/goss/tree/master/extras/dgoss>

## Demo Session

    $ dgoss run elasticdog/tiddlywiki --server
    INFO: Starting docker container
    INFO: Container ID: 947be594
    INFO: Found goss_wait.yaml, waiting for it to pass before running tests
    INFO: Sleeping for 0.2
    INFO: Container health
    PID                 USER                TIME                COMMAND
    30909               root                0:00                /sbin/tini -- tiddlywiki --server                                                                                    
    30937               root                0:00                node /usr/local/bin/tiddlywiki --server                                                                              
    INFO: Running Tests
    Process: node: running: matches expectation: [true]
    Process: tini: running: matches expectation: [true]
    File: /tiddlywiki: exists: matches expectation: [true]
    File: /tiddlywiki: filetype: matches expectation: ["directory"]
    Package: tini: installed: matches expectation: [true]
    Command: tiddlywiki --version: exit-status: matches expectation: [0]
    Command: tiddlywiki --version: stdout: matches expectation: [5.1.17]
    
    
    Total Duration: 0.475s
    Count: 7, Failed: 0, Skipped: 0
    INFO: Deleting container
