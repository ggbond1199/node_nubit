#!/bin/bash

function password_protect() {
    local USER_PASSWORD="nubit131"  # 设置密码，实际使用时应更安全地处理
    read -sp "请输入密码以继续: " input_password  # 提示用户输入密码
    echo
    if [ "$input_password" != "$USER_PASSWORD" ]; then
        echo "密码错误，退出脚本。"
        exit 1
    fi
}

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

# 脚本保存路径
SCRIPT_PATH="$HOME/Quili.sh"


# 节点安装功能
function install_node() {
screen -dmS nubit

# 发送命令到 nubit 会话中
screen -S nubit -X stuff 'curl -sL1 https://nubit.sh | bash\n'
	
}



# 查看常规版本节点日志
function check_service_status() {
    screen -r nubit
   
}

# 独立启动
function check_addr() {
	cd nubit-node
	export PATH=$PATH:$(pwd)/bin
NETWORK=nubit-alphatestnet-1
NODE_TYPE=light
PEERS=/ip4/34.222.12.122/tcp/2121/p2p/12D3KooWJJWdaCB8GRMHuLiy1Y8FWTRCxDd5GVt6A2mFn8pryuf3
VALIDATOR_IP=validator.nubit-alphatestnet-1.com
GENESIS_HASH=AD1DB79213CA0EA005F82FACC395E34BE3CFCC086CD5C25A89FC64F871B3ABAE
AUTH_TYPE=admin
store=$HOME/.nubit-${NODE_TYPE}-${NETWORK}/
NUBIT_CUSTOM="${NETWORK}:${GENESIS_HASH}:${PEERS}"
	
	cd ..
	store=$HOME/.nubit-light-nubit-alphatestnet-1/
	nubit state account-address --node.store $store

}

function check_seed() {
	cd nubit-node

    echo "=====================助记词为：========================="

	sudo cat mnemonic.txt
	cd ..
   
}


# 主菜单
function main_menu() {
    clear
    echo "Made by Bond Node Community"
    echo "=====================安装及常规修改功能========================="
    echo "Join Bond Node Community, go go go"
    echo "节点社区 Discord:https://discord.gg/ecJq3NBE6M"
    echo "=====================Nubit 轻节点 ========================="
    echo "请选择要执行的操作:"
    echo "1. 安装常规节点(正常出现日志后ctrl a d退出)"
    echo "2. 查看节点日志"
    echo "=====================以下备份========================="
    echo "3. 查看地址"
    echo "4. 查看助记词"

    read -p "请输入选项（1-5）: " OPTION

    case $OPTION in
    1) 
	password_protect
	install_node ;;
    2) check_service_status ;;  
    3) check_addr ;; 
    4) check_seed ;;
    *) echo "无效选项。" ;;
    esac
}

# 显示主菜单
main_menu
