---
author: giles
comments: true
date: 2010-05-04 14:51:45+00:00
layout: post
slug: ubuntu-lucid-10-04-active-directory-woes
title: Ubuntu Lucid 10.04 Active Directory Woes
wordpress_id: 108
---

I was looking forward to the launch of Lucid Lynx as [one of the main features being touted](http://www.ubuntu.com/testing/lucid/beta2#Major%20new%20version%20of%20likewise-open) was improved support for joining an Active Directory domain, in the form of Likewise-open. Now this isn't something that most users will care about, but in a corporate environment, allowing users to login to Ubuntu using the same credentials as they use on their windows machines is pretty important. Previously I'd set things up manually by configuring Samba and Winbind, but that was a pain in the backside, so Likewise-open was an appealing option.

Sadly, I've been very disappointed so far. It seems that the version of Likewise-open that ships with Kucid, has a number of glaring bugs that make it virtually pointless.

Firstly, there is [no support for a default domain](https://bugs.launchpad.net/ubuntu/+source/likewise-open/+bug/534629). This means that the user has to always log in as user.name@domain or domain\\user.name which is a pain. It's not a show stopper but it is trivial to set up using samba, so why can't Likewise support it? Well, Likewise claims to support it, via a registry setting, it's just that it's broken.

More importantly, is the [broken credential caching](https://bugs.launchpad.net/ubuntu/+source/likewise-open/+bug/572271). Laptops aren't always connected to the domain, so any solution needs to be able to cache credentials to let the user log in when they're out and about. It turns out that the default cache timeout in Likewise is 4 hours. And there's no way to change that. 4 Hours! So that means when you take your laptop home with you at night, intending to work at home the enxt day, you faced with the fact that you can't log in in the morning, or even later that evening. How handy.

Until these issues can be resolved, I'm going to purge Likewise and resort to the Samba config method. It's long winded, but at least it's tried and tested and I can actually configure it to work how I need it to. Who knows, maybe Meerkat will have working Likewise, it's just a shame Canonical were touting it as a big improvement in Lucid.

Oh yes, and on a side note, when I upgraded my netbook from 9.10 to 10.04, it killed my wifi and lost the nice netbook remix clutter UI. Ho hum. Time to do a clean install and see if that fixes things.

Don't get me wrong - I'm still a big Ubuntu and Linux fan, I just would have liked this launch to have gone a bit smoother...
