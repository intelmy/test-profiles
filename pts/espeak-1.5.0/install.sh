#!/bin/sh

tar -zxvf gutenberg-science.tar.gz
tar -xf espeak-ng-1.50.tgz

cd espeak-ng
./autogen.sh
./configure --prefix=$HOME/espeak_
make # build seems to have problems with multiple cores
echo $? > ~/install-exit-status
make install
cd ~
rm -rf espeak-ng

echo "#!/bin/sh
cd espeak_/bin/
LD_LIBRARY_PATH=\$HOME/espeak_/lib/:\$LD_LIBRARY_PATH ./espeak-ng -f ~/gutenberg-science.txt -w espeak-output 2>&1
echo \$? > ~/test-exit-status" > espeak
chmod +x espeak
