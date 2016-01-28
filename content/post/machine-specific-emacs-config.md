+++
tags = []
title = "Host specific config with Emacs"
date = 2016-01-27T11:43:18Z
+++

I'm a regular Emacs user, although I still class myself as a beginner - every day I find some 
new feature or function that I'd like to make use of.

I've taken a modular approach to my emacs configuration, whereby my `init.el` file adds a 
subdirectory `lisp` to the load path where my actual configuration lives. Within the lisp 
directory there are individual files of the format `init-feature.el` that contain the 
configuration for a specific feature or group of functionality. The idea behind this is so
that it's easier for me to find configuration when I need it and to be able to turn 
functionality on or off easily.

The main `init.el` file boils down to a series of `(require 'init-feature)` statements, which 
makes it clear what I have configured.

One downside is that I share my emacs config across several machines at home and work and 
I don't always need the same features on all machines. To overcome this I have common 
features enables in the main `init.el` file but I then load a hostname specific file to load 
any configuration required only by the current computer I'm using.

Here's the code I have in my init.el that makes this possible:

```lisp
;; load machine specific init file
;; it looks for a file names <hostname>.el and loads it if present
;; use it for require-ing different configs for each machine you use
(setq gilesp-local-filename (concat system-name ".el"))
(setq gilesp-local-file (expand-file-name gilesp-local-filename user-emacs-directory))
(when (file-readable-p gilesp-local-file)
  (load-file gilesp-local-file))
```
