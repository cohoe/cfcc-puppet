#
#
#
class profile::cfcc::filesystem {

    $fs_root = $::kernel ? {
        'windows' => 'C:/CampFitch',
        default   => '/usr/cfcc'
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

    file { ["${fs_root}/bin", "${fs_root}/etc"]:
        require => File[$fs_root]
    }

    $buildinfo_path = "${fs_root}/etc/buildinfo.txt"
    exec { 'LogInitialBuild':
        command => $::kernel ? {
            'windows' => "Date | Out-File -FilePath ${buildinfo_path}",
            default   => "date > ${buildinfo_path}"
        },
        creates => $buildinfo_path,
        require => File["${fs_root}/etc"]
    }

}