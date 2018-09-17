# Profile eplrepo
# ===============
#
# Class: profiles::eplrepo
# ========================
#
class profiles::eplrepo {
  $epl_user = lookup('epl_user', String, 'first', '')
  if empty($epl_user) {
    fail("Hiera data 'epl_user' is empty!")
  }
  $epl_www = lookup('epl_www', String, 'first', '')
  if empty($epl_www) {
    fail("Hiera data 'epl_www' is empty!")
  }
  $epl_project_path = lookup('epl_project_path', String, 'first', '')
  if empty($epl_project_path) {
    fail("Hiera data 'epl_project_path' is empty!")
  }
  $epl_url_repo = lookup('epl_url_repo', String, 'first', '')
  if empty($epl_url_repo) {
    fail("Hiera data 'epl_url_repo' is empty!")
  }
  $epl_git_revision = lookup('epl_git_revision', String, 'first', '')
  if empty($epl_git_revision) {
    fail("Hiera data 'epl_git_revision' is empty!")
  }
  user { $epl_user:
    ensure     => present,
    shell      => '/usr/sbin/nologin',
    managehome => true,
  } ->
  file { $epl_www:
    ensure => directory,
    owner  => $epl_user,
    group  => $epl_user,
    mode   => '0751',
  } ->
  vcsrepo { $epl_project_path:
    ensure   => present,
    provider => 'git',
    source   => $epl_url_repo,
    revision => $epl_git_revision,
    user     => $epl_user,
    before   => ::Python::Virtualenv[$epl_project_path],
  } 
}

