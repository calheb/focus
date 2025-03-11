#!/usr/bin/env bash

SCRIPT_NAME="focus"
SCRIPT_PATH="/usr/local/bin/$SCRIPT_NAME"
SUDOERS_PATH="/etc/sudoers.d/focus"
NORMAL_HOSTS="/etc/hosts.normal"
BLOCKED_HOSTS="/etc/hosts.blocked"

if [ -n "$SUDO_USER" ]; then
  USER_HOME=$(eval echo ~${SUDO_USER})
else
  USER_HOME=$HOME
fi

LOG_DIR="$USER_HOME/.local/share/focus"
LOG_FILE="$LOG_DIR/focus.log"

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo privileges."
    echo "Run: sudo $0"
    exit 1
fi

restore_hosts() {
    if [[ -f "$NORMAL_HOSTS" ]]; then
        echo "Restoring original hosts file from backup..."
        cp "$NORMAL_HOSTS" "/etc/hosts"
    else
        echo "No hosts backup file found at $NORMAL_HOSTS"
    fi
}

remove_script() {
    if [[ -f "$SCRIPT_PATH" ]]; then
        echo "Removing focus from PATH: $SCRIPT_PATH..."
        rm "$SCRIPT_PATH"
    else
        echo "focus script not found at $SCRIPT_PATH"
    fi
}

remove_sudoers() {
    if [[ -f "$SUDOERS_PATH" ]]; then
        echo "Removing sudo permissions from $SUDOERS_PATH..."
        rm "$SUDOERS_PATH"
    else
        echo "Sudo permissions file not found at $SUDOERS_PATH"
    fi
}

clean_backups() {
    echo -e "\nDo you want to remove the backup hosts files? (Y/n)"
    read -r response
    response=${response:-Y}
    if [[ "${response^^}" == "Y" ]]; then
        if [[ -f "$NORMAL_HOSTS" ]]; then
            rm "$NORMAL_HOSTS"
            echo "(1/2) Removed normal hosts backup: $NORMAL_HOSTS"
        fi
        if [[ -f "$BLOCKED_HOSTS" ]]; then
            rm "$BLOCKED_HOSTS"
            echo "(2/2) Removed blocked hosts backup: $BLOCKED_HOSTS"
        fi
    else
        echo "Backup files have not been altered."
    fi
}

clean_logs() {
    echo -e "\nDo you want to remove the focus logs? (Y/n)"
    read -r response
    response=${response:-Y}
    if [[ "${response^^}" == "Y" ]]; then
        if [[ -d "$LOG_DIR" ]]; then
            rm -rf "$LOG_DIR"
            echo "Removed logs at: $LOG_DIR"
        else
            echo "No logs found at: $LOG_DIR"
        fi
    else
        echo "Logs have not been altered."
    fi
}

echo "Uninstalling focus..."

restore_hosts
remove_script
remove_sudoers
clean_backups
clean_logs

echo -e "\nfocus has been uninstalled from your system."
