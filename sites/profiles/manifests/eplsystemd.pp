# Profile eplsystemd
# ==================
#
# Class: profiles::eplsystemd
# ===========================
#
class profiles::eplsystemd {
  $epl_project_path = lookup('epl_project_path', String, 'first', '')
  if empty($epl_project_path) {
    fail("Hiera data 'epl_project_path' is empty!")
  }
  $epl_address = lookup('epl_address', String, 'first', '')
  if empty($epl_address) {
    fail("Hiera data 'epl_address' is empty!")
  }
  $epl_port = lookup('epl_port', Integer, 'first', 0)
  if $epl_port == 0 {
     fail("Hiera data 'epl_port' not found!")
  }
  $epl_user = lookup('epl_user', String, 'first', '')
  if empty($epl_user) {
    fail("Hiera data 'epl_user' is empty!")
  }
  ::systemd::unit_file { 'epl_gunicorn.service':
    content => template("${module_name}/eplsystemd.erb"),
  } ~>
  service { 'epl_gunicorn.service':
    ensure => 'running',
  }
}

