![Gem Version](https://img.shields.io/gem/v/colrou.svg) ![License](https://img.shields.io/github/license/evaneykelen/colrou.svg)
![Last Commit](https://img.shields.io/github/last-commit/evaneykelen/colrou.svg)

# Colrou

Colrou reformats output of `rails routes`. The name is a portmanteau of "colorized routes".

## Example

![Example](https://user-images.githubusercontent.com/11846/54473866-ccc02600-47dd-11e9-9093-8ba1d9fe7d44.png)

## Installation

`gem install colrou`

The `colrou` command operates on the output of the `rails routes` command.

It performs two operations:

- HTTP verbs and path parameters are colorized
- Line breaks are inserted between controllers

## Usage examples

`$ rails routes | colrou`

`$ rails routes -g posts | colrou`


## Color configuration

Place a file called `.colrou.yml` in your home directory (e.g. `~` on Unix) to configure output colors:

```
http_verb_colors:
  delete: "\e[91m"
  get: "\e[92m"
  patch: "\e[95m"
  post: "\e[93m"
  put: "\e[95m"
misc_colors:
  reset: "\e[0m"
  param: "\e[96m"
```

See [here](https://misc.flogisoft.com/bash/tip_colors_and_formatting) for a nice overview of shell color codes.

## Tip

Add the following lines to e.g. `~/.bash_profile` (the location depends on your shell and OS):

```
alias rr='rails routes'
alias cr='colrou'
```

You now only have to type `$ rr | cr` to colorize your routes.
