var Editor;

/*_______________________________________________*/$( window ).load(function() {
	//Setup Manuscript Editor
	Editor = ace.edit("Manuscript");
	Editor.setTheme("ace/theme/twilight");
	Editor.getSession().setMode("ace/mode/markdown");

	//startup showdownjs to reset Article contents on Manuscript changes
	var converter = new Showdown.converter({ extensions: ['table', 'mathjax'] });
	var doc = Editor.getSession().getDocument();
	Editor.getSession().on('change', function(e) {
		// using current line-height of 14 pixels...
		$("#Manuscript").css({"height": (14 * doc.getLength()) + 'px'});
		Editor.resize();
		$('#Article').html(converter.makeHtml(Editor.getValue()));
		MathJax.Hub.Queue(["Typeset",MathJax.Hub,"Article"]);
		//$("#Article").children().addClass("ui-tabs-panel ui-widget-content ui-corner-bottom");
	});
});

