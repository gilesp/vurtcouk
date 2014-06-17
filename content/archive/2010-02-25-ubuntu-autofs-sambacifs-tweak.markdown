---
author: giles
comments: true
date: 2010-02-25 14:18:51+00:00
layout: post
slug: ubuntu-autofs-sambacifs-tweak
title: Ubuntu AutoFS Samba/CIFS tweak
wordpress_id: 107
categories:
- Hacks
- Work
---

For a while now I've been using [autofs](http://www.autofs.org/) on my work laptop to automatically mount windows shares when I access them. I achieved this by following [this guide on HowtoForge](http://www.howtoforge.com/accessing_windows_or_samba_shares_using_autofs). Everything runs fine and it means I can do a simple  `ls /cifs/machinename` to access all the shares on that particular machine. Provided I'd remembered to create a credentials file for that machine name...

The auto.cifs file shown in the howto requires you to create a credentials file for each machine that you want to access. This is handy when the machines you're accessing have different logins, but here at work all machines authenticate against an Active Directory server and so share the same credentials.

Initially I solved this problem by symlinking to the same credential file, but that's still an inconvenience when you need to access a new machine (and boy, do we have a lot of them). Finally I did the sensible thing and altered the auto.cifs file to fallback to a master credentials file if it can't find a machine specific one. Here's my auto.cifs file:

    
    <code>
    #!/bin/bash
    # This file must be executable to work! chmod 755!
    key="$1"
    # Note: create a cred file for each windows/Samba-Server in your network
    #       which requires password authentification.  The file should contain
    #       exactly two lines:
    #          username=user
    #          password=*****
    #       Please don't use blank spaces to separate the equal sign from the
    #       user account name or password.
    credfile="/etc/auto.smb.$key"
    if [ ! -e $credfile ]
    then
        credfile="/etc/auto.smb.master"
    fi
    
    # Note: Use cifs instead of smbfs:
    mountopts="-fstype=cifs,file_mode=0644,dir_mode=0755,uid=19654,gid=124"
    smbclientopts=""
    for P in /bin /sbin /usr/bin /usr/sbin
    do
    	if [ -x $P/smbclient ]
            then
                    SMBCLIENT=$P/smbclient
                    break
            fi
    done
    [ -x $SMBCLIENT ] || exit 1
    if [ -e "$credfile" ]
    then
            mountopts=$mountopts",credentials=$credfile"
            smbclientopts="-A "$credfile
    else
            smbclientopts="-N"
    fi
    $SMBCLIENT $smbclientopts -gL $key 2>/dev/null \
       | awk -v key="$key" -v opts="$mountopts" -F'|' -- '
            BEGIN   { ORS=""; first=1 }
    	/Disk/  { if (first) { print opts; first=0 };
    		  gsub(/ /, "\\ ", $2);
    		  	   sub(/\$/, "\\$", $2);
    			   	       print " \\\n\t /" $2, "://" key "/" $2 }
            END     { if (!first) print "\n"; else exit 1 }
            '
    </code>
    


The important, and trivial, change is this test:

    
    <code>
    if [ ! -e $credfile ]
    then
        credfile="/etc/auto.smb.master"
    fi
    </code>
    


All it does is check for the existence of the credfile. If it can't find it, it uses /etc/auto/smb/master instead.

The beauty of this is that I can use one credentials file for the majority of the file shares yet still provide different credentials for the one or two servers I need to access as a different user (such as an admin user).
