# gliding-uva-report

A Typst template for lab reports at the University of Amsterdam.

It's written primarily for my own use, but I've made it open-source in case others find it helpful.

## Dependencies

Using the template requires a local installation of [Typst](https://github.com/typst/typst#installation).

Until the template is listed on the Typst template repository, you'll also need a clone of
this repo in a place Typst can see it. The Typst team recommend:

> `{data-dir}/typst/packages/local/gliding-uva-report/{version}`

Where `{version}` is the current version as it appears in [typst.toml](typst.toml), and
`{data-dir}` depends on your operating system:

- `~/.local/share` (Linux)
- `~/Library/Application Support` (MacOS)
- `%APPDATA%` (Windows)

## Usage

```zsh
# Navigate to where you'd like the report to live, e.g.,
cd $HOME/reports

# Create the report directory
typst init @local/gliding-uva-report:{version} {report-directory-name}
```

This will create a new directory at `$HOME/reports/{report-directory-name}`, with
a templated document, `main.typ`, which you can edit.

## Contributing

Pull requests are welcome. For major changes or bugs, please open an issue.

## License

[MIT](https://choosealicense.com/licenses/mit/)
