# machinic install

_Install in light or heavy flavors_

clone and then choose light or heavy:

```
git clone https://github.com/galencm/machinic-meta-install
cd machinic-meta-install
```

**light (recommended)**

* oriented specifically towards digitization and sequencing of images
* created out of lessons learned from heavy
* single db (redis) and optional message broker (mosquitto)
* instances are isolated by using using db host:ip (trivial to run redis servers on multiple ports)
* intended to be usable via guis
  * each gui fulfills a distinct niche and interact using the db
  * session state is stored in xml
  * modifications and updates go through the db
  * dsls such as keyling allow extension of gui functionality by scripting
* commandline tools, dsls underneath the guis and db keys allow other approaches
* generate and upload code for simple devices onto things using gsl, homie and platformio
* automatically connect to, configure homie devices and specify message routing

install light:

_by default install-light runs `./env/environment.sh` which checks for and installs any missing packages. **This may install a lot of things**, look at `<include>` elements in `environment.xml` . To disable this behavior add `--no-env` flag._

```
./install-light.sh

```

install light in development (editable) mode:

```
./install-light.sh --develop
```

install light system dependecies:

```
cd env/
./environment.sh
```

**heavy (see warnings in bold)**

* a generic approach involving xml models, code generation, deployment infrastructure, domain specific languages, commandline tools, ...
* a variety of code is generated from machine files using gsl
* a core machine implements database (redis), message broker (mosquitto), wifi to configure devices (create_ap and homie)
* a reference machine implements image capture (integrated into light mode)
* services are specified from generated files and run using zerorpc
* nomad and consul allow flexibility in modifying machines and service discovery
* a variety of commandline tooling using `ma-cli` and `ma` code generation
* guis and other programs can access db
* **zerorpc has no default security configuration**
* **redis and mosquitto have no default security configuration**
* **no granular starting and stopping of routes pipes yet implemented**

install heavy:

```
./install-heavy.sh

```
By default machines are started after they are installed. To not start:

```
./install-heavy.sh --no-machine-start
``` 

## Contributing

This project uses the C4 process 

[https://rfc.zeromq.org/spec:42/C4/](https://rfc.zeromq.org/spec:42/C4/)

## License

Mozilla Public License, v. 2.0

[http://mozilla.org/MPL/2.0/](http://mozilla.org/MPL/2.0/)
