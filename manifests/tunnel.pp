# Allows other manifests to define tunnels
define stunnel::tunnel($accept, $connect, $order=10) {
  require stunnel

  concat::fragment{ "stunnel_fragment_${name}":
    target  => $stunnel::config::configfile,
    content => template('stunnel/config/stunnel/stunnel_fragment.conf.erb')
  }
}
