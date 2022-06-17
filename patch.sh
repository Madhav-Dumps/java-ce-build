#!/bin/bash
source "${CONFIG}"

volte(){
    cd /tmp/rom/frameworks/opt/net/ims/
    git fetch https://gerrit.pixelexperience.org/frameworks_opt_net_ims refs/changes/17/15317/1 && git cherry-pick FETCH_HEAD ; git commit --allow-empty -m "p1"
    git fetch https://gerrit.pixelexperience.org/frameworks_opt_net_ims refs/changes/18/15318/1 && git cherry-pick FETCH_HEAD ; git commit --allow-empty -m "p2"
    cd -
    cd /tmp/rom/frameworks/opt/telephony/
    git fetch https://gerrit.pixelexperience.org/frameworks_opt_telephony refs/changes/76/15476/1 && git cherry-pick FETCH_HEAD ; git commit --allow-empty -m "p3"
    cd -
}
if [[ "${ROM_NAME}" == "evolution" ]]; then volte ; fi 

if [[ "${ROM_NAME}" == "ricedroid" ]]; then cd /tmp/rom/device/xiaomi/mt6768-common && sed -i s/pm.dexopt.bg-dexopt=speed-profile/pm.dexopt.bg-dexopt=everything/g system.prop && sed -i s/dalvik.vm.dex2oat-cpu-set=0,1,2,3,4,5/dalvik.vm.dex2oat-cpu-set=0,1,2,3/g system.prop && sed -i s/dalvik.vm.dex2oat-threads=6/dalvik.vm.dex2oat-threads=4/g system.prop && cd - ; fi
cd /tmp/rom/system/sepolicy; curl -s https://github.com/crdroidandroid/android_system_sepolicy/commit/9931973409baf7c69b492df8303d7d0278b2f5d2.patch | git am; cd -
#sed -i s/'SELINUX_IGNORE_NEVERALLOWS := true'/'SELINUX_IGNORE_NEVERALLOWS := false'/g /tmp/rom/device/xiaomi/mt6768-common/BoardConfigCommon.mk
