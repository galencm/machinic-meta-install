Install everything:

```
git clone https://github.com/galencm/machinic-meta-install
cd machinic-meta-install
./install.sh
```

Install packages and programs in development (editable) mode:

```
./install.sh --develop
```

By default machines are started after they are installed. To not start:

```
./install.sh --no-machine-start
``` 