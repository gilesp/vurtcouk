+++
author = "giles"
categories = ["Thoughts"]
comments = true
date = "2011-02-07 10:11:56+00:00"
slug = "apt-behind-a-proxy"
title = "Apt behind a proxy"
wordpress_id = 134

+++

At work, we have to run all our web traffic through an NTLM authenticated proxy, which is a bit of a pain on Linux, requiring us to make use of the [cntlm proxy.](http://cntlm.sourceforge.net/) We run this proxy locally on each linux machine (to prevent all traffic appearing as if it comes from one user in the logs), which is fine, but it does cause one or two issues with apt.

Normally I'd run apt as `sudo apt-get ...` but it seems as if the proxy environment variables don't get propagated to the command running under sudo.

To work around this, you need to configure apt directly to use a proxy. To do this, create a file in the `/etc/apt/apt.conf.d` directory called `00proxy`. The file should contain the following:

    
    <code>Acquire {
        Retries "0";
        HTTP {
            Proxy "http://localhost:5865";
        }
    };
    </code>


Now all apt commands should run successfully through the proxy.
