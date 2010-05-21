class rootconfig {

    File {
        owner => root,
        group => root,
        mode => 0644,
    }

    file { "/root/.vimrc":
        content => template("rootconfig/vimrc.erb"),
    }
    file { "/root/.screenrc":
        content => template("rootconfig/screenrc.erb"),
    }
}
