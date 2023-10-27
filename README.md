<!-- Back to top link -->
<a name="readme-top"></a>
# IEC 61406 QR Code Generator

![GitHub License](https://img.shields.io/github/license/seicke-harting/IEC_61406_QR_Code_Generator?style=flat-square)
![GitHub top language](https://img.shields.io/github/languages/top/seicke-harting/IEC_61406_QR_Code_Generator?style=flat-square)

## Description

Script for generating IEC 61406 compliant QR codes.

### IEC 61406-1 QR Code Generator

For QR codes with respect to [IEC 61406-1 :link:](https://webstore.iec.ch/publication/67673)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Install & Usage
```sh
$ git clone https://github.com/seicke-harting/IEC_61406_QR_Code_Generator
$ cd IEC_61406-1_QR_Code_Generator
$ chmod +x IEC_61406-1_QR_Code_Generator.sh
$ ./IEC_61406-1_QR_Code_Generator [-options] <uri> <file>
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Runtime Dependencies

- [optget](https://www.gnu.org/software/libc/manual/html_node/Getopt.html), for parsing command line options
- [mktemp](https://www.gnu.org/software/autogen/mktemp.html), for creating temporary picture file
- [qrencode](https://fukuchi.org/works/qrencode), for generating the "pure" QR code with white border
- [ImageMagick](https://imagemagick.org), for applying black rim and triangle at the bottom right

#### Installation of Runtime Dependencies

##### Linux (*Ubuntu 22*)

```sh
# getopt: already installed with Ubuntu
# mktemp: already installed with Ubuntu
$ sudo apt-get install qrencode
$ sudo apt-get install imagemagick imagemagick-doc
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

##### MacOS (*Ventura 13*)

First installation of package manager *[Homebrew](https://brew.sh/index_de)*:
```sh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
````

```sh
$ brew install gnu-getopt
# mktemp: already installed with MacOS
$ brew install qrencode
$ brew install imagemagick
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## LICENSE

This program is distributed under the terms of the GNU General Public License (GPLv3).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Acknowledgments

### Author of the [original project :octocat:](https://github.com/DIN-DKE/IEC_61406__QR_Code_Generator)
Dr. Michael Rudschuck, DKE  Deutsche Kommission Elektrotechnik Elektronik Informationstechnik
(further information: https://github.com/DIN-DKE)

<p align="right">(<a href="#readme-top">back to top</a>)</p>