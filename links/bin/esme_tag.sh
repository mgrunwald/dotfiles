#!/bin/sh
##############################################################################
# @file esmx_tag.sh
#
# Time-stamp: <>
#
# Author: Markus Grunwald
#

readonly DRY_RUN=""
readonly THIS="${0##*/}"
readonly REVISION="${1}"
readonly TAG_SUBDIR="${2}"
readonly MESSAGE="${3}"
readonly REPOSITORY="https://svn.int.osram-light.com/svn/mch-ESMD/ApplicationController_Firmware"

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

function help() {
    cat << EOF
${THIS} <revision> <tag_subdir> <message>

Will create a tag in ${REPOSITORY}/*/<tag_subdir>

where "*" will match the various libraries that the ESME uses
EOF
    quit
}

[ -z "${REVISION}" ] || [ -z "${TAG_SUBDIR}" ] && help


# myscript

${DRY_RUN} svn copy Application@"${REVISION}"                            "${REPOSITORY}"/Projects/ESME/"${TAG_SUBDIR}"                          -m "${MESSAGE}"
${DRY_RUN} svn copy Library/BluetoothLibrary@"${REVISION}"               "${REPOSITORY}"/Library/BluetoothLibrary/"${TAG_SUBDIR}"               -m "${MESSAGE}"
${DRY_RUN} svn copy Library/CommonRtosLibrary@"${REVISION}"              "${REPOSITORY}"/Library/CommonRtosLibrary/"${TAG_SUBDIR}"              -m "${MESSAGE}"
${DRY_RUN} svn copy Library/DaliUartLibrary@"${REVISION}"                "${REPOSITORY}"/Library/DaliUartLibrary/"${TAG_SUBDIR}"                -m "${MESSAGE}"
${DRY_RUN} svn copy Library/ESMxLibrary@"${REVISION}"                    "${REPOSITORY}"/Library/ESMxLibrary/"${TAG_SUBDIR}"                    -m "${MESSAGE}"
${DRY_RUN} svn copy Library/OelLibrary@"${REVISION}"                     "${REPOSITORY}"/Library/OelLibrary/"${TAG_SUBDIR}"                     -m "${MESSAGE}"
${DRY_RUN} svn copy LibraryThirdParty/CMSIS@"${REVISION}"                "${REPOSITORY}"/LibraryThirdParty/CMSIS_Light/"${TAG_SUBDIR}"          -m "${MESSAGE}"
${DRY_RUN} svn copy LibraryThirdParty/cpputest@"${REVISION}"             "${REPOSITORY}"/LibraryThirdParty/cpputest/"${TAG_SUBDIR}"             -m "${MESSAGE}"
# Embos is already fetched from a tag
#${DRY_RUN} svn copy LibraryThirdParty/embOS@"${REVISION}"                "${REPOSITORY}"/LibraryThirdParty/embOS/"${TAG_SUBDIR}"                -m "${MESSAGE}"
${DRY_RUN} svn copy LibraryThirdParty/ST_MCD@"${REVISION}"               "${REPOSITORY}"/LibraryThirdParty/ST_MCD/"${TAG_SUBDIR}"               -m "${MESSAGE}"
${DRY_RUN} svn copy LibraryThirdParty/STM32F3xx_HAL_Driver@"${REVISION}" "${REPOSITORY}"/LibraryThirdParty/STM32F3xx_HAL_Driver/"${TAG_SUBDIR}" -m "${MESSAGE}"


# Allways call `quit' at end of script
quit
