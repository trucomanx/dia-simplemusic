# Gafieira-notation: Dia shapes library

The "gafieira-notation: Dia shapes library", It is a set of shapes to write a movement partiture to "samba de gafiera", this library was design to be loaded by the [Dia](http://dia-installer.de/) program. Thus, to use the library we need have installed the `Dia` program.


## Installation method from gafieira-notation-0.0.1.tar.gz

In the `gafieira-notation-0.0.1.tar.gz` compressed file, we have the directories `shapes` and `sheets`. These directories have the necessary shapes to write the moviment partiture to "samba de gafieira". Thus these 2 directories should be copied to the library directory of `Dia`.


### Shapes installation in GNU-Linux

In operating system based in GNU-Linux, we copy the `shapes` and `sheets` diretories to:

	~/.dia
	
By other side, if we have administrator permision, we can also copy the directories to:

	/usr/share/dia/
	
That, in this case is the installation directory of the `Dia` program.

### Shapes installation in Windows

In operating system based in Windows, we copy the `shapes` and `sheets` diretories to:

	%USERPROFILE%\.dia

Where `%USERPROFILE%` represents the name of home directory, you can see this value using the next command:

	echo %USERPROFILE%
