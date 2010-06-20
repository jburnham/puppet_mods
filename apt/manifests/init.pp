class apt {

    define conf_file($source) {
        file { "/etc/apt/$name":
            owner => 'root',
            group => 'root',
            mode => '0644',
            source => $source,
            before => Exec["apt-get_update"],
            notify => Exec["apt-get_update"],
        }
    }

    exec { "apt-get_update":
        command => "/usr/bin/apt-get update",
        refreshonly => true,
    }   
}
