#
# The baby version of Python Turtle
# The PythonTurtle library is provided with Python3.
# Also of note - PythonTurtle != Turtle. The latter is an HTTP library.
#
class profile::python::turtle {
    case $::kernel {
        'windows': {
            # The package name is obnoxious.
            # https://puppet.com/docs/puppet/5.0/resources_package_windows.html#packages-that-include-version-info-in-their-displayname
            package { 'PythonTurtle 0.1':
                provider => windows,
                source   => 'puppet:///campfs/pythonturtle-0.1.2009.8.2.1-unattended.msi',
            }
        }
        'Linux': {
            # There is no EZ-Turtle for Linux
        }
        'Darwin': {
            $local_dmg_path = '/var/tmp/PythonTurtle.Mac.installer.dmg'
            file { 'turtle-dmg':
                source => 'puppet:///campfs/PythonTurtle.Mac.installer.dmg',
                path   => $local_dmg_path
            } ->
            package { 'PythonTurtle':
                ensure   => present,
                provider => appdmg,
                source   => $local_dmg_path
            }
        }
        default: {}
    }

}
