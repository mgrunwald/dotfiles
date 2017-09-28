#!/bin/bash
##############################################################################
# @file esme_apptag.sh
#
# Time-stamp: <>
#
# Author: Markus Grunwald
#

readonly THIS="${0##*/}"
readonly FROM=${1}
readonly TO=${2}

readonly REPOSITORY='https://svn.int.osram-light.com/svn/mch-ESMD/grunwald/ESME'
readonly DRY_RUN=""
readonly CHECKOUT_PATH="$(mktemp -d)"

# Let shell functions inherit ERR trap.  Same as `set -E'.
set -o errtrace

# Trigger error when expanding unset variables.  Same as `set -u'.
set -o nounset

#  Trap non-normal exit signals: 1/HUP, 2/INT, 3/QUIT, 15/TERM, ERR
#  NOTE1: - 9/KILL cannot be trapped.
#        - 0/EXIT isn't trapped because:
#          - with ERR trap defined, trap would be called twice on error
#          - with ERR trap defined, syntax errors exit with status 0, not 2
#  NOTE2: Setting ERR trap does implicit `set -o errexit' or `set -e'.
trap quit 1 2 3 15 ERR


#--- quit() -----------------------------------------------------
#  @param $1 integer  (optional) Exit status.  If not set, use `$?'
#  @param $2 message  (optional) Error/exit message
#
#  Use "quit" instead of "exit" to cleanly quit this script
#  Allways call `quit' at end of script

function quit() {

    local exit_status=${1:-$?}
    local message=${2:-""}
    [ -n "${message}"    ] && echo "${message}"
    [ ${exit_status} -ne 0 ] && echo Exiting $0 with status $exit_status
    exit $exit_status
}

function help {
    cat << EOF
${THIS} <from> <to>

Copies a repository in ${REPOSITORY} to a tag and adjusts the externals.

Example:

${THIS} branches/DALI_ECO_BT_CONTROL_RC_1_1 tags/DALI_ECO_BT_CONTROL/RC_1_1/TEST_TAG_SCRIPT_01
EOF

quit
}

[ -z "${FROM}" ] || [ -z "${TO}" ] && help

${DRY_RUN} svn copy                        "${REPOSITORY}"/"${FROM}" "${REPOSITORY}"/"${TO}" -m "Created a TAG"
${DRY_RUN} svn checkout --ignore-externals "${REPOSITORY}"/"${TO}"   "${CHECKOUT_PATH}"

${DRY_RUN} cd ${CHECKOUT_PATH}

${DRY_RUN} svn propget svn:externals . > Application.externals
${DRY_RUN} svn propget svn:externals Library > Library.externals
${DRY_RUN} svn propget svn:externals LibraryThirdParty > LibraryThirdParty.externals

${DRY_RUN} sed -i s\|"${FROM}"\|"${TO}"\| Application.externals Library.externals LibraryThirdParty.externals
${DRY_RUN} sed -i s\|"${FROM}/3.8-build-i686-pc-mingw32-gcc5.7.0"\|"${TO}"\| LibraryThirdParty.externals

${DRY_RUN} svn propset svn:externals -F Application.externals       .
${DRY_RUN} svn propset svn:externals -F Library.externals           Library
${DRY_RUN} svn propset svn:externals -F LibraryThirdParty.externals LibraryThirdParty

${DRY_RUN} svn diff .

echo "Now please commit in $(pwd) if all is fine and delete this directory."

# Allways call `quit' at end of script
quit
