var PLUGIN_INFO =
<VimperatorPlugin>
<name>heuristic-search</name>
<description>Heuristic search</description>
<author mail="hitode909@gmail.com" homepage="http://www.hatena.ne.jp/hitode909/">hitode909</author>
<version>0.1</version>
<detail><![CDATA[

== Commands ==
:hsearch {keywords}
    Heuristic search with keywords

== Global variables ==
yahoo_app_id
    Application ID for Yahoo! Developer Network(http://developer.yahoo.co.jp/).

== Dependencies ==
- Application ID for Yahoo! Developer Network
- Hatena Bookmark Extension for Firefox

== How this work ==
extract body -> get key phrases -> search with selected key phrases.

]]></detail>
</VimperatorPlugin>;
(function(){
    var KeywordCache = {};

    function getBody() {
        try {
        if (typeof(ExtractContentJS)  == "undefined")
            liberator.loadScript('resource://hatenabookmark/modules/20-ExtractContentJS.jsm');
        } catch(e) {
            liberator.echoerr("resource://hatenabookmark/modules/20-ExtractContentJS.jsm is null");
            return null;
        }
        var ex = new ExtractContentJS.LayeredExtractor();
        ex.addHandler( ex.factory.getHandler('Heuristics') );
        var res = ex.extract(window.content.document);
        if (res.isSuccess) {
            return res.content.toString();
        } else {
            liberator.echoerr('ExtractContentJS not success');
            return null;
        }
    }

    function getKeyword() {
        var href = window.content.location.href;
        if (KeywordCache[href]) return KeywordCache[href];

        var body = getBody();
        if (!body) return;

        if (!liberator.globalVariables.yahoo_app_id) {
            liberator.echoerr("liberator.globalVariables.yahoo_app_id is null");
            return null;
        }
        
        var postbody = [
            'appid=',
            liberator.globalVariables.yahoo_app_id,
            '&output=json',
            '&sentence=',
            encodeURIComponent(body)
        ].join('');

        var req = new libly.Request(
            'http://jlp.yahooapis.jp/KeyphraseService/V1/extract',
            null,
            {postBody: postbody, asynchronous: false}
        );
        var result = [];
        req.addEventListener("onSuccess", function(res) {
            var got = eval("("+res.responseText+")");
            for(var k in got) if (got.hasOwnProperty(k)) {
                result.push([k, got[k]]);
            }
            KeywordCache[href] = result;
        });
        req.addEventListener("onFailure", function(res) {
            liberator.echoerr(res.responseText);
        });
        req.post();
        return KeywordCache[href];
    }

    function showLicense() {
        if (window.content.document.querySelector('div#yahoo-api-license')) return;
        var dummy = window.content.document.createElement('div');
        dummy.innerHTML = '<!-- Begin Yahoo! JAPAN Web Services Attribution Snippet --><a href="http://developer.yahoo.co.jp/about"><img src="http://i.yimg.jp/images/yjdn/yjdn_attbtn2_88_35.gif" width="88" height="35" title="Webサービス by Yahoo! JAPAN" alt="Webサービス by Yahoo! JAPAN" border="0" style="margin:15px 15px 15px 15px"></a><!-- End Yahoo! JAPAN Web Services Attribution Snippet -->';
        dummy.id = "yahoo-api-license";
        window.content.document.body.insertBefore(dummy, window.content.document.body.firstChild);
    }

    commands.addUserCommand(["hsearch"], "Heuristic search",
        function(args) {
            showLicense();
            var completions = getKeyword().map(function(pair){ return pair[0] });
            if (/\./.test(args.join('')) && completions.indexOf(args[0]) != -1 ) {
                args.unshift(options['defsearch']);
            };
            liberator.open(args.join(' '), liberator.NEW_TAB);
        }, {
            completer: function (context, args) {
                showLicense();
                context.ignoreCase = true;
                context.anchored = false;
                context.title = ["Keyword", "Score"];
                context.completions = getKeyword();
            }
        }
    );

})();
// vim:sw=4 ts=4 et:
