#
# CFCC Camper role. This sets up the site for all others.
#
class role::camper inherits role::base {
    # Define the site parameters of the installation. To allow for profiles
    # to reference a generic site container (ie, turbosite::camper_username vs
    # site::cfcc::camper_username), we need to redefine those vars into the generic
    # class container. Include the site::whoever class then define them into
    # a turbosite.
    include site::cfcc

    class { 'turbosite':
        camper_username     => $site::cfcc::camper_username,
        time_zone           => $site::cfcc::time_zone,
        nas_host            => $site::cfcc::nas_host,
        nas_share           => $site::cfcc::nas_share,
        puppet_master       => $site::cfcc::puppet_master,
        nas_installers_path => $site::cfcc::nas_installers_path,
    }

    # Tools need to make the system work. DNS, time, etc. While those
    # examples will be applied to all nodes, they require values from the
    # site class (such as the DNS server, time zone, etc).
    include profile::time::client

    # The basic blocks of a camper PC. These make a generic functioning computer
    # into something that we can actually use.
    include profile::cfcc::camper
    include profile::access::camper

    Class['profile::cfcc::camper'] -> Class['profile::access::camper']
}