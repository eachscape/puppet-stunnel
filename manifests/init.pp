# Install stunnel
#
class stunnel {
  include stunnel::config
  include homebrew

  # Install our custom plist for stunnel.

  file { '/Library/LaunchDaemons/dev.stunnel.plist':
    content => template('stunnel/dev.stunnel.plist.erb'),
    owner   => 'root',
    group   => 'wheel',
    notify  => Service['dev.stunnel']
  }

  # Set up all the files and directories stunnel expects. We go
  # nonstandard on this mofo to make things as clearly accessible as
  # possible under $BOXEN_HOME.

  file { [
    $stunnel::config::configdir,
    $stunnel::config::datadir,
    $stunnel::config::logdir
  ]:
    ensure => directory
  }

  concat { $stunnel::config::configfile:
    mode   => '0644',
    notify => Service['dev.stunnel']
  }

  concat::fragment { 'stunnel_global_config':
    target  => $stunnel::config::configfile,
    content => template('stunnel/config/stunnel/stunnel.conf.erb'),
    order   => 01
  }

  # Remove Homebrew's nginx config to avoid confusion.
  file { "${boxen::config::home}/homebrew/etc/stunnel":
    ensure  => absent,
    force   => true,
    recurse => true,
    require => Package['stunnel']
  }

  package { 'stunnel':
    ensure => '4.56',
    notify => Service['dev.stunnel']
  }

  service { 'dev.stunnel':
    ensure  => running,
    require => Package['stunnel']
  }
}
