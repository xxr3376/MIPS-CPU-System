import sys
def isfilelike_r(f):
    """
    Check if object 'f' is readable file-like 
	that it has callable attributes 'read' and 'close'
    """
    try:
        if isinstance(getattr(f, "read"), collections.Callable) and isinstance(getattr(f, "close"), collections.Callable):
			return True
    except AttributeError:
        pass
    return False

def isfilelike_w(f):
    """
    Check if object 'f' is readable file-like 
	that it has callable attributes 'write' and 'close'
    """
    try:
        if isinstance(getattr(f, "write"), collections.Callable) and isinstance(getattr(f, "close"), collections.Callable):
			return True
    except AttributeError:
		pass
    return False
def fileinoutpattern(inp, out, callback=None, inmode="r", outmode="wb"):
	"""
	Make sure that 'inp' and 'out' has been 'converted' to file objects, 
	and call 'callback' with them, finally clear it up. 
	"""
	# Set up
	fin = inp
	if not isfilelike_r(fin):
		fin = open(inp, inmode)
	fout = out
	if not isfilelike_w(fout):
		fout = open(out, outmode)
	# Call the 'callback'
	result = None
	if callback != None:
		result = callback(fin, fout)
	# Clear up
	if not isfilelike_r(inp):
	    fin.close()
	if not isfilelike_w(out):
	    fout.close()
	
	return result
def binhex(inp, out, extfun=lambda x: x, blocksize=256):
	def _binhex(fin, fout):
		filesize = 0
		while True:
			chunk = fin.read(blocksize)
			if chunk:
				redlen = len(chunk)
				for b in chunk:				
					fout.write('%02X ' % extfun(ord(b)))
				fout.write('\n')
				filesize += redlen
			else:
				break
		return filesize
	return fileinoutpattern(inp, out, _binhex, inmode="rb", outmode="w")
src = sys.argv[1]
dest = src[0:src.find('.')] + '.hex'
binhex(src, dest)
middle = open('notepad.hex', 'r')
lines = middle.readlines()
lines = ''.join(lines)
middle.close()
tmp = '';
for i in range(0, len(lines)/ 6):
	tmp = tmp + lines[i * 6 + 3] + lines[i * 6 + 4] + lines[i * 6] + lines[i * 6 + 1] + '\n';
output = open('notepad.hex', 'w')
output.write(tmp)
output.close()
