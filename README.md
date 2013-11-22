sfwash
====

A CLI for scheduling pickups on SFWash (http://sfwash.com/schedule-a-pick-up).

SFWash, unfortunately, requires you to fill in your information (address, phone
number, etc) with them every time. This script will save your details on your
machine, and reuse them every time you need to schedule a pickup. Hooray!

Note: This code may be horribly brittle because it basically just POSTs to
the SFWash website with the parameters required at the time of writing, but oh
well!

Usage
----

`sfwash schedule`

TODOs
----

- Gem-ify
- Set date of pickup via CLI option
- Enter/update details by CLI
