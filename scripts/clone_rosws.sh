#!/bin/bash

# Clone cFE, OSAL and HK
cfe_pkg=cFE-6.5.0a-OSS-release
osal_pkg=osal-4.2.1a-release
hk_pkg=HK-Version241

# Clone, unzip and delete tar.gz
wget -P . https://master.dl.sourceforge.net/project/coreflightexec/${cfe_pkg}.tar.gz
tar -zxf  ${cfe_pkg}.tar.gz -C .
rm ${cfe_pkg}.tar.gz

wget -P . https://master.dl.sourceforge.net/project/osal/${osal_pkg}.tar.gz
tar -zxf ${osal_pkg}.tar.gz -C .
rm ${osal_pkg}.tar.gz

wget -P . https://master.dl.sourceforge.net/project/cfs-hk/${hk_pkg}.tar.gz
tar -zxf ${hk_pkg}.tar.gz -C .
rm ${hk_pkg}.tar.gz

# Move OSAL into cFE
cp -pr ${osal_pkg}/* ${cfe_pkg}/osal/


#pushd src
git clone -b master git@github.com:jaxa/roscfe.git roscfe
#popd
