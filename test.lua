pwd = (io.popen("echo %cd%"):read('*l').."\\"):upper()

print(pwd)