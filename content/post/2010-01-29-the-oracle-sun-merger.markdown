+++
author = "giles"
comments = true
date = "2010-01-29 10:38:30+00:00"
slug = "the-oracle-sun-merger"
tags = ["development", "Java", "merger", "opensource", "Oracle", "Sun"]
title = "The Oracle/Sun Merger"
wordpress_id = 103

+++

Well, now that [the EU has approved the Sun/Oracle merger](http://www.dailyfinance.com/story/european-union-approves-oracle-sun-merger/19328181/), the [details of which Sun technologies will survive](http://www.theregister.co.uk/2010/01/29/oracle_sun_java_open_source/) have started to emerge.

First a little history; Oracle bought BEA, makers of Java application server Weblogic, a number of years ago. Sun, obviously, has their own opensource application server Glassfish. Oracle isn't known for their embracing of opensource philosophies so there was a lot of worry that the Sun technologies would get dropped and merely have the good bits integrated into Oracle's products.

As it turns out, Oracle is doing some of that, but they're also keeping the Sun products around but targeting them at a lesser departmental level than Oracle's own offerings.

Sun's [HotSpot](http://java.sun.com/javase/technologies/hotspot/) virtual machine is getting merged with Oracle's [JRockit ](http://www.oracle.com/technology/products/jrockit/index.html)vm, so now there will be one "high performance" virtual machine to choose, hopefully better than the separate ones.

[JavaFX](http://javafx.com/), Sun's attempt at competing with Silverlight and Adobe Flex lives on for some reason. And who knows, maybe Oracle can make it an attractive proposition, lord knows Sun couldn't.

Sun's IDE [NetBeans](http://netbeans.org/) lives on, along with [Glassfish](https://glassfish.dev.java.net/) but will be target at departmental applications rather than enterprise ones. Oracle's JDeveloper and Weblogic will be marketed as the tools of choice for full scale enterprise apps (mainly because Oracle can charge for Weblogic, I would guess).

Thankfully[ Hudson](http://hudson-ci.org/), Sun's open source continuous integration and deployment server/tool lives on under Oracle's ownership. This is particularly good news for me as I've been looking at that for improving the Java development and deployment at my employers (I'd have hated to have gone down that route only to find the product is being mothballed).

As for development of Java as a language, Oracle now has main control over the Java SE, EE and ME specifications and they've committed to adding more staff and money to developing them, which is good. Although it remains to be seen which directions Oracle will choose to take the language in.

As an aside, I notice that the Sun website has now been Oracle-ised, which means it'll probably end up being as painful to navigate as Oracle's. Look forward to URLs changing on a weekly basis and bookmarks to help pages and so on dying regularly!
