---
author: giles
comments: true
date: 2010-05-21 14:20:01+00:00
layout: post
slug: ubuntu-10-04-ambiance-theme-issues-with-firefox
title: Ubuntu 10.04 Ambiance theme issues with Firefox
wordpress_id: 111
tags:
- firefox
- glitch
- theme
- ubuntu
---

I came across an interesting issue concerning the default Ubuntu 10.04 Ambiance theme and read only inputs in Firefox today. Basically the foreground and background colours for disabled/read-only input fields are the same, meaning that you can't actually read what's in the fields. Here's an example screen shot from an internal web app I'm currently working on for [my employers](http://www.wmfs.net/):

[caption id="attachment_112" align="aligncenter" width="300" caption="Disabled inputs in Firefox with the Ubuntu Ambiance theme"][![](http://www.vurt.co.uk/wp-content/uploads/2010/05/disabled_inputs_ambiance_crop-300x118.png)](http://www.vurt.co.uk/wp-content/uploads/2010/05/disabled_inputs_ambiance_crop.png)[/caption]

And here's what it looks like when using the New Wave theme in Ubuntu:

[caption id="attachment_113" align="aligncenter" width="300" caption="Disabled inputs in Firefox using the New Wave theme"][![](http://www.vurt.co.uk/wp-content/uploads/2010/05/disabled_inputs_new_wave_theme_cropped-300x118.png)](http://www.vurt.co.uk/wp-content/uploads/2010/05/disabled_inputs_new_wave_theme_cropped.png)[/caption]

This issue caused me a few moments of panic when I thought I'd broken the app - I was glad it was just a theme glitch! I've switched to using New Wave for the time being until I can figure out how to get the Ambiance theme to behave properly without screwing the rest of the system colours.

**UPDATE (2010-05-27):** Ok, so this turns out to be actually caused by a strange coincidence meaning that our CSS style for disabled inputs had exactly the same colour as the disabled text in the Ambience theme. Since the res of our users are running Windows and IE, it's not a problem. It only affects us developers using Ubuntu :-)
