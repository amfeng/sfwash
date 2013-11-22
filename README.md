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
`sfwash schedule friday`

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

TODOs
----

- Gem-ify
- Set date of pickup via CLI option
- Enter/update details by CLI
