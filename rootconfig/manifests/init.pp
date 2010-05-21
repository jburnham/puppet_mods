class rootconfig {
    include remotefile

    File {
        owner => root,
        group => root,
        mode => 0644,
    }

    remotefile::add { "/root/.vimrc":
        remoteurl => "http://gist.github.com/raw/406927/.vimrc",
    }

    remotefile::add { "/root/.screenrc":
        remoteurl => "http://gist.github.com/raw/406926/.screenrc",
    }
}
