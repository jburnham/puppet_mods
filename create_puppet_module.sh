#!/bin/bash

EXPECTED_ARGS=1
if [ $# -ne $EXPECTED_ARGS ]
then
	echo "Usage: `basename $0` [modulename]"
        exit
fi

if [ -d $1 ]
then
	echo "ERROR: $1 is a directory. For safety, exiting, as it would destroy data if I ran again."
	exit
fi

mkdir -p $1/{depends,files,manifests,templates,test}

echo -e "Basic README for $1\nTest in this directory by running [sudo] ./test/run.sh [noop|reallyrun]" > $1/README
echo -e "class $1 {\n\n}" > $1/manifests/init.pp
echo -e "include \"$1\"" > $1/test/init.pp

# inline script. Done in a subshell to prevent variable expansion
(
cat <<'EOF'
#!/bin/bash
EXPECTED_ARGS=1
if [ $# -ne $EXPECTED_ARGS ]
then
	echo "Usage: `basename $0` [noop|reallyrun]"
        exit
fi

NOOP="--noop"
if [ "$1" = "reallyrun" ]
then
	NOOP=""
fi

PWD=`pwd`
MODULEPATH="$PWD/.."

LIBDIR=""

if [ -d $PWD/plugins ]
then
	LIBDIR="--libdir $PWD/plugins"
fi

echo "MODULEPATH: $MODULEPATH LIBDIR: $LIBDIR"

puppet $NOOP -d --modulepath=$MODULEPATH $LIBDIR test/init.pp
exit 0
EOF
) > $1/test/run.sh

chmod 755 $1/test/run.sh
