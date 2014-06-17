---
author: giles
comments: true
date: 2010-05-07 15:07:31+00:00
layout: post
slug: ubuntu-10-04-64-bit-eclipse-3-5-native-proxy-support
title: Ubuntu 10.04 64 bit Eclipse 3.5 Native Proxy support
wordpress_id: 109
---

Eclipse is a great IDE and I've been using it day to day for a number of years now. However when I recently got a new laptop at work and installed Ubuntu 10.04 on to it, I ran into a problem with the Proxy configuration.

At work, I'm stuck behind an NTLM authenticated proxy which I can get my system talking to thanks to running [cntlm](http://cntlm.sourceforge.net/) locally and setting the gnome proxy settings to point to that. On my previous laptop, I was running 32bit Ubuntu and Eclipse just automatically picked up the native proxy info and worked fine. It turns out that this functionality isn't available by default in the 64bit version of Eclipse 3.5. Despite having the option to select "Native" in the Network Connections preferences in Eclipse, no values are picked up and I couldn't connect to the outside world to install the extra features I need.

It turns out that the solution is to grab the native proxy library from the forthcoming 3.6 version of Eclipse and install it into 3.5, as explained in this [eclipse bug](https://bugs.eclipse.org/bugs/show_bug.cgi?id=273072). Here's how I did that using the Ubuntu supported version of Eclipse.



	
  1. Download the 64 bit Linux version of [Eclipse Classic 3.6.0](http://www.eclipse.org/downloads/packages/release/helios/m6) (M6 at the time of writing)

	
  2. Extract it locally and copy the file `plugins/org.eclipse.core.net.linux.x86_64_1.1.0.I20091106-0506.jar` to `/usr/share/eclipse/dropins` (you'll probably have to create the dropins directory first).

	
  3. Edit `/etc/eclipse.ini` to include the following: `-Dorg.eclipse.core.net.enableGnome`

	
  4. Delete the eclipse 3.6 directory unless you have a pressing need to keep it around ;-)


When you next start eclipse, the Network Connections preferences will be prepopulated with the gnome proxy settings. It took me a while to figure this out, and I'll no doubt need to do it again sometime, so this post is mostly for my own benefit, but hopefully someone else will find it useful too.

Bootnote: You may be wondering why I didn't just install 3.6 and run that. Well mainly because it's not fully supported by the [SpringSource Tool Suite](http://www.springsource.com/products/sts) and also it'd mean looking after upgrades and dependencies myself. I'd rather have apt handle all that for me.
