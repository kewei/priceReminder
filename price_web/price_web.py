#!/Library/Frameworks/Python.framework/Versions/2.7/bin/python
# -*- coding: utf-8 -*-
import sys
sys.path.insert(0, "/home/ubuntu/price_web/venv/lib/python2.7/site-packages/")
from flask import Flask, request, render_template, session, g, redirect, url_for, \
     abort, render_template, flash, Response
from flaskext.mysql import MySQL
import MySQLdb
import json
from werkzeug import generate_password_hash, check_password_hash
from scrapyd_api import ScrapydAPI
from scrapyd_api.exceptions import ScrapydResponseError
import datetime
from urlparse import urlparse
import time
from flask_mail import Mail, Message
from flask_user import login_required, UserManager, UserMixin, SQLAlchemyAdapter
from flask.ext.sqlalchemy import SQLAlchemy
from itsdangerous import URLSafeTimedSerializer
from oauth2client import client, crypt
from celery import Celery
#from flask.ext.redis import Redis
from celery.schedules import crontab
import ssl, requests, os
# import facebook


mail = Mail()
app = Flask(__name__)
context = ssl.SSLContext(ssl.PROTOCOL_SSLv23)
context.load_cert_chain('/home/ubuntu/ssh/cert.pem', '/home/ubuntu/ssh/key.pem')

#configuration
app.config.update(dict(PREFERRED_URL_SCHEME = 'https'))
app.config['SECRET_KEY'] = '\xd2\xb2p=g\x83j\xe2\xab\xcfc\x04\xf3e\xb6/\xb1\xd7\x81"\xe7\xe9[\xa8'
app.config['SECURITY_PASSWORD_SALT'] = '82f44563e3dbfa323e4fb9937ef76064'
app.config['SESSION_TYPE'] = 'filesystem'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:xxxxxxxx@localhost'
app.config['CSRF_ENABLED'] = True
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'xxxxxxxx'
app.config['MYSQL_DATABASE_DB'] = 'pricereminder'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
app.config['MAIL_SERVER'] = 'mail.xxxxxxx.se'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True
app.config['MAIL_USERNAME'] = "noreply@xxxxxx.com"
app.config['MAIL_PASSWORD'] = "xxxxxxx"
app.config['MAIL_DEFAULT_SENDER '] = None
app.config['CELERY_BROKER_URL'] = 'redis://localhost:6379/0'
app.config['CELERY_RESULT_BACKEND'] = 'redis://localhost:6379/0'
app.config['CELERY_TIMEZONE'] = 'Europe/Stockholm'
app.config['REDIS_HOST'] = 'localhost'
app.config['REDIS_PORT'] = 6379
app.config['REDIS_DB'] = 0
app.config['CELERYBEAT_SCHEDULE'] = {

    'add-every-monday-morning': {
        'task': 'tasks.weekly_timer',
        'schedule': crontab(hour=8, minute=30, day_of_week=1),
        'args': ('1',),
    },
                                     'add-every-tuesday-morning': {
        'task': 'tasks.weekly_timer',
        'schedule': crontab(hour=8, minute=30, day_of_week=2),
        'args': ('2',),
    },
                                     'add-every-wensday-morning': {
        'task': 'tasks.weekly_timer',
        'schedule': crontab(hour=8, minute=30, day_of_week=3),
        'args': ('3',),
    },
                                     'add-every-thursday-morning': {
        'task': 'tasks.weekly_timer',
        'schedule': crontab(hour=8, minute=30, day_of_week=4),
        'args': ('4',),
    },
                                     'add-every-friday-morning': {
        'task': 'tasks.weekly_timer',
        'schedule': crontab(hour=8, minute=30, day_of_week=5),
        'args': ('5',),
    },
                                     'add-every-saturday-morning': {
        'task': 'tasks.weekly_timer',
        'schedule': crontab(hour=8, minute=30, day_of_week=6),
        'args': ('6',),
    },
                                     'add-every-sunday-morning': {
        'task': 'tasks.weekly_timer',
        'schedule': crontab(hour=8, minute=30, day_of_week=0),
        'args': ('7',),
    },
                                     'price-scan-everyday': {
         'task': 'tasks.price_scan',
         'schedule': crontab(hour=1, minute=0),                                                    
    },
}

# redis = Redis(app)
mysql = MySQL()
mysql.init_app(app)
mail.init_app(app)
conn = mysql.connect()
cursor = conn.cursor()
# db = SQLAlchemy(app)

def make_celery(app):
    celery = Celery(app.import_name, broker=app.config['CELERY_BROKER_URL'])
    celery.conf.update(app.config)
    TaskBase = celery.Task
    class ContextTask(TaskBase):
        abstract = True
        def __call__(self, *args, **kwargs):
            with app.app_context():
                return TaskBase.__call__(self, *args, **kwargs)
    celery.Task = ContextTask
    return celery
celery = make_celery(app)

@app.route('/find_enteries')
def find_entries():
    if request.method == 'GET':
        query = "SELECT * FROM elgiganten"
        results = pre_json(query)
        return json.dumps(results)
def pre_json(query):
    cursor.execute(query)
    items = [dict((cursor.description[ind][0], value)
    for ind, value in enumerate(row)) for row in cursor.fetchall()]
    return (items[0] if items else None) if False else items

@app.route('/', methods=['GET', 'POST'])
def register_product():
    if request.method == 'GET':
        return render_template('register_product.html', title="Register your product")
    elif request.method == 'POST':
        company_name = get_company(request.form['producturl'])
        try:
            if session['logged_in'] == True:
                email = session['email']
            else:
                email = request.form['email']
        except KeyError:
            email = request.form['email']
        try:
            query_check = "SELECT * FROM prod_reg_index WHERE reg_email=%s AND prod_url=%s"
            cursor.execute(query_check, (email, request.form['producturl']))
            conn.commit()
            row = cursor.fetchone()
            if row:
                flash("You already registered this product before, please signin to check it.")
                return render_template('register_product.html')
            else:
                cursor.execute("""INSERT INTO prod_reg_index (prod_title, prod_url, price_min, price_max, 
                                reg_email, time_registered) VALUES (%s, %s, %s, %s, %s, %s)""", 
                           (request.form['productname'], request.form['producturl'], request.form['price_min'], 
                            request.form['price_max'], email, datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')) )
                conn.commit()
        except MySQLdb.OperationalError as e:
            flash(e.message)
        try:
            scrapyd = ScrapydAPI('http://localhost:6800')
            scrapyd.schedule('priceremider', company_name, start_url=request.form['producturl'])
        except ScrapydResponseError:
            mail.init_app(app)
            msg = Message("ScrapyResponseError",
                  sender=("NoReply", "noreply@xxxxxx.com"),
                  recipients=['admin@xxxxxx.com'])
            msg.html = "<p>System Error,</p> <p>ScrapydResponseError-the regarding registered url: </p>" \
                        +request.form['producturl']          
            send_async_email.delay(msg)
#         session['prod_url'] = request.form['producturl']
#         session['company_name'] = company_name
        return current(request.form['producturl'], company_name)
def get_company(prod_url):
    if prod_url.startswith('http://www') or prod_url.startswith('https://www') \
            or prod_url.startswith('//'):
            url_reg = urlparse(prod_url).netloc
            result_split = url_reg.split('.')
            return result_split[1]
    elif prod_url.startswith('www.'):
            url_reg = urlparse(prod_url).scheme
            result_split = url_reg.split('.')
            return result_split[1]
    elif prod_url.startswith('http://') or prod_url.startswith('https://')  \
        and (not prod_url.startswith('http://www')) and (not prod_url.startswith('https://www')):
            url_reg = urlparse(prod_url).netloc
            result_split = url_reg.split('.')
            return result_split[0]
    else:
            flash('Product web address needs starting with "http://" or "www".')
            return None
def current(prod_url, company_name):
    query_search = """SELECT title, image, url, description, price, status FROM %s WHERE url = %%s""" \
                    % company_name
    try:
        cursor.execute(query_search, (prod_url,))
        conn.commit()
        row = cursor.fetchone()
        if (row):
            return render_template('current.html', title ='Current Price', result=row)
        else:
            time.sleep(0.5)
            return render_template('current.html', title ='Registered Successfully', session=session, 
                                   result=[])
    except MySQLdb.Error as err:
        mail.init_app(app)
        msg = Message("MySQLError",
                  sender=("NoReply", "noreply@xxxxxxx.com"),
                  recipients=['admin@xxxxxxx.com'])
        msg.html = "<p>MySQL Error,</p> <p>The regarding query: </p>" + str(err) + \
                    "<br>SELECT title, image, url, description, price, status FROM " +company_name+ \
                    " WHERE url =" +prod_url          
        send_async_email.delay(msg)
        return render_template('current.html', title ='Registered Successfully', session=session, result=[])
def webhallen_status(status):
    items = status.split("\\n")
    results=[]
    for item in items:
        results.append(item.strip())
    return results
app.jinja_env.globals.update(webhallen_status=webhallen_status)
@app.route('/feedback', methods=['POST'])
def feedback():
    query_feedback = "INSERT INTO feedback (opinion, comments, email) VALUES (%s, %s, %s)"
#     return json.dumps((request.form['opinion'], request.form['comments'], request.form['email']))
    try:
        if session['logged_in'] == True:
            email = session['email']
        else:
            email = request.form['email']
    except KeyError:
        email = request.form['email']
    if (cursor.execute(query_feedback, (request.form['opinion'], request.form['comments'], email))):
        conn.commit()
        flash('Thanks for your feedback!')
    return redirect('register_product')
@app.errorhandler(404)
def page_not_found(error):
    return 'This page does not exist', 404

@app.route('/signup', methods=['GET', 'POST'])
def signup():
#     error = None
    if request.method == 'POST':
#         if valid_login(request.form['username'], request.form['password'], request.form['email']):
            name = request.form['username']
            hashed_password = generate_password_hash(request.form['password'])
            email = request.form['email']
            if (add_entry_user(name, hashed_password, email)):
                return render_template('login.html')
            else:
                return redirect('signup')        
#             error = "Invalid username/password/email."
    elif request.method == 'GET':
        return render_template('signup.html', title="Sign Up")
            
def add_entry_user(name, passwd, email):
    validate_result = True
    query_name = "SELECT * FROM users WHERE name=%s"
    cursor.execute(query_name, (name,))
    name_row = cursor.fetchone()
    query_email = "SELECT * FROM users WHERE email=%s"
    cursor.execute(query_email, (email,))
    email_row = cursor.fetchone()
    if name_row:
        flash('Your username is already taken!')
        validate_result = False
    elif email_row:
        flash('Your email is already registered!')
        validate_result = False
    if (validate_result):
        query = "INSERT INTO users (name, password, email, time_registered) VALUES (%s, %s, %s, %s)"
        try:
            cursor.execute(query, (name, passwd, email, datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')))
            conn.commit()
            flash('You are successfully registered!')
            return True
        except MySQLdb.OperationalError as e:
            flash(e)
            return False
    else:    
        return False

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        query_name = "SELECT name, password, email FROM users WHERE name=%s"
        try:
            cursor.execute(query_name, (request.form['username'],))
            row = cursor.fetchone()
            if row:
                if (check_password_hash(row[1], request.form["password"])):
                    session['logged_in'] = True
                    session['username'] = request.form['username']
                    session['email'] = row[2]
                    query_update = "UPDATE users SET last_login=%s WHERE email=%s"
                    mysql_exe.delay(query_update,(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), 
                                                  row[2]))
                    return redirect(url_for('favorites'))
                else:
                    flash('Incorrect password!')
            else:
                flash('Username does not exist!')    
        except MySQLdb.OperationalError as e:
            flash(e)
    elif request.method == "GET":
        render_template('login.html', title="Sign In")
    return render_template('login.html', error=error, title="Sign In")
@app.route('/google_ext', methods=["POST"])
def google_ext():
    APP_CLIENT_ID = "xxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com"
    prod_url = request.form['prod_url']
    price_min = request.form['price_min']
    price_max = request.form['price_max']
    token = request.form['access_token']
    company_name = get_company(prod_url)
    req_uri = 'https://www.googleapis.com/oauth2/v3/tokeninfo?access_token='+token
    req = requests.get(req_uri).json()
    if req['aud'] not in [APP_CLIENT_ID]:
        return json.dumps({'status': 'Unrecognized client'})
    if req['expires_in'] < 1:
        return json.dumps({'status': 'invalid token'})
    headers = {'Authorization': 'Bearer {}'. format(token)}
    req_user = requests.get("https://www.googleapis.com/plus/v1/people/me", headers=headers).json()
    try:
        query_user = "select * from users where email=%s"
        cursor.execute(query_user, (req['email'],))
        conn.commit()
        row = cursor.fetchone()
        if row:
            try:
                query_check = "SELECT * FROM prod_reg_index WHERE reg_email=%s and prod_url=%s"
                cursor.execute(query_check, (req['email'], prod_url))
                conn.commit()
                row0 = cursor.fetchone()
                if row0:
                    query_update = """UPDATE prod_reg_index SET price_min=%s, price_max=%s, time_registered=%s 
                                    WHERE reg_email=%s AND prod_url=%s"""
                    try:
                        cursor.execute(query_update, (price_min, price_max, datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), 
                                        req['email'], prod_url))
                        conn.commit()
                        try:
                            scrapyd = ScrapydAPI('http://localhost:6800')
                            scrapyd.schedule('priceremider', company_name, start_url=prod_url)
                        except ScrapydResponseError:
                                mail.init_app(app)
                                msg = Message("ScrapyResponseError",
                                          sender=("NoReply", "noreply@xxxxxxxxxxxx.com"),
                                          recipients=['admin@xxxxxxxxx.com'])
                                msg.html = "<p>System Error,</p> <p>ScrapydResponseError-the regarding registered url: </p>" \
                                        +request.form['producturl']          
                                send_async_email.delay(msg)
                    except MySQLdb.Error as err:
                        return json.dumps(str(err))
                        
                else:
                    query_add = "INSERT INTO prod_reg_index (reg_email, time_registered, prod_url, price_min, \
                                price_max) VALUES (%s, %s, %s, %s, %s)"
                    try:
                        cursor.execute(query_add, (req['email'], datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), 
                                          prod_url, price_min, price_max))
                        conn.commit()
                        try:
                            scrapyd = ScrapydAPI('http://localhost:6800')
                            scrapyd.schedule('priceremider', company_name, start_url=prod_url)
                        except ScrapydResponseError:
                            mail.init_app(app)
                            msg = Message("ScrapyResponseError",
                                          sender=("NoReply", "noreply@xxxxxxxxxxx.com"),
                                          recipients=['admin@xxxxxxxxx.com'])
                            msg.html = "<p>System Error,</p> <p>ScrapydResponseError-the regarding registered url: </p>" \
                                        +request.form['producturl']          
                            send_async_email.delay(msg)
                    except MySQLdb.Error as err:
                        return json.dumps(str(err)) 
            except MySQLdb.Error as err:
                return json.dumps(str(err))
            query_edit = "UPDATE users SET last_login=%s WHERE email=%s"
            try:
                cursor.execute(query_edit, (datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), 
                                req['email']))
                conn.commit()
                return json.dumps({"status": "Added successfully"})
            except MySQLdb.Error as err:
                return json.dumps(str(err))
        else:
            query_add_user = "INSERT INTO users (name, password, email, time_registered) VALUES (%s, %s, %s, %s)"
            hashed_password = generate_password_hash('I am signed in with google')
            try:
               cursor.execute(query_add_user, (req_user['displayName'], hashed_password, req['email'], 
                                               datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')))
               conn.commit()
            except MySQLdb.Error as err:
                return json.dumps(str(err))
            query_add = "INSERT INTO prod_reg_index (reg_email, time_registered, prod_url, price_min, \
                                price_max) VALUES (%s, %s, %s, %s, %s)"
            try:
                cursor.execute(query_add, (req['email'], datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), 
                                prod_url, price_min, price_max))
                conn.commit()
                try:
                    scrapyd = ScrapydAPI('http://localhost:6800')
                    scrapyd.schedule('priceremider', company_name, start_url=prod_url)
                except ScrapydResponseError:
                    mail.init_app(app)
                    msg = Message("ScrapyResponseError",
                                  sender=("NoReply", "noreply@xxxxxxxxxxx.com"),
                                          recipients=['admin@xxxxxxxxxxx.com'])
                    msg.html = "<p>System Error,</p> <p>ScrapydResponseError-the regarding registered url: </p>" \
                                        +request.form['producturl']          
                    send_async_email.delay(msg)
                return json.dumps({"status": "successful"})
            except MySQLdb.Error as err:
                return json.dumps(str(err))  
    except MySQLdb.Error as err:
        mail.init_app(app)
        msg = Message("MySQLError",
                  sender=("NoReply", "noreply@xxxxxxxxxxx.com"),
                  recipients=['admin@xxxxxxxx.com'])
        msg.html = "<p>MySQL Error,</p> <p>The regarding query from google_ext(): </p>" + str(err) +"<br>" \
                    +query_user + req['email']         
        send_async_email.delay(msg)
        return json.dumps(str(err))   
# @app.route('/facebook_login', methods=['POST'])
# def facebook_login():
#     app_secret = "xxxxxxxxxxxxxxxx"
#     app_id = "xxxxxxxxxx"
#     redirect_uri = "https://localhost:5000/"
#     req_url = "https://graph.facebook.com/oauth/access_token?client_id={0}&client_secret={1}& \
#                  &redirect_uri={2}&grant_type=client_credentials".format(app_id,app_secret,redirect_uri)
# #    req_url   = "https://graph.facebook.com/endpoint?key=value&amp;access_token={0}|{1}".format(app_id, app_secret)
#     app_token = requests.get(req_url).text
#     app_access_token = app_token.replace("access_token=", "")
#     user_access_token = request.form['access_token']
#     client_token = "xxxxxxxxxxxxxxxx"
#     verif_token = requests.get("https://graph.facebook.com/v2.5/debug_token?input_token=" +user_access_token+ "&access_token=" +app_access_token).json()
#     if verif_token['data']['user_id'] != request.form['id']:
#         return render_template('login.html', error="Unauthorized user", title="Sign In")
#     elif verif_token['data']['is_valid'] != True:
#          return render_template('login.html', error="Invalide access token", title="Sign In")
#     graph = facebook.GraphAPI(access_token=app_access_token, version='2.5')
#     event = graph.get_object(id=verif_token['data']['user_id'], fields='email,name') 
#     name = event['name']
#     email = event['email']
#     session['username'] = name
#     session['email'] = email
# #     session['app_access_token'] = app_access_token
# #     session['user_id'] = verif_token['data']['user_id']
#     hashed_password = generate_password_hash('I am signed in with facebook')
#     query_user = "SELECT * FROM users WHERE email=%s"
#     cursor.execute(query_user, (email,))
#     conn.commit()
#     row = cursor.fetchone()
#     if row:
#         query_edit = "UPDATE users SET last_login=%s WHERE email=%s"
#         try:
#             cursor.execute(query_edit, (datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), email))
#             conn.commit()
#         except MySQLdb.Error as err:
#             return render_template('login.html', error=err, title="Sign In")
#     else:
#         query_insert = "INSERT INTO users (name, password, email, time_registered) VALUES (%s, %s, %s, %s)"
#         try:
#             cursor.execute(query_insert, (name, hashed_password, email, 
#                                           datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')))
#             conn.commit()
#         except MySQLdb.Error as err:
#             return render_template('login.html', error=err, title="Sign In")
#     session['logged_in'] = True
#     session['provider'] = 'facebook'
#     Response.data = url_for('favorites')
#     return Response.data
# @app.route('/facebook_ext', methods=['POST'])
# def facebook_ext():
#     code = request.form['code']
#     redirect_uri = request.form['redirectUri']
#     APP_ID = 'xxxxxxxxxxxxxx'
#     APP_SECRET = 'xxxxxxxxxxxxxxxxxxxxxx'
#     req_uri = "https://graph.facebook.com/v2.5/oauth/access_token?client_id=" +APP_ID+ "&redirect_uri=" + \
#             redirect_uri+ "&client_secret=" +APP_SECRET+ \
#             "&code=" +code
#     response = requests.get(req_uri).json()
#     if response["expires_in"] < 1:
#         return json.dumps({"Status": "Invalid authorized code"})
#     else:
#         access_token = response['access_token']
#         return json.dumps(access_token)
    
@app.route('/google_login', methods=['POST'])
def google_login():
    token = request.form['idtoken']
    WEB_CLIENT_ID = "xxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com"
    try:
        idinfo = client.verify_id_token(token, WEB_CLIENT_ID)
        # If multiple clients access the backend server:
        if idinfo['aud'] not in [WEB_CLIENT_ID]: #[ANDROID_CLIENT_ID, IOS_CLIENT_ID, WEB_CLIENT_ID]:
            
            raise crypt.AppIdentityError("Unrecognized client.")
            return render_template('login.html', error="Unrecognized client", title="Sign In")
        if idinfo['iss'] not in ['accounts.google.com', 'https://accounts.google.com']:
            raise crypt.AppIdentityError("Wrong issuer.")
            return render_template('login.html', error="Wrong issuer", title="Sign In")
    except crypt.AppIdentityError:
        # Invalid token
        return render_template('login.html', error="Invalida token", title="Sign In")
    name = idinfo['name']
    email = idinfo['email']
    session['username'] = name
    session['email'] = email
    hashed_password = generate_password_hash('I am signed in with google')
    query_user = "SELECT * FROM users WHERE email=%s"
    cursor.execute(query_user, (email,))
    conn.commit()
    row = cursor.fetchone()
    if row:
        query_edit = "UPDATE users SET last_login=%s WHERE email=%s"
        try:
            cursor.execute(query_edit, (datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), email))
            conn.commit()
        except MySQLdb.Error as err:
            flash(err)
    else:
        query_insert = "INSERT INTO users (name, password, email, time_registered) VALUES (%s, %s, %s, %s)"
        try:
            cursor.execute(query_insert, (name, hashed_password, email, 
                                          datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')))
            conn.commit()
        except MySQLdb.Error as err:
            flash(err)
    session['logged_in'] = True
    session['provider'] = 'google'
    Response.data = url_for('favorites')
    return Response.data       
@login_required                                 # Use of @login_required decorator
@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    return redirect(url_for('login'))

@app.route('/about', methods=["GET"])
def about():
    return render_template('about.html')
@login_required                                 # Use of @login_required decorator
@app.route('/favorites')
def favorites():
    try:
        if session['logged_in'] == True:
            query_user = "SELECT prod_url FROM prod_reg_index WHERE reg_email=%s ORDER BY time_registered DESC"
            cursor.execute(query_user, (session['email'],))
            conn.commit()
            rows = cursor.fetchall()
            results = []
            for row in rows:
                try:
                    company_name = get_company(row[0])
                    query_prod = """SELECT title, image, url, description, price, status FROM %s 
                                WHERE url = %%s""" % company_name
                    cursor.execute(query_prod, (row[0],))
                    conn.commit()
                    items = [dict((cursor.description[ind][0], value) 
                          for ind, value in enumerate(row)) for row in cursor.fetchall()]
                    if items:
                        results.append(items)
                except:
                    pass
            return render_template('favorites.html', name=session['username'], results=results, title="Favorites")
    except KeyError:
        return redirect(url_for('login'))
@login_required                                 # Use of @login_required decorator
@app.route('/delete_favorite', methods=['POST'])
def delete_favorite():
    name = request.form['name']
    prod_url = request.form['prod_url']
    try:
        if session['logged_in'] == True:
            if name == session['username']:
                try: 
                    query_delete = "DELETE FROM prod_reg_index WHERE reg_email=%s AND prod_url=%s"
                    cursor.execute(query_delete, (session['email'], prod_url))
                    conn.commit()
                    return json.dumps({'status':'OK'})
                except MySQLdb.OperationalError:
                    return json.dumps({'status':'An Error occured.'})
            else:
                return json.dumps({'status':'An Error occured.'}) 
    except KeyError:
        return json.dumps({'status':'An Error occured.'})
@login_required                                 # Use of @login_required decorator
@app.route('/update_favorite', methods=['POST'])
def update_favorite():
    name = request.form['name']
    prod_url = request.form['prod_url']
    price_min = request.form['price_min']
    price_max = request.form['price_max']
    try:
        if session['logged_in'] == True:
            if name == session['username']:
                query_edit = "UPDATE prod_reg_index SET price_min=%s, price_max=%s WHERE reg_email=%s AND prod_url=%s"
                try: 
                    cursor.execute(query_edit, (price_min, price_max, session['email'], prod_url))
                    conn.commit()
                    return json.dumps({'status':'OK'})
                except MySQLdb.OperationalError:
                    return json.dumps({'status':'An Error occured.'})
            else:
                return json.dumps({'status':'An Error occured.'}) 
    except KeyError:
        return json.dumps({'status':'An Error occured.'})
@login_required                                 # Use of @login_required decorator   
@app.route('/account', methods=["GET", "POST"])
def account():
    try:
        if session['logged_in'] == True:
            email = session['email']
            if request.method == "POST":
                if request.form['password'] and request.form['frequency']:
                    hash_password = generate_password_hash(request.form['password'])
                    query_change_password = "UPDATE users SET password=%s, frequency=%s WHERE email=%s"
                    try:
                        cursor.execute(query_change_password, (hash_password, request.form['frequency'], email))
                        conn.commit()
                        flash("Settings saved!")
                        return render_template('account.html', name=session['username'], title="Account")
                    except MySQLdb.OperationalError as e:
                        flash(e)
                        return render_template('account.html', name=session['username'], title="Account")
                elif request.form['frequency']:
                    query_change_password = "UPDATE users SET frequency=%s WHERE email=%s"
                    try:
                        cursor.execute(query_change_password, (request.form['frequency'], email))
                        conn.commit()
                        flash("Settings saved!")
                        return render_template('account.html', name=session['username'], title="Account")
                    except MySQLdb.OperationalError as e:
                        flash(e)
                        return render_template('account.html', name=session['username'], title="Account")
            elif request.method == 'GET':
                return render_template('account.html', name=session['username'], title="Account")
    except KeyError:
        return redirect(url_for('login'))    
@app.route('/forgot_password', methods=['GET', 'POST'])
def forgot_password():
    if request.method == 'GET':
        return render_template('forgot_password.html')
    elif request.method == 'POST':
        email = request.form['email']
        query_user = "SELECT name FROM users WHERE email=%s"
        cursor.execute(query_user, (email,))
        conn.commit()
        row = cursor.fetchone()
        if row:
            token = generate_reset_token(email)
            reset_password_url = url_for('confirm_email', token=token, _external=True)
            
            msg = Message("Reset Password",
                  sender=("NoReply", "noreply@keweizhang.com"),
                  recipients=[email])
            msg.html = render_template('reset_password_email.html', reset_url=reset_password_url, name = row[0])           
            send_async_email.delay(msg)
            flash('Please check your email to reset your password, possibly in "Junk" folder')
        else:
            flash('Your email is not registered.') 
        return render_template('forgot_password.html')
@app.route('/confirm_email/<token>')
def confirm_email(token):
    try:
        email = confirm_token(token)
        session['token'] = token
        reset_password()
        return render_template('reset_password.html')
    except:
        flash('The confirmation link is invalid or has expired.', 'danger')
        return redirect(url_for('forgot_password'))
    
@app.route('/reset_password', methods=['GET','POST'])
def reset_password():
    if request.method == 'GET':
        return render_template('reset_password.html')
    elif request.method == 'POST':
        try:
            email = confirm_token(session['token'])
            new_passwd = generate_password_hash(request.form['password'])
            query_user = "UPDATE users SET password=%s WHERE email=%s"
            try:
                cursor.execute(query_user, (new_passwd, email))
                conn.commit()
                flash('Reset password successfully, you can log in now.')
                return render_template('login.html')
            except MySQLdb.OperationalError as e:
                flash(e)
                return render_template('forgot_password.html')
        except:
            flash('The link is invalid or has expired.', 'danger')
            return render_template('forgot_password.html')
    
def generate_reset_token(email):
    serializer = URLSafeTimedSerializer(app.config['SECRET_KEY'])
    return serializer.dumps(email, salt=app.config['SECURITY_PASSWORD_SALT'])
def confirm_token(token, expiration=7200):
    serializer = URLSafeTimedSerializer(app.config['SECRET_KEY'])
    try:
        email = serializer.loads(
            token,
            salt=app.config['SECURITY_PASSWORD_SALT'],
            max_age=expiration
        )
    except:
        return False
    return email

@app.route('/email_reminder')
@celery.task()
def email_reminder(results):
    for item in results:
        if item[4] == 'False':
            cursor.execute("SELECT name FROM users WHERE email=%s", (item[0],))
            user = (cursor.fetchone())[0]
            try:
                company_name = get_company(item[1])
                query_prod = "SELECT price, title FROM %s WHERE url=%%s" % company_name
                cursor.execute(query_prod, (item[1],))
                row = cursor.fetchone()     
                if row:
                    ch = ''.join(it for it in row[0] if '0' <= it <= '9')
                    if  int(item[2])<=int(ch)<=int(item[3]):
                        send_email(mail_addr=item[0], user=user, prod_title=row[1], prod_url=item[1])
                        query_emailed = "UPDATE prod_reg_index SET emailed=%s WHERE reg_email=%s AND prod_url=%s"
                        try:
                            cursor.execute(query_emailed, ('True', item[0], item[1]))
                            conn.commit()
                        except:
                            pass
            except:
                pass
    return json.dumps("You sent the message.")
@celery.task(name="tasks.send_async_email")
def send_async_email(msg):
    mail.send(msg)
@celery.task()
def connect_Scrapyd(row):
    company_name = get_company(row[1])
    scrapyd = ScrapydAPI('http://localhost:6800')
    scrapyd.schedule('priceremider', company_name, start_url=row[1])
@celery.task(name="tasks.price_scan")
def price_scan():
    query_urls = """SELECT reg_email, prod_url, price_min, price_max, emailed FROM prod_reg_index 
                    ORDER BY time_registered DESC"""
    try:
        cursor.execute(query_urls)
        conn.commit()
        rows = cursor.fetchall()
        for row in rows:
            try:
                connect_Scrapyd.delay(row)
            except ScrapydResponseError:
                mail.init_app(app)
                msg = Message("ScrapyResponseError",
                  sender=("NoReply", "noreply@xxxxxxxxx.com"),
                  recipients=['admin@xxxxxxxxx.com'])
                msg.html = "<p>System Error,</p> <p>ScrapydResponseError-the regarding registered url: </p>" \
                            + request.form['producturl']          
                send_async_email.delay(msg)
        email_reminder.delay(rows)
    except:
        pass    
@celery.task(name="tasks.mysql_exe")
def mysql_exe(query, param):
    try:
        cursor.execute(query, param)
        conn.commit()
    except MySQLdb.Error as err:
        flash(err)
@celery.task(name="tasks.weekly_timer")
#@app.route('/weekly_timer/<day_week>')
def weekly_timer(day_week):
    query_day = "SELECT email, name FROM users WHERE frequency=%s"
    try:
        cursor.execute(query_day, (int(day_week),))
        conn.commit()
        rows = cursor.fetchall()
        for row_email in rows:
            try:
                query_find_prods="SELECT prod_url FROM prod_reg_index WHERE reg_email=%s"
                cursor.execute(query_find_prods, (row_email[0],))
                conn.commit()
                urls = cursor.fetchall()
                results=[]
                for item in urls:
                    try:
                        company_name = get_company(item[0])
                        query_prod = "SELECT price, title, url FROM %s WHERE url=%%s" % company_name
                        cursor.execute(query_prod, (item[0],))
                        conn.commit()    
                        items = [dict((cursor.description[ind][0], value) 
                          for ind, value in enumerate(row)) for row in cursor.fetchall()]
                        if items:
                            results.append(items)
                            
                    except:
                        pass
                    
                msg = Message("Weekly update of your favorites",
                  sender=("PriceReminder", "noreply@xxxxxxxxx.com"),
                  recipients=[row_email[0]])
                msg.html = render_template('weekly_email.html', name=row_email[1], results=results)
                send_async_email.delay(msg)
            except:
                pass
    except:
        pass
    
def send_email(mail_addr, user, prod_title, prod_url):
    msg = Message("Your favorites are ready!",
                  sender=("PriceReminder", "noreply@xxxxxxxxxx.com"),
                  recipients=[mail_addr])
    msg.html = "Dear "+user.encode('ascii', 'backslashreplace')+",<br>" "The price of your product  \
                satisfies your requirement now, check it out!<br> <h4><a href='"  \
                +prod_url.encode('ascii', 'backslashreplace')+"'>" \
                +prod_title.encode('ascii', 'backslashreplace')+  \
                "</a></h4><br><br> <p>Your Sincerely，</p><p>PriceReminder Group</p>"
    send_async_email.delay(msg)
@app.before_request
def before_request():
    if request.url.startswith('http://'):
        url = request.url.replace('http://', 'https://', 1)
        code = 301
        return redirect(url, code=code)
@app.after_request
def add_header(response):
    """
    Add headers to both force latest IE rendering engine or Chrome Frame,
    and also to cache the rendered page for 10 minutes.
    """
    response.headers['X-UA-Compatible'] = 'IE=Edge,chrome=1'
    response.headers['Cache-Control'] = 'public, max-age=0'
    return response
def background_sendemail():
    pass

if __name__ == '__main__':
#     app.run(host='127.0.0.1',port=5000, debug = True)
    app.run(threaded=True,
        debug = True, ssl_context=context)
