# Allows other manifests to define tunnels
define stunnel::tunnel($accept, $connect, $ensure=present, $priority=10) {
  include stunnel

  realize Concat[$stunnel::config::configfile]

  concat::fragment{ "stunnel_fragment_${name}":
    target  => $stunnel::config::configfile,
    content => template('stunnel/config/stunnel/stunnel_fragment.conf.erb'),
    order   => $priority
  }
}
