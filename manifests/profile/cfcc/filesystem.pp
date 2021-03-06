#
#
#
class profile::cfcc::filesystem {

    # Was gonna do /usr/cfcc but apparently you can't do that on Mac....
    $fs_root = $::kernel ? {
        'windows' => 'C:/CampFitch',
        default   => '/opt/CampFitch'
    }

    File {
        ensure => directory,
        owner  => $turbosite::camper_username,
        group  => $::kernel ? {
            'windows' => 'administrators',
            default   => 'wheel'
        }
    }

    file { $fs_root: }

    $subdirs = ['bin', 'etc', 'usr', 'usr/share']
    $subdirs.each |String $subdir| {
        file { "${fs_root}/${subdir}":
            require => File[$fs_root]
        }
    }
    # file { ["${fs_root}/bin", "${fs_root}/etc", "${fs_root}"]:
    #     require => File[$fs_root]
    # }

    $buildinfo_path = "${fs_root}/etc/buildinfo.txt"
    exec { 'LogInitialBuild':
        command => $::kernel ? {
            'windows' => "Date | Out-File -FilePath ${buildinfo_path}",
            default   => "/bin/date > ${buildinfo_path}"
        },
        creates => $buildinfo_path,
        require => File["${fs_root}/etc"]
    }

}