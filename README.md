# WSL Installation and maintenance for Developers

### We have the following situation at work:

We have headless machines running Windows 11 in our office, and ~8 developers need to use ~3 machines.

We use our laptops (from home or from the office) to connect via VPN to our headless machines, since our test environments are not reachable from WAN.

This repo is used to document the initial steps to setup our environment.
This document implies that we have both a clean Windows 11 installation on our headless machine as well as a clean Windows 11 installation on our Laptop.

# Structure

This tutorial is split into two parts:

-   [Setup the headless machine](./headless.md)
-   [Setup the work laptop](./laptop.md)

# Maintenance

You can find maintenance commands like shutting down WSL, restarting WSL, adding users, etc. here:

-   [Maintenance Commands](./maintenance.md)

<br />
<br />
<br />
<br />
<br />
<br />

# Future

In the future, it would be better to use a professional solution.  
A first glance at [coder/coder](https://github.com/coder/coder) seems to be an elegant solution
