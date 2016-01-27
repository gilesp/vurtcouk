---
author: giles
comments: true
date: 2008-11-30 16:18:43+00:00
layout: post
slug: technotrend-s-1500-ci-and-mythtv-remote-control
title: Technotrend S-1500 CI and Mythtv Remote Control
wordpress_id: 71
---

Back in January, I built myself a PVR using [MythTV](http://www.mythtv.org/) (I went for the [Mythbuntu](http://www.mythbuntu.org/) distribution to simplify things) and have been very happy with it on the most part. However a recent distribution upgrade from Ubuntu Hardy to Ubuntu Intrepid left me with a non-working remote control which was not ideal, to say the least.




Now a bit of background, I'm using a [Technotrend S-1500](http://www.technotrend.de/2763/TT-budget__S-1500.html) tv capture card to receive free-to-air  satellite transmissions here in the UK (aside: I originally chose this card because it came with a CI slot which I could use with a Dragon CAM to get subscription services from Sky - a not supported configuraiton but working according to my research. However with the release of FreeSat, I decided not to bother and stick to the free to air services, including BBC HD and 8 day program guide). This card comes with a little IR eye and a remote control to make interacting with Mythtv easy.




Configuring Lirc took a bit of trial and error because I couldn't find a configuration file for the remote control. There's plenty of documentation out there on how to configure Lirc, that assumes you have a more common remote. One of the best guides is [Garry Parker's MythTv guide](http://www.parker1.co.uk/mythtv_ubuntu2.php), which includes a [nice tip](http://www.parker1.co.uk/mythtv_tips.php) on ensuring your remote receiver get allocated the same id each time. However, without the lircd.conf file, you need to create one using irrecord. For me it was a case of running this command:




`irrecord --driver=dev/input --device=/dev/input/event6 lircd.conf`




Follow the onscreen prompts and away you go, using that file in your lirc configuration.




This served me well until the aforementioned system upgrade to Ubuntu Intrepid.  My remote suddenly stopped working, except for the arrow keys and the 0-9 numbers. I went back over the configuratiosn with a fine toothed comb but everything seemed to be correct. I thought that maybe the signal from the remote was being interpreted differently, so I decided to try regenerating the configuration file with irrecord but now irrecord was telling me it couldn't get exclusive access to the hardware, despite me shutting down mythtv and lircd! Something was very wrong...




After a lot of searching, I came across [this page](https://bugs.launchpad.net/ubuntu/+source/lirc/+bug/204960) that shed light on the problem and gave me a solution. Essentially, X was grabbing control of the input and treating it like a keyboard, which is why the number buttons and arrow buttons were working but nothing else. The solution is to enter your car'd product string into the `/usr/share/hal/fdi/preprobe/20thirdparty/lirc.fdi` file as an exception. This mean X will ignore the input and let Lirc handle it instead. Annoyingly, my card is based on the saa7134 chipset and there was an exception for those card already in the lirc.fdi file. Unfortunately, my card's product string is "Budget-CI dvb ir receiver saa7146 (0)" which didn't match, so I needed to add another one...




Anyway, I now have a working remote control, which is nice, but I can't help but feel that this is a bit of a backwards step, in that these devices worked before the changes to the HAL system and now, a fairly large list of exceptions needs to be maintained to ensure that cards continue to function as they used to. I'm sure there are good reasons for the changes but it's one of those things that as an end user I just find irritating :-)



