# !user/bin/bash

echo "copying pyx file..."
cp fabfile.py fabfile.pyx
# back up if needed
cp fabfile.py backup.py
echo "Done"
# build setup.py for compiling the code
echo "Building setup.py..."
touch setup.py
echo "from distutils.core import setup" >> setup.py
echo "from Cython.Build import cythonize" >> setup.py
echo "setup(
	name='fabfile',
	ext_modules = cythonize(
		'fabfile.pyx'
	)
)
" >> setup.py
echo "Done"
# build so
echo "Buidling .so file..."
python setup.py build_ext --inplace
echo "Done"
# overwrite fabfile.py
echo "Overwriting original fabfile..."
cat /dev/null > 'fabfile.py'
echo "import ctypes
so = ctypes.CDLL('fabfile.so')" >> fabfile.py
echo "Done"
rm -r 'fabfile.c' 'fabfile.pyx' 'setup.py'
rm -rf 'build's