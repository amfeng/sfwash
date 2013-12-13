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

Install the gem:

```
$ gem install sfwash
```

Then, to schedule a pickup (make sure you have your config file created first):

```
$ sfwash schedule
```

Or provide a day of the week:

```
$ sfwash schedule friday
```

Config file
----

At the moment, you must have a `~/.sfwash` config file to use this script.
Example config file:

```
:preferences:
  :name: Amber Feng
  :phone: 555-555-5555
  :email: amber.feng@gmail.com
  :address: 123 Main Street
  :apartment: N/A
  :day: Friday
  :time: Anytime_Access
  :instructions: OldPreferences
  :detergent: Last Order
  :bleach: Last Order
  :softener: Last Order
```
