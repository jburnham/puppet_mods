class mypackages {
    package { "vim-nox":
        ensure => "present"
    }
    package { "git-core":
        ensure => "present"
    }
    service { "puppet":
        ensure => "stopped",
        enable => "false",
    }
}
