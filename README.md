<!-- Back to top link -->
<a name="readme-top"></a>
# IEC 61406 QR Code Generator

![GitHub License](https://img.shields.io/github/license/seicke-harting/IEC_61406_QR_Code_Generator?style=flat-square)
![GitHub top language](https://img.shields.io/github/languages/top/seicke-harting/IEC_61406_QR_Code_Generator?style=flat-square)

## Description

Script for generating IEC 61406 compliant QR codes.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Install & Usage
```sh
$ git clone https://github.com/seicke-harting/IEC_61406_QR_Code_Generator
$ cd IEC_61406_QR_Code_Generator
$ chmod +x IEC_61406_Demonstrator
$ ./IEC_61406_Demonstrator [-options] <uri> <file>
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Runtime Dependencies

- [qrencode](https://fukuchi.org/works/qrencode), for generating the "pure" QR code
- [ImageMagick](https://imagemagick.org), for applying border/rim and triangle at the bottom right with respect to [IEC 61406-1 :link:](https://webstore.iec.ch/publication/67673)

#### Installation of Runtime Dependencies (MacOS)

First installation of package manager *[Homebrew](https://brew.sh/index_de)*:
```sh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
````

Installation of dependencies
```sh
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