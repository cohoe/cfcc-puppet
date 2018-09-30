#
# TurboPuppet Site class. This class holds environmental parameters
# for the location that we are managing. For example, Camp Fitch! This
# class should NEVER actually do anything (define resources, etc). It is
# purely for holding variables. Those variables are stored in a site::something
# class located in the manifests/site/ directory.
#
# Do not confuse this with the Puppet site.pp file. That file defines resources
# and things that apply to all nodes under Puppet's control. The word "site"
# happens to be relevant in both of our cases.
#
class turbosite (
    $camper_username,
    $time_zone,
    $puppet_master,
) {
    $camper_homedir = $::kernel ? {
        'windows' => "C:/Users/${camper_username}",
        'Linux'   => "/home/${camper_username}",
        default   => fail('Unsupported OS')
    }
}