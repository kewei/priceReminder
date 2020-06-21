#!/Users/kewei/Dropbox/Websites/Amazon/price_web/venv/bin/python
import sys
import logging
logging.basicConfig(stream=sys.stderr)
#sys.path.insert(0,"/home/ubuntu/price_web/")
sys.path.insert(0,"/Users/kewei/Dropbox/Websites/Amazon/price_web")
#activate_this = '/home/ubuntu/price_web/venv/bin/activate_this.py'
activate_this = '/Users/kewei/Dropbox/Websites/Amazon/price_web/venv/bin/activate_this.py'
execfile(activate_this, dict(__file__=activate_this))

from price_web import app as application
