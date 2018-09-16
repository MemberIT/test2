# Profile nginx_epl
# =================
#
# Class: profiles::nginx::epl
# ===========================
#
class profiles::nginx::epl {
  $epl_address = lookup('epl_address', String, 'first', '')
  if empty($epl_address) {
    fail("Hiera data 'epl_address' is empty!")
  }  
  $epl_port = lookup('epl_port', Integer, 'first', 0)
  if $epl_port == 0 {
     fail("Hiera data 'epl_port' not found!")
  }
  ::nginx::resource::server { 'epl.memberit.ru':
    ensure              => present,
    server_name         => [ 'epl.memberit.ru' ],
    resolver            => $::dns_nameservers,
    format_log          => 'json_main',
    error_log           => '/var/log/nginx/error.log warn',
    proxy               => "http://${epl_address}:${epl_port}",
  }
}

