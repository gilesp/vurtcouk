+++
title = "Org Protocol Setup"
description = "How to configure org-protocol for fun and profit"
tags = ["emacs", "org", "gtd"]
date = 2016-09-21T12:08:33Z
+++

I've decided to have another go at [Getting Things Done](http://gettingthingsdone.com/), but this time
using [Emacs](https://www.gnu.org/software/emacs/), as that's where I spend most of my time these days. As
part of that, I wanted to configure [org-protocol](http://orgmode.org/worg/org-contrib/org-protocol.html) so that I could
easily capture snippets from web pages as part of my research for projects.

The basic idea is that I should be able to create a new entry in my
gtd inbox (I'm using a file called `refile.org`) that contains the url
of the page, the text selected and a timestamp of when I saved the
link. I'll then later file these against the appropriate project (I'll
cover my GTD setup in another post).

The org-protocol documentation is rather out of date, so I've
collected info from various sources to get it all working, hence this
blog post.

Firstly, you want to be running [emacs in daemon mode](https://www.emacswiki.org/emacs/EmacsAsDaemon) as we need to use
`emacsclient` to handle the org-protocol requests (Well, technically you
just need a running emacs, but you should probably be using daemon
mode anyway). Then you need to setup org-protocol handlers on your
desktop and finally you need to configure some org-capture templates
to handle the data sent from the browser.

# Configuring `org-protocol` handler<a id="orgheadline1"></a>

Most linux desktops make use of freedesktop.org standards, including
[XFCE](https://www.xfce.org/) which is the desktop I use. We first need to create a desktop
entry that will map the org-protocol mime type
(`x-scheme-handler/org-protocol`) to `emacsclient`.

Create a file
`~/.local/share/applications/org-protocol-handler.desktop` that contains
the following:

```:export
[Desktop Entry]
  Version=1.0
  Type=Application
  Exec=/usr/bin/emacsclient %u
  Icon=/usr/share/icons/hicolor/scalable/apps/emacs.svg
  StartupNotify=true
  Terminal=false
  Categories=Utility;X-XFCE;X-Xfce-Toplevel;
  MimeType=x-scheme-handler/org-protocol
  Name=Org Protocol Handler
  Comment=Invoke emacsclient with org-protocol
```

Then add the following line to
`~/.local/share/applications/mimeapps.list`:

```:export
x-scheme-handler/org-protocol=exo-org-protocol-handler.desktop
```

Finally, update the desktop database with this command:

```sh
update-desktop-database  ~/.local/share/applications/
```

# Configure Chrome and org-capture templates<a id="orgheadline2"></a>

I use Google Chrome as my browser, and so I made use of the [Org
Capture extension](https://github.com/sprig/org-capture-extension) to provide a handy org unicorn button to press
that will send the currently selected text and url to emacs. It
expects there to be 2 templates configured, one for selected text
(key "p") and one for links (key "L"). I set them up by adding the
following to my org-capture-templates configuration:

```lisp
("p" "Protocol"
 entry (file+headline "refile.org" "Notes")
 "* %:description :RESEARCH:\n#+BEGIN_QUOTE\n%i\n\n -- %:link %u\n #+END_QUOTE\n\n%?")
("L" "Protocol Link"
 entry (file+headline "refile.org" "Notes")
 "* %? [[%:link][%:description]] \nCaptured On: %u")
```

The add both to my `refile.org` file, under the Notes section (I also
have a Tasks section). I'll later refile these to the appropriate
project file.

If you don't want to bother with the plugin, you can just create a
javascript bookmark as follows, and have it use whichever capture
template key you like:

```javascript
javascript:location.href="org-protocol://capture://X/"
    + encodeURIComponent(location.href) + "/"
    + encodeURIComponent(document.title) + "/"
    + encodeURIComponent(window.getSelection())
```

So far, I've found this a nifty integration but it's early days yet so
I may end up tweaking things further. One thing I *do* want to take a
look at is [org-protocol-capture-html](https://github.com/alphapapa/org-protocol-capture-html) which seems to do a nicer job of
formatting the selected text using pandoc.
