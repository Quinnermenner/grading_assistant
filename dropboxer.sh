#! /bin/bash

main() {

    # check_for_link
    echo -e "Hey! Because of your workspace hibernating every now and then, sometimes dropbox will lose connection.
    It then gets stuck on 'starting' and will not update the dropbox files. To fix this you'll have to relink dropbox to your workspace.\n"
    relink

}


function restart() {
    read -p "Do you wish to start dropbox now? (Y/N)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
        then
            dropbox.py start
            return
        else
            echo "Did not start dropbox."
            return
    fi
}

function check_for_link() {

    if [[ $(dropbox.py status) == "Dropbox isn't running!" ]];
        then
            dropbox.py start
    fi
    if [[ $(dropbox.py status) != "Starting..." ]];
        then
            echo "Dropbox does not seem to be stuck on 'Starting...'"
            exit 0
    fi
}


function relink() {
    read -p "Want me to run the command for you? (Y/N)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo -e "Will now relink to dropbox! Click the link in the terminal to authorize. Then come back and use ctrl+c to continue.\n"
            sleep 2
            trap restart INT
            dropbox.py stop
            sleep 1
            ~/.dropbox-dist/dropboxd
        else
            echo "No scripts executed."
            exit 0
    fi
}

main "$@"