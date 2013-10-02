# stunnel Puppet Module for Boxen
[![Build
Status](https://travis-ci.org/eachscape/puppet-stunnel.png?branch=master)](https://travis-ci.org/eachscape/puppet-stunnel)

## Usage

```puppet
include stunnel

# Tunnel redis connections
stunnel::tunnel { "redis":
  accept  => 6379,  # The port to listen on locally
  connect => "tunnel-server.example.com:1234"  # The stunnel server and port
}
```

## Required Puppet Modules

* boxen
* homebrew
* stdlib
* concat

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.