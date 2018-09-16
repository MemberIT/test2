# Profile docker
# ==============
#
# Class: profiles::docker
# =======================
#
class profiles::docker {
  class { '::docker':
    ipv6 => false,
  }
}
