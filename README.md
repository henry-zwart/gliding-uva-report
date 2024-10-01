# UvA lab report template for Typst

This is a small Typst template for writing lab reports at the University of Amsterdam. 
I've written it primarily for my own use, but have made it open-source in case others 
find it helpful.

# Usage

> **Note:** Until this template has been submitted to the Typst template repository, using this template will require cloning a local copy. 

If you haven't already done so, [install Typst](https://github.com/typst/typst#installation).


Per the [Typst local package instructions](https://github.com/typst/packages?tab=readme-ov-file#local-packages), clone this repository to somewhere Typst can see it: 
`{data-dir}/typst/packages/local/uva-report-unofficial/{version}`. 

`{version}` is the current version as it appears in [typst.toml](typst.toml), and `{data-dir}` depends on your operating system:

- `~/.local/share` (Linux)
- `~/Library/Application Support` (MacOS)
- `%APPDATA%` (Windows)

Once this is done, navigate to the directory above where you'd like your report to be initialised, and run:

```zsh
typst init @local/uva-report-unofficial:{version} {report-directory-name}
```

This will create a new directory with an initialised `main.typ` templated report which you can edit.