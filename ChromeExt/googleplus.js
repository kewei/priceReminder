'use strict';

var googlePlusUserLoader = (function() {

  var STATE_START=1;
  var STATE_ACQUIRING_AUTHTOKEN=2;
  var STATE_AUTHTOKEN_ACQUIRED=3;

  var state = STATE_START;

  var signin_button, xhr_button, revoke_button, user_info_div, pr_domain, mailto;

 function disableButton(button) {
    button.setAttribute('disabled', 'disabled');
  }

  function enableButton(button) {
    button.removeAttribute('disabled');
  }

  function changeState(newState) {
    state = newState;
    switch (state) {
      case STATE_START:
        enableButton(signin_button);
        disableButton(xhr_button);
        disableButton(revoke_button);
        document.getElementById("price").style.display = 'none';
        document.getElementById("signinLabel").style.display = 'block';
        break;
      case STATE_ACQUIRING_AUTHTOKEN:
        console.log('Acquiring token...');
        disableButton(signin_button);
        disableButton(xhr_button);
        disableButton(revoke_button);
        document.getElementById("price").style.display = 'none';
        document.getElementById("signinLabel").style.display = 'block';
        break;
      case STATE_AUTHTOKEN_ACQUIRED:
        disableButton(signin_button);
        enableButton(xhr_button);
        enableButton(revoke_button);
        document.getElementById("price").style.display = 'inline';
        document.getElementById("signinLabel").style.display = 'none';
        break;
    }
  }

  // @corecode_begin getProtectedData
  function xhrWithAuth(method, url, interactive, callback) {
    var access_token;

    var retry = true;

    getToken();

    function getToken() {
      chrome.identity.getAuthToken({ interactive: interactive }, function(token) {
        if (chrome.runtime.lastError) {
          callback(chrome.runtime.lastError);
          return;
        }

        access_token = token;
        requestStart();
      });
    }

    function requestStart() {
      var xhr = new XMLHttpRequest();
      xhr.open(method, url);
      xhr.setRequestHeader('Authorization', 'Bearer ' + access_token);
      xhr.onload = requestComplete;
      xhr.send();
    }

    function requestComplete() {
      if (this.status == 401 && retry) {
        retry = false;
        chrome.identity.removeCachedAuthToken({ token: access_token },
                                              getToken);
      } else {
        callback(null, this.status, this.response);
      }
    }
  }

  function getUserInfo(interactive) {
    xhrWithAuth('GET',
                'https://www.googleapis.com/plus/v1/people/me',
                interactive,
                onUserInfoFetched);
  }
  // @corecode_end getProtectedData


  // Code updating the user interface, when the user information has been
  // fetched or displaying the error.
  function onUserInfoFetched(error, status, response) {
    if (!error && status == 200) {
      changeState(STATE_AUTHTOKEN_ACQUIRED);
      console.log(response);
      var user_info = JSON.parse(response);
      populateUserInfo(user_info);
    } else {
      changeState(STATE_START);
    }
  }
  function polulateFavorites() {
	  var access_token;
	  var price_min=0, price_max;
//	  console.log(user_info.emails[0].value);
	  chrome.identity.getAuthToken({ interactive: false}, function(token) {
	        if (chrome.runtime.lastError) {
	          callback(chrome.runtime.lastError);
	          return;
	        }
	         access_token = token;
	         if (typeof access_token != 'undefined') {
	        	 if (validateInput()) {
	        		 price_max = document.forms["price"]["price_max"].value;
	        		 addFavorite(access_token, price_min, price_max); 
	        	 }
	         }
	  });
  }
  function validateInput() {
	  if ( document.forms["price"]["price_max"].value == '' || document.forms["price"]["price_max"].value == null) {
		  document.getElementById('price_max').style.borderColor = "red";
		  return false;
	  }
	  else {
		  document.getElementById('price_max').style.borderColor = "#14114d";
		  return true;
		  }
  }
//Create the XHR object.
  function createCORSRequest(method, url) {
    var xhr = new XMLHttpRequest();
    if ("withCredentials" in xhr) {
      // XHR for Chrome/Firefox/Opera/Safari.
      xhr.open(method, url, true);
    } else if (typeof XDomainRequest != "undefined") {
      // XDomainRequest for IE.
      xhr = new XDomainRequest();
      xhr.open(method, url);
    } else {
      // CORS not supported.
      xhr = null;
    }
    return xhr;
  }
  
  function addFavorite(access_token, price_min, price_max){  
	  chrome.tabs.query({'active': true, 'windowId': chrome.windows.WINDOW_ID_CURRENT},
			   function(tabs){
//		  		  var xhr = new XMLHttpRequest();
		  		  var xhr = createCORSRequest('POST', 'https://www.pricereminder.se/google_ext');
		  		  xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		  		  console.log(tabs[0].url)
		  		  if (!xhr) {
		  			  alert('CORS not supported');
		  			  return;
		  		  }

		  		  xhr.onerror = function() {
		  			  alert('Woops, there was an error making the request.');
		  		  };
		  		  xhr.send("prod_url=" +tabs[0].url+ "&access_token=" +access_token + "&price_min=" +price_min+ "&price_max=" +price_max);
		  		  xhr.onreadystatechange = function() {
		  			  console.log(xhr.responseText);
		  		  	if (xhr.readyState == 4 && xhr.status == '200'){
		  		  		var newDiv = document.createElement("div");
		  		  		var hr = document.createElement("hr");
		  		  		newDiv.appendChild(hr);
		  		  		var newContent = document.createTextNode(tabs[0].url); 
		  		  		newDiv.appendChild(newContent);
		  		  		var br = document.createElement("br");
		  		  		newDiv.appendChild(br);
		  		  		var newContent = document.createTextNode("Added succssefully!"); 
		  		  		newDiv.appendChild(newContent);
		  		  		var currentDiv = document.getElementById("favorite");
		  		  		currentDiv.insertAdjacentElement("beforeend", newDiv);
		  		  	}
		  		}; 
			   }
			);
  }
  function populateUserInfo(user_info) {
    user_info_div.innerText = "  Welcome " + user_info.displayName + ",";
    fetchImageBytes(user_info);
  }

  function fetchImageBytes(user_info) {
    if (!user_info || !user_info.image || !user_info.image.url) return;
    var xhr = new XMLHttpRequest();
    xhr.open('GET', user_info.image.url, true);
    xhr.responseType = 'blob';
    xhr.onload = onImageFetched;
    xhr.send();
  }

  function onImageFetched(e) {
    if (this.status != 200) return;
    var imgElem = document.createElement('img');
    var objUrl = window.URL.createObjectURL(this.response);
    imgElem.src = objUrl;
    imgElem.onload = function() {
      window.URL.revokeObjectURL(objUrl);
    }
    imgElem.setAttribute("height", "30");
    imgElem.setAttribute("width", "30");
    imgElem.style.borderRadius = '50%';
    user_info_div.insertAdjacentElement("afterbegin", imgElem);
  }

  // OnClick event handlers for the buttons.

  /**
    Retrieves a valid token. Since this is initiated by the user
    clicking in the Sign In button, we want it to be interactive -
    ie, when no token is found, the auth window is presented to the user.
    Observe that the token does not need to be cached by the app.
    Chrome caches tokens and takes care of renewing when it is expired.
    In that sense, getAuthToken only goes to the server if there is
    no cached token or if it is expired. If you want to force a new
    token (for example when user changes the password on the service)
    you need to call removeCachedAuthToken()
  **/
  function interactiveSignIn() {
    changeState(STATE_ACQUIRING_AUTHTOKEN);

    // @corecode_begin getAuthToken
    // @description This is the normal flow for authentication/authorization
    // on Google properties. You need to add the oauth2 client_id and scopes
    // to the app manifest. The interactive param indicates if a new window
    // will be opened when the user is not yet authenticated or not.
    // @see http://developer.chrome.com/apps/app_identity.html
    // @see http://developer.chrome.com/apps/identity.html#method-getAuthToken
    chrome.identity.getAuthToken({ 'interactive': true }, function(token) {
      if (chrome.runtime.lastError) {
        console.log(chrome.runtime.lastError);
        changeState(STATE_START);
      } else {
        console.log('Token acquired:'+token+
          '. See chrome://identity-internals for details.');
        changeState(STATE_AUTHTOKEN_ACQUIRED);
      }
    });
    // @corecode_end getAuthToken
  }

  function revokeToken() {
    user_info_div.innerHTML="";
    chrome.identity.getAuthToken({ 'interactive': false },
      function(current_token) {
        if (!chrome.runtime.lastError) {

          // @corecode_begin removeAndRevokeAuthToken
          // @corecode_begin removeCachedAuthToken
          // Remove the local cached token
          chrome.identity.removeCachedAuthToken({ token: current_token },
            function() {});
          // @corecode_end removeCachedAuthToken

          // Make a request to revoke token in the server
          var xhr = new XMLHttpRequest();
          xhr.open('GET', 'https://accounts.google.com/o/oauth2/revoke?token=' +
                   current_token);
          xhr.send();
          // @corecode_end removeAndRevokeAuthToken

          // Update the user interface accordingly
          changeState(STATE_START);
          console.log('Token revoked and removed from cache. '+
            'Check chrome://identity-internals to confirm.');
        }
  
	 })
  }

  function goWebsite() {
	  chrome.tabs.create({'url': "https://www.pricereminder.se"});
  }

  function sendEmail() {
	    var emailUrl = "mailto:pricereminder.se@gmail.com";
	    chrome.tabs.create({ url: emailUrl }, function(tab) {
	        setTimeOut(function() {
	            chrome.tabs.remove(tab.id);
	        }, 500);
	    });
	}
  
  return {
    onload: function () {
      signin_button = document.querySelector('#google');
      signin_button.addEventListener('click', interactiveSignIn);

      xhr_button = document.querySelector('#addFavorite');
      xhr_button.addEventListener('click', polulateFavorites);
//      chrome.identity.onSignInChanged.addListener(function callback)
      revoke_button = document.querySelector('#revoke');
      revoke_button.addEventListener('click', revokeToken);
      
      user_info_div = document.querySelector('#user_info');
      
      pr_domain = document.querySelector('#pr');
      pr_domain.addEventListener('click', goWebsite);
      
      mailto = document.querySelector('#mailto');
      mailto.addEventListener('click', sendEmail);
      

      // Trying to get user's info without signing in, it will work if the
      // application was previously authorized by the user.
      getUserInfo(false);
    }
  };

})();

window.onload = googlePlusUserLoader.onload;