# genie

Small CLI for Netflix Genie.

## Installation

Download a release from the Github Releases, or compile your own. After that,
add the binary to your PATH.

## Configuration

By default the CLI looks for configuration at `~/.genie.yml`.  Optionally, each
command can specify an alternate configuration via a `--config` flag.

`genie ls --config ~/.genie.prod.yml`

The configuration file looks like the following.

```
host: genie-host-url:7000
credentials:
  username: tfinnell
  password: password
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

**Get Job Status**

```
  genie status <id>
```

You may show job progress with the `-p` flag. You may also limit the results with the `-l` flag.

```
genie status <id> -l 5 -p
```

**Kill a Job**

```
  genie kill id
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
