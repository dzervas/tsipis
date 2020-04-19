from sys import stdin

try:
    from urllib.parse import urlparse
except ImportError:  # Python2
    from urlparse import urlparse

uri = stdin.readline().strip()
result = urlparse(uri)

# First character is /
database = result.path[1:]
netloc= result.netloc

username, netloc = netloc.split(":", 1)
password, netloc = netloc.split("@", 1)
host, port = netloc.split(":", 1)

print('{{"username":"{}","password":"{}","host":"{}","port":{},"database":"{}"}}'.format(username, password, host, port, database))
