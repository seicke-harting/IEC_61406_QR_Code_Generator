<!-- Back to top link -->
<a name="readme-top"></a>

# IEC 61406 QR Code Generator

![GitHub Release](https://img.shields.io/github/release/seicke-harting/IEC_61406_QR_Code_Generator?style=flat-square)
![GitHub top language](https://img.shields.io/github/languages/top/seicke-harting/IEC_61406_QR_Code_Generator?style=flat-square)
![GitHub License](https://img.shields.io/github/license/seicke-harting/IEC_61406_QR_Code_Generator?style=flat-square)

## Table Of Content

- [Table Of Content](#table-of-content)
- [Description](#description)
	- [IEC 61406-1 QR Code Generator](#iec-61406-1-qr-code-generator)
	- [IEC 61406-2 QR Code Generator](#iec-61406-2-qr-code-generator)
- [Installation and Usage](#installation-and-usage)
	- [Runtime Dependencies and their installation](#runtime-dependencies-and-their-installation)
- [License](#license)
- [Acknowledgments](#acknowledgments)
	- [Author of the original project :octocat:](#author-of-the-original-project-octocat)

## Description

Script for generating IEC 61406 compliant QR codes.

### IEC 61406-1 QR Code Generator

For QR codes with respect to [IEC 61406-1 :link:](https://webstore.iec.ch/publication/67673)

<img src="examples/QR_Code_61406_1.png" width="150">

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### IEC 61406-2 QR Code Generator

For QR codes with respect to [IEC CD 61406-2 :link:](https://www.iec.ch/dyn/www/f?p=103:38:434099697781774::::FSP_ORG_ID,FSP_APEX_PAGE,FSP_PROJECT_ID:1452,23,112292)

<img src="examples/QR_Code_61406_2.png" width="150">

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Installation and Usage
```sh
$ git clone https://github.com/seicke-harting/IEC_61406_QR_Code_Generator
$ cd IEC_61406_QR_Code_Generator
```

**IEC 61406-1 QR Code Generator**
```sh
$ chmod +x IEC_61406-1_QR_Code_Generator.sh
$ ./IEC_61406-1_QR_Code_Generator.sh [-options] <uri> <file>
```

**IEC 61406-2 QR Code Generator**
```sh
$ chmod +x IEC_CD_61406-2_QR_Code_Generator.sh
$ ./IEC_CD_61406-2_QR_Code_Generator.sh [-options] <uri> <file>
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Runtime Dependencies and their installation

- [optget](https://www.gnu.org/software/libc/manual/html_node/Getopt.html), for parsing command line options
- [mktemp](https://www.gnu.org/software/autogen/mktemp.html), for creating temporary picture file
- [qrencode](https://fukuchi.org/works/qrencode), for generating the "pure" QR code with white border
- [ImageMagick](https://imagemagick.org), for applying black rim and triangle at the bottom right

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### Linux (*Ubuntu 22*)

```sh
# getopt: already installed with Ubuntu
# mktemp: already installed with Ubuntu
$ sudo apt-get install qrencode
$ sudo apt-get install imagemagick
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### MacOS (*Ventura 13*)

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

#### Windows (*11 and WSL*)

First prepare Windows for running Shell Scripts

1. Go to Settings > Update & Security > For Developers. Activate the *Developer Mode* radio button.
2. Search in Settings for "*Windows Features*", chose "Turn Windows features on or off".
3. Scroll down to "Windows-Subsystem for Linux" and check the corresponding box to install (WSL).
4. BASH will be now available in the Command Prompt and PowerShell
5. Open https://aka.ms/wslstore and install one of the Linux distributions, continuing here with "Debian" as an example
6. If necessary, open https://aka.ms/wsl2kernel, download and install the Linux kernel update package.
7. Maybe you have to active Hyper-V (Command Prompt):

    ```Command Prompt
    $DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
    ```

8. Maybe you have to set the WSL version (Command Prompt):

    ```Command prompt
    $ wsl --set-default-version 1
    ```

9. Maybe you have to setup a Linux username and password (Powershell):

    ```sh
    $ wsl -d Debian -u root
    $ passwd root
    ````

10. Install dependencies (WSL)

    ```sh
    # getopt: already installed together with Ubuntu
    # mktemp: already installed together with Ubuntu
    $ sudo apt-get install qrencode
    $ sudo apt-get install imagemagick
    ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## License

This program is distributed under the terms of the GNU General Public License (GPLv3).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Acknowledgments

### Author of the [original project :octocat:](https://github.com/DIN-DKE/IEC_61406__QR_Code_Generator)
Dr. Michael Rudschuck, DKE  Deutsche Kommission Elektrotechnik Elektronik Informationstechnik
(further information: https://github.com/DIN-DKE)

<p align="right">(<a href="#readme-top">back to top</a>)</p>