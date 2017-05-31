# genie
[![CircleCI](https://circleci.com/gh/taylorfinnell/genie.svg?style=svg)](https://circleci.com/gh/taylorfinnell/genie)

Small CLI for Netflix Genie.

## Installation

##### From GitHub
1) Install Crystal
   `brew install crystal-lang`
1) Download a release from the Github Releases.
1) Add binary to PATH and make it executable

##### From Source

1) Install Crystal
1) Clone repository
1) `crystal build src/genie.cr --release`
1) Download a release from the Github Releases.
1) Add binary to PATH and make it executable

##### From Install Script
1) `curl https://raw.githubusercontent.com/taylorfinnell/genie/master/install | bash -s`

## Configuration

By default the CLI looks for configuration at `~/.genie.yml`.  Optionally, each
command can specify an alternate configuration via a `--env` or `-e` flag.

For example:

`genie ls -e prod`

Would look for `~/.genie.prod.yml`

The configuration file looks like the following.

```
host: genie-host-url:7000
credentials:
  username: tfinnell
  password: password
```

Credentials are only required if you have Basic auth enabled.

## Optional Configuration

You may set a `printer` key to either `tabbed` or `table` to set the default
output type.

```
printer: tabbed
```

You may set the default output columns.

```
columns:
  - id
  - status
  - name
```

## Usage

**List Genie Jobs**

```
  genie ls
```

You may show job progress with the `-p` flag. You may also limit the results with the `-l` flag.

```
genie ls -l 5 -p
```

**Search for a Job**

```
  genie search %some-name%
```

You may show job progress with the `-p` flag. You may also limit the results with the `-l` flag.

```
genie search %jim% -l 5 -p
```

You may show job progress with the `-p` flag. You may also limit the results with the `-l` flag.

**Get Job Status**

```
  genie status <id>
```

**Open Job Output**

```
  genie open <id>
```

```
genie status <id> -l 5 -p
```

**Kill a Job**

```
  genie kill <id>
```

## More examples

**Tabbed Output**

You may specify the output format with a `--printer` flag. Currently only
`table` and `tabbed` are valid printer values. Tabbed output is useful for
piping.

`genie search %job% --printer tabbed | cut -d$'\t' -f 1 | tail +2 | xargs genie kill`

**Showing only certain columns in output**

You may choose to only show certain columns in the output via a `--columns`
flag.

`genie ls --columns id --columns name`

**Hide Headers**

You may choose to hide the headers with the `-h` flag.

`genie search %Matched% --c id --printer tabbed -h | xargs genie kill`
