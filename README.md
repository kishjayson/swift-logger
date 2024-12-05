# swift-logger

A command-line tool for writing entries to Unified Logs on macOS.

```
$ swift-logger --help

OVERVIEW: A command-line tool for writing entries to Unified Logs.

USAGE: swift-logger [--level <level>] --message <message> [--subsystem <subsystem>] [--category <category>]

OPTIONS:
  -l, --level <level>     The message's log level. (values: default, info,
                          debug, error, fault; default: default)
  -m, --message <message> The message to log.
  --subsystem <subsystem> The subsystem.
  --category <category>   The category.
  --version               Show the version.
  -h, --help              Show help information.
```
