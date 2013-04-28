SVN-Util
========

About
-----

SVN-Util is a small but useful shell script to simplify some operations on SVN working-copies.

Documentation
-------------

### 1. Features

#### 1.1. Automatic SVN keywords

SVN-Util can be used to automatically set the «svn:keywords» property on all regular files of a working-copy.

The `svn:keywords` property is used to automatically replace some keywords in your files.
For instance, the `$Id$` keyword that is automatically expanded with the commit's date and author, revision number, etc.

With Subversion, you need to set the list of available keywords on all files. SVN-Util can do this automatically for all the files in a working-copy.

To do this, simply invoke the script with the `-k` or `--keywords` command:

    svn-util -k ~/myProject

#### 1.2. SVN removal

Subversion stores informations about a working-copy in hidden directories named `.svn`. Such a directory is present in every directory of a working-copy.

SVN-Util can automatically delete all that `.svn` directories in a working-copy, making it a standard, unversionned directory.  
This can be useful for instance if you want to copy a working-copy over FTP, or create an archive.

To do this, simply invoke the script with the `-d` or `--delete` command:

    svn-util -d ~/myProject

#### 1.3. Mac OS X cleanup

Mac OS X stores the Finder view's settings per directory in hidden files named `.DS_Store`.  
When manipulating files from the Finder, those files are automatically created in the directories you are working in.

It can be very embarrassing when using a SVN working-copy, as you will see all that `.DS_Store` files reported as unversionned files.  
SVN-Util can clean all the `.DS_Store` files in a working-copy. 
 
To do this, simply invoke the script with the `-c` or `--clean` command:

    svn-util -c ~/myProject
    
#### 1.4. Automatic SVN add

SVN-Util can be used to automatically mark all unversionned files present in working-copy, so they will be added to the repository with the next commit.  

To do this, simply invoke the script with the `-a` or `--add` command:

    svn-util -a ~/myProject
    
### 2. Usage

The script has to be invoked from the command line.  
It takes two arguments: a command name and the path to a SVN working-copy.

Please refer to the features list to learn more about the available commands.  
For instance:

    bash svn-util.sh -k ~/myProject

Note that you can also make the SVN-Util script available like standard Unix commands.  
Simply copy it in a directory that's included in your executable path (like `/usr/local/bin/`), and make sure the executable flag is set.

For instance:

    sudo cp svn-util.sh /usr/local/bin/svn-util
    sudo chmod 755 /usr/local/bin/svn-util

You'll then be able to call the script as a normal executable:

    svn-util -k ~/myProject

License
-------

SVN-Util is released under the terms of the BSD License.

Repository Infos
----------------

    Owner:			Jean-David Gadina - XS-Labs
    Web:			www.xs-labs.com
    Blog:			www.noxeos.com
    Twitter:		@macmade
    GitHub:			github.com/macmade
    LinkedIn:		ch.linkedin.com/in/macmade/
    StackOverflow:	stackoverflow.com/users/182676/macmade
