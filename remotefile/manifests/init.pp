class remotefile {
    define add($remoteurl) {
        file { "$name":
            content => template("remotefile/remote.erb"),
        }
    }
}
