+++
title = "QConLondon 2016 Day 1 Notes"
description = "Notes on the sessions I attended at QConLondon2016"
date = 2016-03-07T21:08:04Z
tags = ["qconlondon"]
+++

# @willhillbet Love Failure & Embrace The Fallout<a id="orgheadline1"></a>

WillHill are java centric enterprise but use range of languages as
needed by each project Guiding principles of small apps & leaning
on your platform for heavy lifting are more important. Frontend has
graceful degredation to cope.

-   R&D department looking at mitigating failure
-   Load profile changes depending on event type
    -   Driven by calendar
    -   Cheltenham festival etc.
    -   Very spikey
    -   Capacity to deal with peak load - idle rest oftime
-   Failure matters:
    -   Failure impacts revenue - can't take bets but also can't pay
        them out
    -   Customer retention - people quick to blame/criticise when things
        don't work
-   Rules:
    -   Keep learning
        -   Best time to understand how it works is when it's dying
        -   If its not broken, try harder
        -   Everything is disposable, except ideas & learning. Primarily
            the learning.
-   Development treated as production
-   Vertical scaling - one failure has huge impact
-   Apps built within 2 week period max - usually 2-3 days
    -   Unix philosophy - small services with single putpose.
-   Data flows rather than push/pull (streams)
-   Will Hill apps:
    -   Epoch - sports betting settlement engine (R&D project in progress)
        -   Erlang
            -   Nice syntax (when you get used to it)
            -   Supervisor hierarchy
                -   Actor model (Go, akka other options)
            -   Fail fast
            -   Pattern matching
        -   In memory data store
        -   Production data used for testing - stream of bets
            -   weekend's worth of bets (grand national weekend) - 6.2m
        -   Huge memory usage - process trade off
        -   Switched to ETS - data then fits in 1Gb ram. 
            Changed data model to have process per event, rather than
            process per bet/settlement. Data loaded in ~22 minutes
        -   Changed to Kafka 
            Already in use in Will Hill, elsewhere. Distributed log, that
            can be partitioned. Can replay production data at will. Data
            loaded in ~2 minutes
    -   Development environment is most unstable - build for it.
    -   Gitlab for source control & CI
        -   Docker images are output.
        -   Really tight feedback cycles
    -   WillHill have embraced docker
        First production app in docker went live in june 2015
        -   Looking at docker swarm
            Discovery and load balancing currently requires developing a
            custom load balancer. WillHill have written an opensource app
            Haystack that consumes docker swarm events and balances
            load. Experimental rescheduling (orchestration) support in
            swarm 1.1
-   "Reactive Micro Services" architecture - if you like buzzwords

# Immutable Infrastructure : Rise of Machine Images<a id="orgheadline2"></a>

-   Application of CI model to inframstructure
-   Traditionally sysadmin maintains hardware, os, patches etc.
    -   Can be automated with chef/puppet etc.
-   Now in world of abundance (AWS etc.)
-   Build process now creates machine images as artefact
    But images tend to be large and contain many things that your
    app/service don't need.
-   Strip out? Don't build in? aspects of machine we don't need:
    -   32 bit compatibility, log files, man pages, c compiler etc. etc.
    -   No users, ssh (because nothing to read/access on machine)
    -   No firewall (because nothing left to protect).
-   Aim for the bare minimum to support business requirements - Bootable app.
-   boxfuse automates this process
    -   analyses app and builds minimal image accordingly.
    -   Can deploy to environments
-   Implications of transient machines/images:
    -   Focus Shift 
        you don't care which machine does your work.
    -   Treat servers like cattle instead of pets
    -   CRUD for servers is dead.
        No inplace updating. Uptime is meaningless now.
    -   Need to solve service discovery
        -   Keep things simple.
        -   Use a stable entry point with internal registry (elastic load balancer)
    -   Security
        -   Complexity is enemy of security
        -   Reduction of attack surface to minimum
        -   Reduced implications due to transient nature of instances
        -   No tools installed to exploit other systems - this prevents
            attacker leaping from system to system.
-   Configuration
    Bake as much as possible into artifact and select at runtime.
    -   Environment detection & auto configuration
    -   Pass in flag/environment variable
    -   Encrypt sensitive config and decrypt at runtime - key passed in
-   Persistent state externalised
    Amazon RDS, Google Cloud SQL etc.
-   Logging
    Externalise to log server/service
-   Sessions
    Keep in encrypted cookie on client

# Volvo Trucks - CI/CD<a id="orgheadline3"></a>

-   All trucks of the last 5 years have data connection.
    Wifi for inter truck communication coming, as are automated
    vehicles.
-   Virtualistion is only ay to make CI/CD possible
    Couldn't run 150k braking tests on a real truck
-   Initially Automated functional testing introduced at Volvo
    Has to account for physics of different weather conditions.
    Used real ancilliary systems but extracted from truck. Rack of 24
    "trucks" in a rack.
-   Test system uses virtual functional bus
    Could release SDK in future to allow developers to produce new
    "apps" for trucks

# Cassandra at Apple Scale<a id="orgheadline4"></a>

-   100,000 cassandra instances in production
-   Apple Cassandra team - improves and contributes back
-   Detection and prevention of gossip corruption
-   Gossip
    -   Cluster manager - Failure detection, state , schema propagation
    -   Gossip algorithm didn't take source of info into account
        Node with corrupt data prevents real node from correcting the
        correction.  Have to replace node that other node has corrupted
        data about with a new node to work around corruption.
    -   Apple implemented signature state to allow detection of corrupt data.
-   Distributed deletes coupled with corrupt data
    -   Tombstones (data deletion flags) hang around for minimum of 10 days (GC Grace)
    -   Apple created patch to delete without waiting for this (preventing data reappering)
-   Avoid consistency violation with host replacement
    -   Concistency level 
        Number of machines that must be written to for data to be
        considered consitent across cluster
    -   Machine replacement can mean invalid node is used to instantiate new node
        This results in consistency violation as you have two invalid nodes
    -   Apple have written patch to allow running repair when a machine is down
        Therefore bringing up a new machine will only use repaired
        nodes.

# Far From The Mobbing Crowd<a id="orgheadline5"></a>

-   Matt Wynne and Steve Tooke of cucumber talked about their
    experiences with mob probramming and building a company that
    reflects their values.
-   Identify company values
    -   Mountains & Vallies reflection exercise to identify core values
    -   culturesync.net/happiness
    -   Book: eMyth Revisited: Why Most Small Business Don't Work and
        What to Do About it (<http://www.amazon.co.uk/The-E-Myth-Revisited-Small-Businesses/dp/0887307280>)
-   Cucumber: New Team & New Tech Stack
    -   XP Veterans
    -   Opensource/Distributed Teams tend to work solo
    -   Wanted to try Mob programming
        -   Not at same machine or place
        -   Wanted to realise benefits of being in own space (family etc.)
        -   Mob is ~6 People
        -   Least knowledgeable person drives to avoid "bored spectator" issue
        -   Mob arrives at good solutions quicker
            Less chance of following wrong route then with pairing.
        -   Tools:
            -   Slack with Screen Hero
                -   Multi pointers, shares your machine with others
            -   Google Hangouts for seeing & hearing each other
        -   Lessons:
            1.  It's harder to understand other's feelings, opinions etc.
            2.  Have to work hard at over communicating
            3.  Need to be kinder about code:
                1.  Only "criticise" when tests are passing
                2.  If problem, only help get to green
            4.  Daily retrospective
                1.  MD file, committed to master branch
        -   Schedule:
            Morning: 
               8.30: Mob starts
               11:45: Retrospective
               12:00 Lunch
            Afternoon: Rest of business work (consulting, research etc.)
        -   The mob can only work for so long before running out of
            certainty. ~4 hours.
        -   It's very intense, need time for divergent thinking: research,
            investigations etc.
        -   Circular conversations are indicator of lack of certainty
            -   Set based thinking as way to solve this (e.g. 1hr+ to
                investigate "spike")
        -   The mob is very resilient:
            -   Carries on if you step away
            -   Easy to rejoin
            -   Handles change of members
            -   Is 24 Hour mob possible? With big lgobal team ;-)
    -   Meetups used to meet in real world
        -   Whole company
        -   subsets
        -   open source community
        -   No office space overheads so meetups can be funded.
    -   Values:
        -   Adventure (taking risks)
        -   Independence
        -   Community (Compassion)
            Caring to each other but also the code
        -   Purpose
            Seeing the benefit of your work
        -   Play
            Should be possible to find enjoyment in any aspect of work.
    -   Cucumber is a continuation of the XP experiment: How would you
        develop if you had enough time? ->  How would you run a
        development shop if you are a group of developers?

# Acceptance Testing for Continuous Delivery<a id="orgheadline6"></a>

-   Dave Farley
-   Acceptance Testing
    -   Definition of Done.
    -   Test per acceptance criteria
    -   provides timely feedback
-   Problems:
    -   Brittle due to coupling
    -   Complex to develop
-   Separate Test/QA Team is toxic anti pattern
-   Developers own ATs
-   Good ATs:
    -   Use language of problem domain
    -   What not how
    -   Isolated & Repeatable
    -   Efficient!
-   Function isolation to avoid dependencies between tests
-   Temporal isolation
    -   Create aliases for actual data
        e.g. Book Title (in test) -> Book Title 1234 (in DB)
