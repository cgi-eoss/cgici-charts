#!/bin/sh

set -u -e

update_gitconfig() {
    while IFS=": " read -r key value; do
        if [ "${DROP_TOKEN}" = "${value}" ]; then
            git config --file $2 --unset-all $key || true
        else
            git config --file $2 $key "$value"
        fi
    done < $1
}

update_plugins() {
    while IFS=": " read -r key value; do
        if [ "${DROP_TOKEN}" = "${value}" ] && [ -e ${key} ]; then
            rm -f ${key}
        else
            target="${2}/${key}"
            echo "Downloading ${value} to ${target}"
            mkdir -p $(dirname $target)
            ${CURL_CMD} $value >$target
        fi
    done < $1
}

for f in $CONFIGS_VOLUME/*; do
    [ -e "$f" ] || continue
    filename="${GITCONFIG_FILE_BASE}/$(basename $f)"
    echo "Updating gitconfig in ${filename} ..."
    update_gitconfig $f $filename
    chmod 644 $filename
    echo "... complete:"
    git config --file $filename --list
done

for f in $SECRETS_VOLUME/*; do
    [ -e "$f" ] || continue
    filename="${GITCONFIG_FILE_BASE}/$(basename $f)"
    echo "Updating secure gitconfig in ${filename} ..."
    update_gitconfig $f $filename
    chmod 600 $filename
    echo "... complete:"
    git config --file $filename --list
done

update_plugins $PLUGINS_CONFIG $PLUGINS_BASE
