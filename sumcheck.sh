#!/bin/bash
##check MD5/Sha1/SHA256 of file and compare to developer supplied checksum to see if they are equal to original
which='/usr/bin/which'

md5sum=$(which md5sum)
##sha1sum='/usr/bin/sha1sum'
sha1sum=$(which sha1sum)
##sha256sum='/usr/bin/sha256sum'
sha256sum=$(which sha256sum)
cut='/usr/bin/cut'

##clear previous files generated from program if they exist

rm -f tempfile1
rm -f tempfile2
rm -f tempfile3
echo "Please paste the sum you would like to check below. To skip question, hit enter."
echo "Paste the md5sum for the file provided by the source here [enter:]"
read filenamemd5
printf "\n"
echo "Paste the sha1sum for the file provided by the source here [enter:]"
read filenamesha1
printf "\n"
echo "Paste the sha256sum for the file provided by the source here [enter:]"
read filenamesha256
printf "\n"
echo "Type absolute path to downloaded file to get MD5, SHA1, and SHA256 sums for file[press enter:]"

read filename

printf "\n"
echo "Calculating..."


#MD5 output first
$md5sum $filename|$cut -d" " -f1 >> tempfile1
result="$(cat tempfile1)"
clear
echo "Here are the results of the signature check for" $filename
printf "\n"
echo The MD5sum input value is  $filenamemd5
echo The calculated MD5sum value is $result


#Test MD5 sums
if (test "$filenamemd5" == "$result");then
    echo "The MD5 sums match"
else
    echo "The MD5 sums do not match"
fi
printf "\n"

#SHA1 output next
$sha1sum $filename|cut -d" " -f1 >>tempfile2
result2="$(cat tempfile2)"
echo The SHA1sum input value is $filenamesha1
echo The calculated SHA1sum value is $result2


#Test Sha1 sums
if (test "$filenamesha1" == "$result2");then
    echo "The SHA1 sums match"
else
    echo "The SHA1 sums do not match"
fi
printf "\n"

#SHA256 sums last
$sha256sum $filename|cut -d" " -f1 >>tempfile3
result3="$(cat tempfile3)"
echo The SHA256 input value is $filenamesha256
echo The calculated SHA256 value is $result3



#Test SHA256 sums
if (test "$filenamesha256" == "$result3");then
    echo "The SHA256 sums match"
else
    echo "The SHA256 sums do not match"
fi


rm -f tempfile1
rm -f tempfile2
rm -f tempfile3

exit 0





