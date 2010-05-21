class puppetdebian {
    $puppet_version = "0.25.4"
    $facter_version = "1.5.7"
    $ruby_version   = "1.8.7"

    apt_conf_file { "sources.list": }
    apt_conf_file { "apt.conf.d/release": }
    apt_conf_file { "apt.conf.d/71cache_limit": }
    apt_conf_file { "apt.conf": }
    apt_conf_file { "preferences": }

    exec { "apt-get_update":
        command => "/usr/bin/apt-get update",
        refreshonly => true,
    }

    package { 'puppet':
        ensure => latest,
        require => Exec["apt-get_update"];
    }
    package { 'facter':
        ensure => latest,
        require => Exec["apt-get_update"];
    }
    package { 'ruby1.8':
        ensure => latest,
        require => Exec["apt-get_update"];
    }

    package { 'lsb-release':
        ensure => installed,
    }

    package { 'debian-backports-keyring':
        ensure => latest,
        require => Exec["apt-get_update"];
    }

    alert("You now have the latest version of the puppet client and your apt configs have been minimally configured to support this.  Go talk to a puppetmaster to get useful apt config files.")

}

define apt_conf_file {
    file { "/etc/apt/$name":
    group => 'root',
    owner => 'root',
    mode => '0644',
    source => "puppet:///puppetdebian/$name",
        notify => Exec["apt-get_update"],
    }
}
