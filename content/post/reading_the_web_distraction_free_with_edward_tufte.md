+++
title = "Tuftey: Distraction free reading with Edward Tufte"
description = "How I created a bookmarklet to make reading web articles nicer"
tags = ["webdev", "reading", "coding", "hacks"]
date = 2017-01-23T16:13:17Z
+++

[Edward Tufte](https://en.wikipedia.org/wiki/Edward_Tufte) knows a thing or two about information design, apparently. Most web site designers do not. Wouldn't it be nice if you could apply some of Tufte's experience to arbitrary websites when you're reading them? By utilising the work of others, I've created a simple little [bookmarklet](https://en.wikipedia.org/wiki/Bookmarklet) that does just that.

A few months ago, I came across [a project](https://edwardtufte.github.io/tufte-css/) that aims to create a style sheet for web pages that makes use of Tufte's ideas about presentation for books and handouts. It doesn't aim to just apply print layout to web pages, but rather apply techniques from Tufte that would be useful on the web.

Tufte CSS is intended as a starting point for a project, as information should be presented in the way that best suits it, but it's more than good enough as-is for my needs. The next issue is how to get to the heart of a webpage and style that, rather than all the extra cruft (such as navigation, adverts, sidebars etc).

The previous go-to option for getting a readable version of a webpage was [Readability](https://www.readability.com/). Sadly this service no longer exists. Thankfully other options exist, and Readability point you towards [Mercury](https://mercury.postlight.com/) by [Postlight Labs](https://postlight.com/labs/). So that's what I went for.

I quickly knocked together a bit of javascript that would call the Mercury api, to obtain the content of a website. Couple that with a bit of skeleton html that applies the tufte css and you've got a clean, well laid out, version of the page.

```
<html>
  <head>
    <title>{title}</title>
    <link rel='stylesheet' href='https://edwardtufte.github.io/tufte-css/tufte.css'/>
  </head>
  <body>
    {Content goes here}
  </body>
</html>
```

Doing this manually gets tedious really quickly, so I created a bookmarklet that handles the work. Developing and testing that also gets tedious really quickly, so I decided to use [Webpack](https://webpack.github.io/) to do the heavy lifting for me.

The [end result](https://github.com/gilesp/tuftey) is a minified, webpacked bookmarklet that grabs the current url, feeds it into mercury, then replaces the page content with the skeleton html and the content identified by mercury.

```
(function () {
  "use strict";

  var mercury = require("./mercury");
  var template = require("./tufte.html");

  mercury.parseArticle(window.location.href, function (response) {
    document.documentElement.innerHTML = template.replace(/\{(.*?)\}/g, function (match) {
      match = match.substr(1, match.length -2);
      return response[match];
    });
  });

})();
```

And it looks like Mercury now provide a browser extension so I could have just used that, but I wouldn't have got all the Tufte CSS goodness ;-) Plus my main aim was to learn how you could go about doing this, not just find an existing solution.

Feel free to take a look at [the project on github](https://github.com/gilesp/tuftey) if you want to try it out. Pull requests always welcome!
