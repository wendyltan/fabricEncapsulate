from fabric.api import local,run,env,roles,execute,get,put,prompt,cd
env.roledefs = {
	'list_task':["wendi@192.168.1.101"]
}
env.passwords = {
	'list_task':'123wendi'
}
env.hosts = ["192.168.1.101"]
env.user = 'wendi'
env.password = '123wendi'
def hello():
	print "Hello Fabric!"

def test_exec_local():
	local('echo "hello! man"')

@roles('list_task')
def list_task():
	run('ls -l /home/wendi/test')

def task():
	execute(list_task)

def test_get():
	get('/home/wendi/test/1.txt','1.txt')

def test_put():
	put('2.txt','/home/wendi/test/2.txt')

def test_prompt():
	filename = prompt('Please input filename: ',default='test',validate=str)
	get('/home/wendi/test/1.txt','%s.txt' %filename)
def test_cd():
	with cd('/home/wendi/test'):
		put('2.txt','3.txt')