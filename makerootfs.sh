rm -rf /rootfs
mkdir /rootfs #新建根
cd /rootfs
mkdir bin etc dev dev/pts lib proc sys tmp #根据根的格式创建目录
touch etc/resolv.conf # DNS服务器地址
cp /etc/nsswitch.conf etc/nsswitch.conf #名字解析配置
echo root:x:0:0:root:/:/bin/sh > etc/passwd # 新建用户
echo root:x:0: > etc/group #新建用户组
ln -s lib lib64 # 创建软连接
ln -s bin sbin 
cp /bin/busybox bin # 复制bin文件，不然没有命令用
cp $(which git) bin/
$(which busybox) --install -s bin #同上两步操作，用which是因为需要绝对路径
bash -c "cp /lib/x86_64-linux-gnu/lib{c,z,pcre,m,dl,crypt,util,rt,nsl,nss_*,pthread,resolv}.so.* lib" # 这一步很重要，如果使用了Go调用外部动态库这里需要复制进去，
bash -c "cp /lib/x86_64-linux-gnu/ld* lib" #同上
bash -c "mkdir -p usr/lib/git-core/" #同上
bash -c "cp -rf /usr/lib/git-core/* usr/lib/git-core/" #同上

cp /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 lib #同上
tar cf /rootfs.tar . #根目录打包
for X in console null ptmx random stdin stdout stderr tty urandom zero ; do tar uf /rootfs.tar -C/ ./dev/$X ; done 
mv /rootfs.tar /root/busyboxgit/rootfs.tar
