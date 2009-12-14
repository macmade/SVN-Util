#!/bin/bash

################################################################################
# Copyright (c) 2009, Jean-David Gadina <macmade@eosgarden.com>                #
# All rights reserved.                                                         #
#                                                                              #
# Redistribution and use in source and binary forms, with or without           #
# modification, are permitted provided that the following conditions are met:  #
#                                                                              #
#  -   Redistributions of source code must retain the above copyright notice,  #
#      this list of conditions and the following disclaimer.                   #
#  -   Redistributions in binary form must reproduce the above copyright       #
#      notice, this list of conditions and the following disclaimer in the     #
#      documentation and/or other materials provided with the distribution.    #
#  -   Neither the name of 'Jean-David Gadina' nor the names of its            #
#      contributors may be used to endorse or promote products derived from    #
#      this software without specific prior written permission.                #
#                                                                              #
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"  #
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE    #
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE   #
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE    #
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR          #
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF         #
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS     #
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN      #
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)      #
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE   #
# POSSIBILITY OF SUCH DAMAGE.                                                  #
################################################################################

# $Id$

SvnUtil_Usage()
{
    echo ''
    echo 'Usage: '$1' command working-copy'
    echo ''
    echo 'Commands:'
    echo '    '
    echo '    -k / --auto-keywords'
    echo '    Sets the svn:keywords property to all the regular files of the working-copy.'
    echo '    '
    echo '    -d / --delete'
    echo '    Deletes the .svn directories, making the working-copy an unversioned directory.'
    echo '    '
    echo '    -c / --clean'
    echo '    Cleans-up the working-copy by removing Mac OS X .DS_Store files.'
    echo '    '
    echo '    -a / --add'
    echo '    Adds every unversioned files in the working-copy.'
    echo ''
}

SvnUtil_AutoKeywords()
{
    for subFile in "$1"/*; do
        
        if [ -d "$subFile" ]; then
            
            SvnUtil_AutoKeywords "$subFile"
            
        elif [ -f "$subFile" ]; then
            
            svn propset svn:keywords "Date Revision Author HeadURL Id" "$subFile"
            
        fi
        
    done
}

SvnUtil_Delete()
{
    if [ -d "$1/.svn" ]; then
        
        echo "Deleting $1/.svn"
        rm -rf "$1/.svn"
        
    fi
    
    for subFile in "$1"/*; do
        
        if [ -d "$subFile" ]; then
            
            SvnUtil_Delete "$subFile"
            
        fi
        
    done
}

SvnUtil_Clean()
{
    if [ -f "$1/.DS_Store" ]; then
        
        echo "Deleting $1/.DS_Store"
        rm -f "$1/.DS_Store"
        
    fi
    
    for subFile in "$1"/*; do
        
        if [ -d "$subFile" ]; then
            
            SvnUtil_Clean "$subFile"
            
        fi
        
    done
}

SvnUtil_Add()
{
    local svnStatus=$(svn status "$1")
    local add=0
    
    for svnFile in $svnStatus; do
        
        if [ $add -eq 1 ]; then
            
            svn add "$svnFile"
            
        fi
        
        if [ "$svnFile" == "?" ]; then
            
            add=1
            
        else
            
            add=0
            
        fi
        
    done
}

if [ $# -ne 2 ]; then
    
    SvnUtil_Usage $0
    
elif [ ! -d "$2" ]; then
    
    echo 'Error: the specified directory does not exist'
    
elif [ ! -d "$2/.svn" ]; then
    
    echo 'Error: the specified directory does not seem to be a SVN working copy'
    
elif [ $1 == '-k' ] || [ $1 == '--auto-keywords' ]; then
    
    SvnUtil_AutoKeywords $2
    
elif [ $1 == '-d' ] || [ $1 == '--delete' ]; then
    
    SvnUtil_Delete $2
    
elif [ $1 == '-c' ] || [ $1 == '--clean' ]; then
    
    SvnUtil_Clean $2
    
elif [ $1 == '-a' ] || [ $1 == '--add' ]; then
    
    SvnUtil_Add $2
    
else
    
    SvnUtil_Usage $0
    
fi
