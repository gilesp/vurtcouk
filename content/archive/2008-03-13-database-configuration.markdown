---
author: giles
comments: true
date: 2008-03-13 15:27:43+00:00
layout: post
slug: database-configuration
title: Database Configuration
wordpress_id: 54
categories:
- Work
---

At work, we're building a new website for the organisation based around the [InfoGlue CMS](http://www.infoglue.org/). It's an open source, java based content management system that provides nice separation between content and site structure and is extensible enough for us to tailor the admin side of things to our users needs. All in all, decent stuff.




One thing that has been a source of immense frustration to me has been the way they configure database connections. Like most good Java apps, they make use of abstraction layers such as [Hibernate](http://www.hibernate.org/), [Apache DBCP](http://commons.apache.org/dbcp/) and so on. However, no effort has been made to unify the database configuration, so each of these tools and layers has their own configuration file, requiring the same database connection string and credentials to be entered into them.




Now, the reason this caused me problem? I had identified two of the configuration files, but missed the critical third one, so when moving the installation from my local machine to a test server, I ran into endless fatal errors informing me that the Oracle drivers couldn't establish a connection...




Infoglue has a graphical installer which is great for setting up a test install on your local machine as it handles these configuration files for you, but this is no good when you need to install on a headless server, hence my running into problems when moving the install from one machine to another. And don't get me started on the fact that they obviously haven't tested the release against Oracle as the database scripts it uses to set things up miss out vital config data that is present in the MySQL scripts. That only took me a day to figure out though, luckily ;-)




So, how could this database config problem have been avoided? Well, either by unifying the configuration into one file, or better yet, making use of a JNDI data source, as is standard on JBoss. This way, you define the connection once and then use the JNDI name to get the connection when it's required. It's supported by hibernate et al so why didn't they do this? I guess the main reason is probably because it's trickier to configure this on Tomcat than on JBoss and the default Infoglue setup is Tomcat with MySQL. 




If I get time (ha!) I'll take a look and see how much work would be involved to make this change and then see about submitting the patch back to the Infoglue developers. Don't get me wrong, the product is good, I'm just irked by having wasted so much time on a problem that could have been avoided if vital configuration wasn't being duplicated like this.



