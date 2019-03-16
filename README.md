# Colrou

Colrou is a portmanteau of "colorized routes".

It reformats output of `rails routes`:

Example:

![Example](https://user-images.githubusercontent.com/11846/54473866-ccc02600-47dd-11e9-9093-8ba1d9fe7d44.png)

Installation:

`gem install colrou`

The `colrou` command operates on the output of the `rails routes` command.

It performs two operations:

- HTTP verbs and path parameters are colorized
- Line breaks are inserted between controllers

Usage examples:

`$ rails routes | colrou`

`$ rails routes -g posts | colrou`

