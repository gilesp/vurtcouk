---
author: giles
comments: true
date: 2007-09-20 13:28:13+00:00
layout: post
slug: site-update
title: Site Update
wordpress_id: 47
---

Well as you have probably guessed, I've made some changes to the site as a prelude to hopefully becoming a more regular blogger.

The changes aren't simple cosmetic either, I've moved totally from  a [blosxom](http://www.blosxom.com/) based set up to a [word press](http://wordpress.org/) one, with a new customised theme. My last experience with wordpress was when it was known as [b2](http://cafelog.com/), so things have changes a fair bit since then ;-)

Now, as with any change of platform, there have been many issues for me to contend with, most of which were fairly straightforward to deal with thanks to the wordpress documentation and the [experiences of others](http://www.google.co.uk/search?q=blosxom+to+wordpress&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-GB:official&client=firefox-a). Installing wordpress was a breeze thanks to the automatic installer scripts provided by my hosting provider, [dreamhost](http://www.dreamhost.com/). The first problem I had was to get my old posts into wordpress. Wordpress has a number of import options but not one for blosxom. Instead I had to go down the [rss feed import route](http://blog.unto.net/meta/migrating-from-blosxom-to-wordpress/).

Once that was done, I was stuck with the classic issue of changed URLs. Under blosxom, I had nested categories forming part of the URL, along with the article title. One of my reasons for moving to wordpress was to get away from categories and move to tagged posts, so that approach wouldn't work. Instead I opted to use the data based URL approach of wordpress combined with some mod-rewrite shenanigans to redirect the old URLs to their new homes. Because I didn't have too many URLs, I opted to just manually create the redirects but it would certainly be possible to do this in a smarter, more dynamic way if you needed to. My redirects looked like this:

`Redirect 301 /Articles/GingerBeer.html http://www.vurt.co.uk/2005/06/15/GingerBeer`

And that was pretty much it as far as installation and setup went. I've installed the [SimpleTagging](http://trac.herewithme.fr/project/simpletagging/) plugin to provide tagging to my entries and have started tagging new items but haven't yet been back to update the old ones.

The look and feel was achieved by creating a custom  theme and it's around 85% complete I reckon, just some minor bits to tweak now. No prizes for guessing that it's based on the following [2 column layout](http://www.glish.com/css/9.asp) at [glish.com](http://www.glish.com/). The thing I'm least happy with is the searching so I'll need to investigate that more, but I decided to release early and often rather than wait until I was entirely happy as otherwise I'd never have updated this place :-)

Commenting is now enabled so feel free to create an account and let me know what you think.
