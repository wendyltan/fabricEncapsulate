# fabricEncapsulate
Use this shell script to encapsulate your fabfile.py!

## Content 
`hide.sh` : transfer fabfile to encapsulated fabfile.so,but still can use it normally.

## Requirement
To use  `hide.sh`,make sure your python has `fabric` and `Cython` modules installed.If you don't know what they are,please google them.

## Noted
Please put all your module py files that fabfile relys on with your `fabfile.py`under same directory.

## Output 
One py script per `.so` file

## Usage
Go to `/fabGen` directory and run `fab your_command` as you used to do when using original fabfile. 
