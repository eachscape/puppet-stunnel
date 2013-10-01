#Config for stunnel
#
class stunnel::config {
  require boxen::config

  $configdir  = "${boxen::config::configdir}/stunnel"
  $configfile = "${configdir}/stunnel.conf"
  $datadir    = "${boxen::config::datadir}/stunnel"
  $executable = "${boxen::config::homebrewdir}/bin/stunnel"
  $logdir     = "${boxen::config::logdir}/stunnel"
  $pidfile    = "${datadir}/stunnel.pid"
  $tunnels    = []
}
