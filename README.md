# WIP!

GNU Geeks

System symlinks
cd to /etc and symlink the expected config.scm
```
sudo ln -s /home/ymajan/count_fig/geeks/config.scm
```

cd to /etc/guix and symlink the expected channels.scm
```
sudo ln -s /home/ymajan/count_fig/geeks/channels.scm
```

User symlinks
home.scm: no default file path, use ~/count_fig/geeks/home.scm
home-channels.scm: channels defined in home.scm


MackOS
~/.zprofile symlink
```
ln -s ~/count_fig/macos/zprofile ~/.zprofile
```

For authinfo org-caldav syntax
TODO fix macos syncing

```
machine cloud.jaynam.me:433 port https login ymajan password app-password
```


