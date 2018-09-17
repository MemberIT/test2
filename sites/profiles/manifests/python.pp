# Profile python
# ==============
#
# Class: profiles::python
# =======================
#
class profiles::python {
  class { '::python':
    python_pips         => lookup('python::python_pips', Hash, 'deep', {}),
    python_virtualenvs  => lookup('python::python_virtualenvs', Hash, 'deep', {}),
    python_pyvenvs      => lookup('python::python_pyvenvs', Hash, 'deep', {}),
    python_requirements => lookup('python::python_requirements', Hash, 'deep', {}),
  }
  create_resources('::python::gunicorn', lookup('python::gunicorns', Hash, 'deep', { require => "Class['::python']", }))
}

