#/usr/bin/bash

here=${0%/*}
bin="${here}/target/aarch64-linux-android/release/fas-rs"

set -e

cargo b -r --target aarch64-linux-android

if [ ! -f $bin ]; then
    echo "Fail to build release"
    exit 1
fi

strip $bin
sstrip $bin

echo -e "Build successed"
cp -f $(realpath $bin) "${here}/build_module/"

echo "翻译已完成并写入目标文件"

cd "${here}/build_module/"
zip -9 -rq ../fas-rs.zip .

echo -n "Packaging is complete: $(realpath ${here}/fas-rs.zip)"