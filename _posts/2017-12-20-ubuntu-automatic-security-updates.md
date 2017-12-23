---
title: "Ubuntu Automatic Security Updates"
tags: Ubuntu Automatic
---

希望 Ubuntu 能自動更新安全性套件，避免手動管理，這個想法可以透過無人值守更新套件 unattended-upgrades 簡單的完成任務。

## 安裝及設定套件
首先安裝套件
```bash
sudo apt install unattended-upgrades
```

接著編輯設定檔

/etc/apt/apt.conf.d/50unattended-upgrades

Allowed-Origins 設定預設只安裝安全性更新，這也是常見的需求。如果你希望一般套件也自動更新，可以取消 ${distro_codename}-updates" 的註解，

如果有要保留的套件不希望被更新的，可以使用 Package-Blacklist 設定。
```
Unattended-Upgrade::Allowed-Origins {
        "${distro_id}:${distro_codename}";
        "${distro_id}:${distro_codename}-security";
        // Extended Security Maintenance; doesn't necessarily exist for
        // every release and this system may not have it installed, but if
        // available, the policy for updates is such that unattended-upgrades
        // should also install from here by default.
        "${distro_id}ESM:${distro_codename}";
        "${distro_id}:${distro_codename}-updates";
//      "${distro_id}:${distro_codename}-proposed";
//      "${distro_id}:${distro_codename}-backports";
};

Unattended-Upgrade::Package-Blacklist {
//      "vim";
//      "libc6";
//      "libc6-dev";
//      "libc6-i686";
};
```

無人值守更新預設是沒有啟動的，需要編緝設定開啟
/etc/apt/apt.conf.d/20auto-upgrades
```
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
```
上述設定除了啟動無人值守之外，還設定每 7 天清除套件，避免被自動下載的套件給塞滿硬碟空間。

## Reference
[Automatic Updates](https://help.ubuntu.com/lts/serverguide/automatic-updates.html)