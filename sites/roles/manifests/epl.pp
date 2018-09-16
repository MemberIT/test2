# Role epl
# ========
#
# Class: roles::epl
# =================
#
class roles::epl {
  contain ::profiles::nginx::common
  contain ::profiles::nginx::epl
  contain ::profiles::eplrepo
  contain ::profiles::python
  contain ::profiles::eplsystemd

  Class['::profiles::nginx::common'] ->
    Class['::profiles::nginx::epl'] ->
    Class['::profiles::eplrepo'] ->
    Class['::profiles::python'] ->
    Class['::profiles::eplsystemd']

}
