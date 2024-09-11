#!/bin/bash
#
#  |════════════════════════════════════════════════════════════════════════════════════════════════════════════════|
#  • Autoscript AIO Lite Menu By FN Project                                          |
#  • FN Project Developer @Rerechan02 | @PR_Aiman | @farell_aditya_ardian            |
#  • Copyright 2024 18 Marc Indonesia [ Kebumen ] | [ Johor ] | [ 上海，中国 ]       |
#  |════════════════════════════════════════════════════════════════════════════════════════════════════════════════|
#

function fixed_akun() {
    # Retrieve usernames from /etc/xray/config.json
    users=$(grep '^###' /etc/xray/config.json | cut -d ' ' -f 2 | sort | uniq)

    # Loop through each username
    for user in $users; do
        quota_file="/etc/xray/quota/${user}"
        usage_file="/etc/xray/quota/${user}_usage"

        # Check if the quota file exists
        if [ ! -f "$quota_file" ]; then
            # Create the file and set the quota to 100GB
            echo "$((100 * 1024 * 1024 * 1024))" > "$quota_file"
            echo "Created quota file for user $user with 100GB limit."
        else
            # Optional: Check if the file size is correct, and if not, correct it.
            current_quota=$(cat "$quota_file")
            if [[ $current_quota -ne $((100 * 1024 * 1024 * 1024)) ]]; then
                echo "Quota file for user $user exists but has an incorrect size. Size is $current_quota."
            else
                echo "Quota file for user $user already exists with the correct size."
            fi
        fi

        # Check if the usage file exists
        if [ ! -f "$usage_file" ]; then
            touch "$usage_file"
            echo "Created usage file for user $user."
        else
            echo "Usage file for user $user already exists."
        fi
    done
}


function send_log() {
    CHATID=$(cat /etc/funny/.chatid)
    KEY=$(cat /etc/funny/.keybot)
    TIME="10"
    TEXT="
<code>────────────────────</code>
<b>⚠️NOTIF QUOTA HABIS⚠️</b>
<code>────────────────────</code>
<code>Username  : </code><code>$user</code>
<code>Usage     : </code><code>$total</code>
<code>────────────────────</code>
"
    curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}

function con() {
    local -i bytes=$1
    if [[ $bytes -lt 1024 ]]; then
        echo "${bytes}B"
    elif [[ $bytes -lt 1048576 ]]; then
        echo "$(( (bytes + 1023) / 1024 ))KB"
    elif [[ $bytes -lt 1073741824 ]]; then
        echo "$(( (bytes + 1048575) / 1048576 ))MB"
    else
        echo "$(( (bytes + 1073741823) / 1073741824 ))GB"
    fi
}

function cekvmess() {
    fixed_akun
    data=($(grep '^###' /etc/xray/config.json | cut -d ' ' -f 2 | sort | uniq))
    if [[ ! -e /etc/xray/quota ]]; then
        mkdir -p /etc/xray/quota
    fi
    for user in "${data[@]}"; do
        mkdir -p /tmp/quota
        data=$(xray api statsquery --server=127.0.0.1:10085 | grep -C 2 "$user" | sed '/}/d' | sed '/{/d' | grep value | awk '{print $2}' | sed 's/,//g; s/"//g' | sort)
        inb=$(echo "$data" | sed -n 1p)
        outb=$(echo "$data" | sed -n 2p)

        # Check if inb and outb are not empty
        if [[ -z "$inb" || -z "$outb" ]]; then
            echo "Data for user $user is incomplete. Skipping."
            continue
        fi

        quota0=$(( inb + outb ))

        if [ -e /etc/xray/quota/"${user}_usage" ]; then
            quota1=$(cat /etc/xray/quota/"${user}_usage")
            if [[ -n "$quota1" ]]; then
                quota2=$(( quota0 + quota1 ))
                echo "$quota2" > /etc/xray/quota/"${user}_usage"
            else
                echo "$quota0" > /etc/xray/quota/"${user}_usage"
            fi
        else
            echo "$quota0" > /etc/xray/quota/"${user}_usage"
        fi
        xray api stats --server=127.0.0.1:10085 -name "user>>>${user}>>>traffic>>>downlink" -reset > /dev/null 2>&1
    done
}

function vmess() {
    while true; do
        sleep 30
        cekvmess
        data=($(grep '^###' /etc/xray/config.json | cut -d ' ' -f 2 | sort | uniq))
        for user in "${data[@]}"; do
            if [ -e /etc/vmess/"${user}" ]; then
                cekdulu=$(cat /etc/vmess/"${user}")
                if [[ -n "$cekdulu" ]]; then
                    if [ -e /etc/xray/quota/"${user}_usage" ]; then
                        pakai=$(cat /etc/xray/quota/"${user}_usage")
                        if [[ "$pakai" -gt "$cekdulu" ]]; then
                            exp=$(grep -w "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
                            sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
                            systemctl restart xray >> /dev/null 2>&1
                            bol=$(cat /etc/xray/quota/"${user}_usage")
                            total=$(con "$bol")
                            send_log
                            rm -rf /etc/xray/quota/$user
                            rm -rf /etc/xray/quota/${user}_usage
                            rm -rf /etc/xray/quota/"${user}_usage"
                        fi
                    fi
                fi
            fi
        done
    done
}

vmess
