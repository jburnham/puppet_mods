class sudo {
	file { "/etc/sudoers":
                owner => root,
                group => root,
                mode => 440,
                source => "puppet:///modules/sudo/sudoers.debian"
        }

}
