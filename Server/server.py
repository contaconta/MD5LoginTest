
import hashlib
from flask import Flask, render_template, url_for, jsonify, request, escape, session, abort

app = Flask(__name__)
app.secret_key = 'my-secret-key'
app.debug = True

RANDOM_KEY_LENGTH = 32


def generate_random_str(length):
  import string
  import random
  chars = string.ascii_letters + string.digits

  retval =  "".join([ random.choice(chars) for i in range(RANDOM_KEY_LENGTH) ])
  return retval


@app.route('/login', methods=['POST','GET'])
def login():
  app.logger.debug(request.method)

  if request.method == 'GET':
    rndstr = generate_random_str(RANDOM_KEY_LENGTH)
    session['onetimekey'] = rndstr
    retval = {}
    retval['key'] = rndstr

    app.logger.debug('GET /login - key:' + rndstr)
    return jsonify(retval)


  elif request.method == 'POST':
    post_username = escape(request.form.get('username'))
    post_key= escape(request.form.get('key'))

    app.logger.debug('POST /login - username:%s key:%s' % (post_username, post_key) )

    # test data
    username = 'test'
    password = 'hoge'

    # if onetime key does not exist
    if not 'onetimekey' in session:
      abort(403)

    onetime_key = session.pop('onetimekey')

    m = hashlib.md5()
    m.update( username + password + onetime_key )
    correct_key = m.hexdigest()
    

    if post_key == correct_key:
      session['username'] = post_username
      return 'logged in'

    abort(403)



@app.errorhandler(403)
def invalid_request(error):
  session.clear()
  return 'invalid', 403

"""
@app.route('/md5')
def test():
  m = hashlib.md5()
  m.update('testaa--aa')
  return m.hexdigest()
"""


if __name__ == '__main__':
  app.run();

