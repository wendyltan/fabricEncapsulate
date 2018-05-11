# !user/bin/bash

# must handle all module imported in fabfile.
handle(){
	
	mkdir fabGen	
	echo "copying pyx file..."
	for i in `ls *.py`;do
		cp $i fabGen/$(basename $i .py).pyx
	done
	echo "Done"

	cd fabGen

	# build setup.py for compiling the code
	echo "Building setup.py..."
	touch setup.py
	echo "from distutils.core import setup" >> setup.py
	echo "from Cython.Build import cythonize" >> setup.py
	echo "setup(
		name='fabfile',
		ext_modules = cythonize(
			'*.pyx'
		)
	)
	" >> setup.py
	echo "Done"

	# build so
	echo "Building .so file..."
	# couldn't build only one .so file https://stackoverflow.com/questions/44704842/how-to-compile-multiple-python-files-into-a-unique-shared-library-file-using-cyt
	python setup.py build_ext --inplace
	echo "Done"

	# overwrite fabfile.py
	echo "Overwriting original fabfile..."
	
	touch fabfile.py
	cat /dev/null > 'fabfile.py'
	echo "import ctypes" >> fabfile.py
    echo "so = ctypes.CDLL('fabfile.so')" >> fabfile.py
	echo "Done"

	# remove all temp files
	rm -r 'setup.py'
	rm `ls *.c`
	rm `ls *.pyx`
	rm -rf 'build'
	cd ../
	
}

handle