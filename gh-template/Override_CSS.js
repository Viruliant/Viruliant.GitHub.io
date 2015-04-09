/*______________________________________*/function getInternetExplorerVersion(){
/*! Returns the version of Internet Explorer or a -1  (indicating  the  use  of
another browser). This function is directly from
	http://msdn.microsoft.com/en-us/library/ms537509.aspx
*/	var rv = -1; // Return value if not IE.
	if (navigator.appName == 'Microsoft Internet Explorer'){
		var ua = navigator.userAgent;
		var re	= new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
		if (re.exec(ua) != null)
			rv = parseFloat( RegExp.$1 );
	}
	return rv;
}

/*_______________________________________*/function Override_CSS(Css_Text, Doc){
/*! Override_CSS() uses the text value of $Css_Text$ to override  the  style  of
the specified document $Doc$ e.g. an IFrame; If not specified $Doc$ defaults  to
the current document. */
	//Secure $Head$
	Doc = Doc||document;	var head = Doc.getElementsByTagName('head')[0];
	if(!head || head == null){
		head = Doc.createElement('div');
		Doc.body.appendChild(head);
	} if(!head || head == null){return false;}
	// create PendingStyle, override current css.
	var PendingStyle = Doc.createElement("style");
	PendingStyle.type = "text/css";
	if (getInternetExplorerVersion() == -1){// The standard method
		PendingStyle.appendChild(Doc.createTextNode(Css_Text));
	}else if (getInternetExplorerVersion() < 9){//IE6-8 use proprietary styleSheet.cssText instead
		PendingStyle.styleSheet.cssText = Css_Text;
		if (head.firstChild){// Add the new style with a higher priority
			head.insertBefore(PendingStyle, head.firstChild);
		}else { head.appendChild(PendingStyle); }
	}
	Doc.documentElement.appendChild(PendingStyle);
}

