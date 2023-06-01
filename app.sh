#!/bin/bash

if [ -z "$1" ]
  then
    echo "No command supplied"
    exit 1
fi


########### help command information ##############
if [ "$1" == "--help" ] || [ "$1" == "-h" ]
then
  echo -e "Manage flutter mobile development\n"
  echo -e "Usage: app [command|option] [flavor]\n"
  echo -e "Flavor\t\t\t\tflavor name by your enviroment example: dev, sit, uat, prod, stage\n"
  echo -e "Command"
  echo -e "run\t\t\t\trun app as debug"
  echo -e "build [buildType]\t\tbuild app specify build type\n\t\t\t\tsupport build type include apk, appbundle, ipa  example: app.sh build apk dev\n"
  echo -e "Option"
  echo -e "--env or -e\t\t\tprint enviroment define by giving flavor\n\t\t\t\texample: app.sh -e dev print dev enviroment define in config/<flavoe>.env\n"
  exit 0
fi
####################################################


############# Print enviroment define #################
if [ "$1" == "--env" ] || [ "$1" == "-e" ] 
then

if [ -z "$2" ]
  then
    echo "No specify flavor"
    exit 1
fi

flavor=$2

# load value from env file
if [ -f "config/$flavor.env" ]
then
    . config/$flavor.env
else
    echo "File config/$flavor.env not found"
    exit 1
fi

# combind dart define
dart_define=""
for var in $(compgen -v | grep ^FLUTTER_); do
    dart_define+=" --dart-define=${var}=${!var}"
done

echo "Your enviroment define is : "
echo ""
echo $dart_define
echo ""
exit 0

fi

####################################################


########### flutter run and build script ############
command="$1"

if [ "$command" == "run" ]
then
    flavor="$2"
elif [ "$command" == "build" ]
then

  if [ -z "$2" ]
  then
    echo "No bundle type apk, appbundle, ipa supplied"
    exit 1
   fi

  if [ -z "$3" ]
  then
    echo "No flavor supplied"
    exit 1
   fi

    platform="$2"
    flavor="$3"
else
    echo "Invalid command"
    exit 1
fi

# load value from env file
if [ -f "config/$flavor.env" ]
then
    . config/$flavor.env
else
    echo "File config/$flavor.env not found"
    exit 1
fi

# combind dart define
dart_define=""
for var in $(compgen -v | grep ^FLUTTER_); do
    dart_define+=" --dart-define=${var}=${!var}"
done


if [ "$command" == "run" ]
then
    flutter run --flavor $flavor $dart_define -t lib/main_$flavor.dart
elif [ "$command" == "build" ]
then
    flutter build  $platform --obfuscate --split-debug-info=./build_map --release --flavor $flavor $dart_define -t lib/main_$flavor.dart
else
    echo "Invalid command"
    exit 1
fi
####################################################