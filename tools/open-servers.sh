#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：server.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-24 18:54
#   Description   ：
# ================================================================


connect_to_server_ali(){
    #ssh -i ~/.ssh/id_rsa gongshang@47.93.37.219
    ssh -i ~/.ssh/id_rsa xinyu@47.93.27.152
}

connect_to_server_ionos(){
    #ssh -i ~/.ssh/id_rsa gongshang@47.93.37.219
    # ssh-copy-id xinyu@87.106.191.101
    ssh -i ~/.ssh/id_rsa xinyu@87.106.191.101
}

connect_to_server_aws(){
    sudo ssh -i ~/Documents/configs/servers/AWS-EC2-key.pem ubuntu@16.171.150.115
}


show_help() {
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  aws             Connect to AWS server."
    echo "  ali             Connect to Ali server."
    echo "  ionos           Connect to Ionos server."
    echo "  ====================================================="
    echo "  -h, help               Show this help message."
    echo "  ====================================================="
}

case "$1" in
    -h|help)
        show_help
        ;;
    aws)
        connect_to_server_aws
        ;;
    ali)
        connect_to_server_ali
        ;;
    ionos)
        connect_to_server_ionos
        ;;
    *)
        echo "Error: Invalid option '$1'"
        show_help
        ;;
esac
