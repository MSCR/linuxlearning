# /bin/bash
#My first script

# Variables
script_name=$0
file_location=$1
kernel_version="linux-$2"
file_type=$3
kernel_link="https://www.kernel.org/pub/linux/kernel/v3.x"

base_folder=/home/mscortes/linuxlearning/training/users/MSCR/01.core/shelllearning
kernel_folder=$base_folder/kernelimages
prework_folder=$base_folder/preworkspace
postwork_folder=$base_folder/postworkspace

link="$kernel_link/$kernel_version.tar.$file_type"

 
# Processing Stage
if [[ $file_location = "internet" ]]; then
   echo "Download Source Code from www.kernel.org"
   wget -P $kernel_folder -nc $link
elif [[ $file_location = "local" ]]; then
   echo "Copy Source Code from local directory"
else
   echo "Parameter invalid"
   exit
fi

# Pre-Processing Stage
if [[ !(-d $prework_folder) ]]; then
   mkdir $prework_folder
fi
if [[ !(-d $prework_folder/$kernel_version) ]]; then
   tar -xpf $kernel_folder/$kernel_version.tar.$file_type -C $prework_folder
fi

echo -e "File Names\n" > stats.pre
dummy=`find $prework_folder/$kernel_version -name "README.*"|wc -l`
echo "# of READMEs: $dummy" >> stats.pre
dummy=`find $prework_folder/$kernel_version -name "kconfig*"|wc -l`
echo "# of kconfig: $dummy" >> stats.pre
dummy=`find $prework_folder/$kernel_version -name "kbuild*"|wc -l`
echo "# of kbuild: $dummy" >> stats.pre
dummy=`find $prework_folder/$kernel_version -name "Makefile*"|wc -l`
echo "# of Makefiles: $dummy" >> stats.pre
dummy=`find $prework_folder/$kernel_version -name "*.c"|wc -l`
echo "# of .c files: $dummy" >> stats.pre
dummy=`find $prework_folder/$kernel_version -name "*.h"|wc -l`
echo "# of .h files: $dummy" >> stats.pre
dummy=`find $prework_folder/$kernel_version -name "*.pl"|wc -l`
echo "# of .pl files: $dummy" >> stats.pre
dummy=`find $prework_folder/$kernel_version -name "*.[!chp][!l]"|wc -l`
echo -e "# of other files: $dummy\n" >> stats.pre

echo -e "File Names\n" >>  stats.pre
dummy=`grep -w -r Linus $prework_folder/$kernel_version|wc -l`
echo "# of occurrences of Linus: $dummy" >> stats.pre
dummy=`find $prework_folder/$kernel_version/arch/ -maxdepth 1 -type d|wc -l`
echo "# of architectures/directories found under arch/: $dummy" >> stats.pre
dummy=`grep -w -r kernel_start $prework_folder/$kernel_version|wc -l`
echo "# of occurrences for kernel_start: $dummy" >> stats.pre
dummy=`grep -w -r __init $prework_folder/$kernel_version|wc -l`
echo "# of occurrences for __init: $dummy" >> stats.pre
dummy=`find $prework_folder/$kernel_version -name gpio_* -type f|wc -l`
echo "# of occurrences of files in its filename containing the word gpio_: $dummy" >> stats.pre
dummy=`grep -r "#include <linux/module.h>" $prework_folder/$kernel_version|wc -l`
echo "# of occurrences for #include <linux/module.h>: $dummy" >> stats.pre

touch intel.contributors
#dummy=`grep -r *@intel.com $prework_folder/$kernel_version|wc -l`
#echo "# of occurrences for #include <linux/module.h>: $dummy" >> stats.pre

#! Post-Processing Stage
#mkdir $base_folder/postworkspace
#touch $postwork_folder/stats.post



