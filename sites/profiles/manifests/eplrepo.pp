# Profile eplrepo
# ===============
#
# Class: profiles::eplrepo
# ========================
#
class profiles::eplrepo {
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
  vcsrepo { $epl_project_path:
    ensure   => present,
    provider => 'git',
    source   => $epl_url_repo,
    revision => $epl_git_revision,
    user     => $::nginx::daemon_user,
  } 
}

