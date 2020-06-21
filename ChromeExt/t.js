  var User = {
		    id:'',
		    name:'',
		    email:''
		  };
  var fb_access_token;
  var redirectUri;
  var tokenFetcher = (function() {
	    var clientId = '258360204532894';
	    redirectUri = 'https://' + chrome.runtime.id +
	                      '.chromiumapp.org/provider_cb';
	    var redirectRe = new RegExp(redirectUri + '[#\?](.*)');
	    fb_access_token = null;
	    
	    return {
	      getToken: function(interactive, callback) {
	        // In case we already have an access_token cached, simply return it.
	        if (fb_access_token) {
	          callback(null, fb_access_token);
	          return;
	        }

	        var options = {
	          'interactive': interactive,
	          url:'https://www.facebook.com/dialog/oauth?client_id=' + clientId +
	              '&reponse_type=token' +
	              '&scope=["email", "public_profile", "user_photos"]' +
	              '&auth_type=rerequest' +
	              '&redirect_uri=' + encodeURIComponent(redirectUri)
	        }
	        
	        chrome.identity.launchWebAuthFlow(options, function(redirectUri) {
	          if (chrome.runtime.lastError) {
	            callback(new Error(chrome.runtime.lastError));
	            console.log(chrome.runtime.lastError);
	            return;
	          }

	          // Upon success the response is appended to redirectUri, e.g.
	          // https://{app_id}.chromiumapp.org/provider_cb#access_token={value}
	          //     &refresh_token={value}
	          // or:
	          // https://{app_id}.chromiumapp.org/provider_cb#code={value}
	          var matches = redirectUri.match(redirectRe);
	          if (matches && matches.length > 1)
	            handleProviderResponse(parseRedirectFragment(matches[1]));
	          else
	            callback(new Error('Invalid redirect URI'));
	        });

	        function parseRedirectFragment(fragment) {
	          var pairs = fragment.split(/&/);
	          var values = {};

	          pairs.forEach(function(pair) {
	            var nameval = pair.split(/=/);
	            values[nameval[0]] = nameval[1];
	          });
	          return values;
	        }

	        function handleProviderResponse(values) {
	        	console.log(values);
	          if (values.hasOwnProperty('access_token'))
	            setAccessToken(values.access_token);
	          else if (values.hasOwnProperty('code'))
	            exchangeCodeForToken(values.code);
	          else callback(new Error('Neither access_token nor code avialable.'));
	        }

	        function exchangeCodeForToken(code) {
	        	var xhr = new XMLHttpRequest();
	        	xhr.open("POST", "https://localhost:5000/facebook_ext");
	        	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	        	xhr.onload = function() {
	        		console.log(xhr.responseText);
	        	};
	        	xhr.send("code=" +code+ "&redirectUri=" + redirectUri);
	        	xhr.onreadystatechange = function(){
  			    // process the server response
	        		if (xhr.readyState === XMLHttpRequest.DONE) {
	        			if (xhr.status === 200) {
	        				var response = JSON.parse(xhr.responseText);
	        				setAccessToken(response);
	        				fb_access_token = response;
	        				
	        			}
	        		}
	        	}
	        }

	        function setAccessToken(token) {
	          fb_access_token = token;
	          callback(null, fb_access_token);
	        }
	      },

	      removeCachedToken: function(token_to_remove) {
	        if (fb_access_token == token_to_remove)
	          fb_access_token = null;
	      }
	    }
	  })();
  function xhrWithFacebookAuth(method, url, interactive, callback) {
	    var retry = true;
	    getToken();

	    function getToken() {
	      tokenFetcher.getToken(interactive, function(error, token) {
	        if (error) {
	          callback(error);
	          return;
	        }
	        fb_access_token = token;
	        requestStart();
	      });
	    }

	    function requestStart() {
	      var xhr = new XMLHttpRequest();
	      xhr.open(method, url);
	      xhr.setRequestHeader('Authorization', 'Bearer ' + fb_access_token);
	      xhr.onload = requestComplete;
	      xhr.send("fields=id,name,email,picture");
	    }

	    function requestComplete() {
	      if (this.status != 200 && retry) {
	        retry = false;
	        tokenFetcher.removeCachedToken(fb_access_token);
	        fb_access_token = null;
	        getToken();
	      } else {
	        callback(null, this.status, this.response);
	      }
	    }
	  }
  function getFacebookUserInfo(interactive) {
	  console.log(fb_access_token);
	    xhrWithFacebookAuth('GET',
	                'https://graph.facebook.com/v2.6/me?' +fb_access_token,
	                interactive,
	                onFacebookUserInfoFetched);
	  }
  function onFacebookUserInfoFetched(error, status, response) {
	    if (!error && status == 200) {
	      var user_info = JSON.parse(response);
	      changeState(STATE_AUTHTOKEN_ACQUIRED);
	  console.log("Got the following user info: " + response);
	      User.id = user_info.id;
	      User.name = user_info.name;
	      User.email = user_info.email;
	      document.getElementById('user_info').innerHTML = 
	      "<b>Hello " + User.name + "</b><br>"
	            + "Your email is: " + User.email + "</b><br>" + 
	            "Link to your Facebook page is:" + user_info.link;
	    } else {
	    	changeState(STATE_START);
	    }
	  }

  function facebookSignIn() {
	  tokenFetcher.getToken(true, function(error, fb_access_token) {
	      if (error) {
	    	  changeState(STATE_START);
	      } else {
	    	changeState(STATE_AUTHTOKEN_ACQUIRED);
	        getFacebookUserInfo(true);
	      }
	    });
	  
  }  
function fb_revokeToken() {
	  user_info_div.innerHTML="";
	  var facebookDomain = "https://www.facebook.com";
	  chrome.cookies.getAll({"url": facebookDomain},function(cookies) {
		  console.log(cookies);
			  });
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "_ga" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "c_user" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "csm" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "datr" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "fr" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "locale" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "lu" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "p" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "pl" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "presence" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "wd" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "checkpoint" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "lu" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "s" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "sb" } );
	  chrome.cookies.remove ( {"url": facebookDomain, "name": "xs" } );
	  var xhr = new XMLHttpRequest();
      xhr.open('GET', 'https://www.facebook.com/logout.php?next=' +redirectUri+ '&access_token=' +
               fb_access_token);
      xhr.send();
      xhr.onreadystatechange = function(){
		    // process the server response
		    if (xhr.readyState === XMLHttpRequest.DONE) {
			console.log(xhr.responseText);
			}
		}
      var xhr = new XMLHttpRequest();
      xhr.open('GET', 'https://graph.facebook.com/v2.6/me/permissions');
      xhr.onload = function() {
    	  console.log(xhr.responseText);
      };
      xhr.send();
	  fb_access_token = null;
	  changeState(STATE_START);
      console.log('Token revoked and removed from cache.');
  }