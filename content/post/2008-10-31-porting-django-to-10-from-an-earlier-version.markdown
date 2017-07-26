+++
author = "giles"
comments = true
date = "2008-10-31 15:05:08+00:00"
slug = "porting-django-to-10-from-an-earlier-version"
title = "Porting Django to 1.0 from an earlier version"
wordpress_id = 67

+++

I use [django](http://www.djangoproject.com/) for a [personal web development project](http://www.c4mbodia.com/) and whilst it is a lovely framework, it's been undergoing very active development to get it to a 1.0 release. The previous release was 0.96 but that was sometime before I started my project, so I've been working to a version checked out of subversion around 4 months ago which contained some new features but not everything that eventually made it into 1.0




As part of my recent desire to sort my life out and get more things done, I've been adding features to my project and have decided to get it running in django 1.0. Now, as I was using a version of django part way between 0.96 and 1.0 I didn't have as much work to do as I anticipated, which was nice. What was even nicer, was this helpful [guide to porting](http://docs.djangoproject.com/en/dev/releases/1.0-porting-guide/) on the excellent django documentation site.




As I was already suing the newforms module, a few renames later had me working using the forms name instead. And most of my other changes were fairly minor as well, I'm glad I decided to use a post-0.96 version when I started my project otherwise I'd have had a fair bit more work to do. The most major changes came with the Admin functionality for my models as this has changed quite significantly. It's all well documented though, so an hour or so later I had some new admin.py files detailing the admin interfaces to my models. 




I did run in to two stumbling points though. I use modified pre-order tree traversal for a number of my models and the [third-party implementation](http://code.google.com/p/django-mptt/) I was using wasn't playing nice with the new django admin stuff. However, a quick svn checkout of the latest revision got me past that problem. The second stumbling block was with getting my user profile models to be displayed inline with the django authentication User model in the admin interface. The trick is to first unregister the User model from the admin site and then re-register it with my own admin class:




``



    
    
    from django.contrib import admin
    from django.contrib.auth.models import User
    from django.contrib.auth.admin import UserAdmin
    
    from users.models import UserProfile
    
    admin.site.unregister(User)
    
    # Set it up so we can edit a user's profile inline in the admin
    class UserProfileInline(admin.StackedInline):
        fields = ('donated', 'tagline', 'birthday', 'profile')
        model = UserProfile
    
    class MyUserAdmin(UserAdmin):
        inlines = [UserProfileInline]
    
    # re-register the User with the extended admin options
    admin.site.register(User, MyUserAdmin)
    







And that was it - I now have a version of my site ready to roll with django 1.0



