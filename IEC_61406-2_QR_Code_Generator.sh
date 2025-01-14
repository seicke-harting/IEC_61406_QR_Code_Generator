#!/bin/bash

# IEC 61406-2 QR Code Generator
# (c) Sebastian Eicke (sebastian.eicke@harting.com)
# (further information https://github.com/seicke/IEC_61406_QR_Code_Generator)

# Helper function for checking environment
checkEnvironment() {

  if [[ $(uname -s | tr '[:upper:]' '[:lower:]') == cygwin* ]]; then
    PLATFORM='Windows'
    showTesting
    exit
  elif [[ $(uname -s | tr '[:upper:]' '[:lower:]') == 'darwin' ]]; then
    PLATFORM='MacOS'
  elif [[ $(uname -s | tr '[:upper:]' '[:lower:]') == 'linux' ]]; then
    PLATFORM='Linux'
  else
    showTesting
    exit
  fi

}

# Helper function for checking availability of dependencies
checkDependencies() {

  DEPENDENCIES_AVAILABLE_FLAG=true
  mktemps -V 2>/dev/null
  if [ $? -ne 0 ]; then
    DEPENDENCIES_AVAILABLE_FLAG=false
    echo "Cannot call mktemp"
  fi
  converts -version 2>/dev/null
  if [ $? -ne 0 ]; then
    DEPENDENCIES_AVAILABLE_FLAG=false
    echo "Cannot call ImageMagick (convert)"
  fi
  qrencodes -V 2>/dev/null
  if [ $? -ne 0 ]; then
    DEPENDENCIES_AVAILABLE_FLAG=false
    echo "Cannot call qrencode"
  fi
  if [ "$DEPENDENCIES_AVAILABLE_FLAG" = false ] ; then
    showDependencies
  fi

}

#START Settings
QR_MODULE_SIZE=10                                           # Module size in pixels
QR_MODULE_SIZE_MM=.35                                       # Module size in mm
QR_MODULE_SIZE_MM_MIN=.25                                   # Minimal module size in mm
QR_BLACK_RIM=$(($QR_MODULE_SIZE * 1))                       # Black rim:     1 Module    (IEC 61406-1 specs: Z = 1)
QR_BORDER=$((($QR_MODULE_SIZE * 4) + $QR_BLACK_RIM))        # Border:        4+1 Modules (IEC 61406-1 specs: X >= 4 + Z = 1)
QR_TRIANGLE=$((($QR_MODULE_SIZE * 6) + (2*$QR_BLACK_RIM)))  # Size triangle: 6+1 Modules (IEC 61406-1 specs: Y = 6 and Z = 1)
QR_TRIANGLE_WHITE=$(($QR_TRIANGLE - (2*$QR_BLACK_RIM)))     # Size white triangle        (IEC 61406-2 specs Y = 6)
QR_Text=$(($QR_MODULE_SIZE * 3))                            # Font size of optional URL text line
QR_DPI=300                                                  # DPI
QR_ERROR_CORRECTION_LEVEL=Q
QR_URLLINE_POSITION=south
#END Settings

#START Constants
SEMVER_MAJOR=1
SEMVER_MINOR=0
SEMVER_PATCH=0
VERSION=$SEMVER_MAJOR.$SEMVER_MINOR.$SEMVER_PATCH
VERBOSE_FLAG=false
CORRECTION_FLAG=false
NEGATIVE_FLAG=false
URLLINE_FLAG=false
#END Constans

#START Defaults for options and parameter
SCRIPT_FILE=${0##*/}
IDENTIFICATION_LINK_STRING="https://github.com/seicke/IEC_61406_QR_Code_Generator?.PARAM1=VALUE1&.PARAM2=VALUE2"
QR_CODE_FILE="QR_Code_61406_2.png"
QR_CODE_FORMAT="${QR_CODE_FILE##*.}"
QR_CODE_FORMAT=$(echo "$QR_CODE_FORMAT" | tr '[:lower:]' '[:upper:]')
#END defaults for options

# Helper function for VERBOSE_FLAG mode
PrintOut () {

  if [ "$VERBOSE_FLAG" = true ] ; then
    echo "$1";
  fi

}

# Helper function for showing copyright info
showCopyright() {

  echo "IEC 61406-2 QR code generator"
  echo "Copyright: (c) Sebastian Eicke 2023"
  echo "Licence: GPLv3"

}

# Helper function for showing version info
showVersion() {

  echo "$SCRIPT_FILE $VERSION"

}

# Helper function for showing usage infor
showUsage() {

  echo
  echo "Usage: ./$SCRIPT_FILE [-options] <identification link> <file>"
  showDependencies
  echo
  echo "   -c,              --correction            Correct <identification link> with respect to IEC 61406-1 specs"
  echo "   -h,              --help                  Display help"
  echo "   -l {LMQH},       --level {LMQH}          Error correction level of QR code (from L (lowest) to H (highest), default=Q)"
  echo "   -n,              --negative              Creates negative QR Code (white modules, black quiet zone)"
  echo "                    --version               Display version"
  echo "   -u {south,east}, --urlline {south,east}  Position of <identification link> string"
  echo "   -v,              --verbose               Run script in verbose mode."
  echo "                                            Prints out each step of execution."
  echo
  echo "Example:"
  echo
  echo "   $ ./$SCRIPT_FILE "
  echo "        \"https://github.com/seicke/IEC_61406_QR_Code_Generator\""
  echo "        \"QR_Code_61406_2.png\""
  echo
  echo "   Encodes https://github.com/seicke/IEC_61406_QR_Code_Generator in a IEC 61406-2"
  echo "   compliant QR Code, saved as QR_Code_61406_2.png"
  echo

}

# Helper function for showing dependencies
showDependencies() {

  echo "(see Readme for installing dependencies)"

}

# Helper function for showing help
showHelp() {

  showCopyright
  echo
  showVersion
  echo
  showUsage

}

# Helper function for showing testing info
showTesting() {

  showCopyright
  echo
  showVersion
  echo
  echo "So far tested with MacOS Ventura 13, Ubuntu 22 and Windows 11 (WSL)."

}

checkEnvironment

#START parsing options
if [[ $PLATFORM == 'Linux' ]]; then
  PARSED_OPTIONS=$(getopt --name "${0##*/}" --options chl:nu:v --longoptions correction,help,level:,negative,urlline:,verbose,version -- "$@")
elif [[ $PLATFORM == 'MacOS' ]]; then
  PARSED_OPTIONS=$(/opt/homebrew/opt/gnu-getopt/bin/getopt --name "${0##*/}" --options chl:nu:v --longoptions correction,help,level:,negative,urlline:,verbose,version -- "$@")
fi

VALID_ARGUMENTS=$?
if [[ $? -ne 0 ]]; then
    showHelp
    exit 1;
fi

eval set -- "$PARSED_OPTIONS"

while [ : ]; do
  case "$1" in
    -c | --correction)
      CORRECTION_FLAG=true
      shift
      ;;
    -h | --help)
      showHelp
      exit
      ;;
    -l | --level)
      if [[ "$2" != "L" ]] && [[ "$2" != "M" ]] &&[[ "$2" != "Q" ]] &&[[ "$2" != "H" ]]; then
        echo
        echo "   (!) WARNING: Unknown error correction level \"$2\""
        echo "   (!) WARNING: Default error correction level \"$QR_ERROR_CORRECTION_LEVEL\" is used"
        echo
      else
        QR_ERROR_CORRECTION_LEVEL=$2
      fi
      if [[ "$2" == "L" ]] && [[ "$2" == "M" ]]; then
        PrintOut
        PrintOut "   (i) INFO: IEC 61406-1 requirement 2D-6: Error correction; error correction level \"Q\" recommended"
        PrintOut
      fi
      shift 2
      ;;
    -n | --negative)
      NEGATIVE_FLAG=true
      shift
      ;;
    -u | --urlline)
      URLLINE_FLAG=true
      if [[ "$2" != "south" ]] && [[ "$2" != "east" ]]; then
        echo
        echo "   (!) WARNING: Unknown URL text position \"$2\""
        echo "   (!) WARNING: Default URL text position \"$QR_URLLINE_POSITION\" is used"
        echo
      else
        QR_URLLINE_POSITION=$2
      fi
      shift 2
      ;;
    -v | --verbose)
      VERBOSE_FLAG=true
      shift
      ;;
    --version)
      showVersion
      exit
      shift
      ;;
    --)
      shift
      if [ -z "$1" ]; then
        echo
        echo "   (!) WARNING: <identification link> is empty" >&2
        echo "   (!) WARNING: Default <identification link> ($IDENTIFICATION_LINK_STRING) is used"
        echo
      else
        IDENTIFICATION_LINK_STRING=$1
      fi

      if [ -z "$2" ]; then
        echo
        echo "   (!) WARNING: <file> is empty" >&2
        echo "   (!) WARNING: Default <file> ($QR_CODE_FILE) is used"
        echo
      else
        QR_CODE_FILE=$2
        QR_CODE_FORMAT="${QR_CODE_FILE##*.}"
        QR_CODE_FORMAT=$(echo "$QR_CODE_FORMAT" | tr '[:lower:]' '[:upper:]')
      fi

      if [ -z "$1" ] || [ -z "$2" ]; then
        showUsage
      fi

      if ! [ -z "$1" ] && ! [ -z "$2" ]; then
        shift 2
      elif ! [ -z "$1" ]; then
        shift
      elif ! [ -z "$2" ]; then
        shift
      fi

      break
      ;;
    esac
done
#END parsing options

#Check QR code format (and correct it)
if [[ $QR_CODE_FORMAT != "PNG" ]] && [[ $QR_CODE_FORMAT != "EPS" ]]; then #&& [[ $QR_CODE_FORMAT != "SVG" ]]; then
  QR_CODE_FILE=$QR_CODE_FILE".png"
  QR_CODE_FORMAT="${QR_CODE_FILE##*.}"
  QR_CODE_FORMAT=$(echo "$QR_CODE_FORMAT" | tr '[:lower:]' '[:upper:]')
fi

PrintOut
PrintOut "--------------------------------------------------"
PrintOut "Parsed options:            $PARSED_OPTIONS"
PrintOut "Identification link (IL):  $IDENTIFICATION_LINK_STRING"
PrintOut "QR code file:              $QR_CODE_FILE"
PrintOut
PrintOut "Verbose mode:              $VERBOSE_FLAG"
PrintOut "IL auto correction:        $CORRECTION_FLAG"
PrintOut "Negative QR code:          $NEGATIVE_FLAG"
PrintOut "URL text line:             $URLLINE_FLAG"
PrintOut
PrintOut "QR error correction level: $QR_ERROR_CORRECTION_LEVEL"
if [ "$URLLINE_FLAG" = true ] ; then
  PrintOut "URL text line position:    $QR_URLLINE_POSITION"
fi
PrintOut "--------------------------------------------------"
PrintOut

#START check IEC 61406-2 compliance of identification link

# Parse identification link
IDENTIFICATION_LINK_PROTOCOL_STRING=$(echo "$IDENTIFICATION_LINK_STRING" | grep :// | sed -e's,^\(.*://\).*,\1,g')
IDENTIFICATION_LINK_HOST_STRING=$(echo "${IDENTIFICATION_LINK_STRING/${IDENTIFICATION_LINK_PROTOCOL_STRING}/}" | cut -d/ -f1)
IDENTIFICATION_LINK_PATHQUERY_STRING=$(echo "${IDENTIFICATION_LINK_STRING/${IDENTIFICATION_LINK_PROTOCOL_STRING}/}" | cut -d/ -f2-)
IDENTIFICATION_LINK_QUERY_STRING=$(echo "$IDENTIFICATION_LINK_PATHQUERY_STRING" | grep ? | cut -d? -f2-)
if [ -n "$IDENTIFICATION_LINK_QUERY_STRING" ]; then
    IDENTIFICATION_LINK_PATH_STRING=$(echo "$IDENTIFICATION_LINK_PATHQUERY_STRING" | sed "s?${IDENTIFICATION_LINK_QUERY_STRING}??g" | sed 's/^?//')
else
    IDENTIFICATION_LINK_PATH_STRING="$IDENTIFICATION_LINK_PATHQUERY_STRING"
fi

# Parse query parameters of identification link
IFS='&' read -ra IDENTIFICATION_LINK_PARAMS <<< "$IDENTIFICATION_LINK_QUERY_STRING"
for IDENTIFICATION_LINK_PARAM in "${IDENTIFICATION_LINK_PARAMS[@]}"; do
    IFS='=' read -r key value <<< "$IDENTIFICATION_LINK_PARAM"
    value=$(echo -e "${value//%/\\x}")

    # 5.3 SIDIs as parameter names
    if [[ ! $key =~ ^\. ]]; then
      echo "'$key' parameter name does not start with a '.'!"
    fi

done
#END check IEC 61406-2 compliance of identification link

if [ "$CORRECTION_FLAG" = true ] ; then
  PrintOut
  PrintOut "   (i) INFO: Corrected IL string: $IDENTIFICATION_LINK_STRING";
  PrintOut
fi

################################################################################

# Generation of 'pure' QR code
# according to ISO/IEC 18004 (IEC 61406-1 requirement 2D-2: 2D symbol content)
# contains only identificiation link (IEC 61406-1 requirement 2D-3: Symbology)
# including white border/margin (IEC 61406-1 requirement 2D-5: Quiet zone)
# including black rim and triangle (IEC 61406-2 altered identification link frame for product type-, model-, lot- or batch level)
# with recommended error correction lebel "Q" (IEC 61406-1 requirement 2D-6: Error correction)
qrencode --output="$QR_CODE_FILE" --size $QR_MODULE_SIZE --margin=$(($QR_BORDER/$QR_MODULE_SIZE)) --dpi=$QR_DPI $IDENTIFICATION_LINK_STRING --level=$QR_ERROR_CORRECTION_LEVEL --type=$QR_CODE_FORMAT    # works with PNG/EPS/SVG
echo "QR code created";

# Identify size of the generated QR code
if [[ $PLATFORM == 'Linux' ]]; then
  size=$(identify -format '%[fx:w]' "$QR_CODE_FILE")
elif [[ $PLATFORM == 'MacOS' ]]; then
  size=$(magick identify -format '%[fx:w]' "$QR_CODE_FILE") # works with PNG/EPS, not with SVG
fi

# (2D-4: Module size)
size_mm=$(echo "scale=2; $size / $QR_MODULE_SIZE * $QR_MODULE_SIZE_MM" | bc)
size_mm_min=$(echo "scale=2; $size / $QR_MODULE_SIZE * $QR_MODULE_SIZE_MM_MIN" | bc)
PrintOut "QR code size $size x $size pixels ($size_mm mm; min. $size_mm_min mm!)"

# (2D-5: Quiet zone)
size_mm=$(echo "scale=2; (($size / $QR_MODULE_SIZE) + 1) * $QR_MODULE_SIZE_MM" | bc)
size_mm_min=$(echo "scale=2; (($size / $QR_MODULE_SIZE) + 1) * $QR_MODULE_SIZE_MM_MIN" | bc)
PrintOut "QR code size (incl. 'quiet zone') ($size_mm mm; min. $size_mm_min mm!)"

# Apply border, rim and triangle with respect to IEC 61406-1 specs
convert "$QR_CODE_FILE" -fill black -stroke black -bordercolor black \
 -shave $QR_BLACK_RIM -border $QR_BLACK_RIM \
 -draw "path 'M $size,$size L $(($size-$QR_TRIANGLE)),$size L $size,$(($size-$QR_TRIANGLE)) Z ' " \
 "$QR_CODE_FILE"

convert $QR_CODE_FILE -fill white -stroke white -bordercolor white \
 -strokewidth $QR_BLACK_RIM \
 -draw "path 'M $size,$size L $(($size-$QR_TRIANGLE_WHITE)),$size L $size,$(($size-$QR_TRIANGLE_WHITE)) Z ' " \
 $QR_CODE_FILE
PrintOut "Frame applied to QR code";

if [ "$URLLINE_FLAG" = true ] ; then
  if [ "$QR_URLLINE_POSITION" = south ] ; then
    convert "$QR_CODE_FILE" -gravity south -splice 0x$QR_BLACK_RIM "$QR_CODE_FILE"
    convert "$QR_CODE_FILE" -font arial -gravity center -pointsize "$QR_Text" label:"$IDENTIFICATION_LINK_STRING" -append "$QR_CODE_FILE"
  elif [ "$QR_URLLINE_POSITION" = east ] ; then
    convert "$QR_CODE_FILE" -gravity east -splice "$QR_BLACK_RIM"x0 "$QR_CODE_FILE"
    convert "$QR_CODE_FILE" -font arial -gravity center -pointsize "$QR_Text" label:"$IDENTIFICATION_LINK_STRING" +append "$QR_CODE_FILE"
  fi
  PrintOut "Add URL text line to QR code";
fi

if [ "$NEGATIVE_FLAG" = true ] ; then
  convert "$QR_CODE_FILE" -channel RGB -negate "$QR_CODE_FILE"
  PrintOut "Converted to negative QR code";
  PrintOut
  PrintOut "   (i) INFO: IEC 61406-1 requirement 2D-11: Positive image; negative QR code shall be avoided"
  PrintOut
fi

PrintOut "$(realpath .)/$QR_CODE_FILE"