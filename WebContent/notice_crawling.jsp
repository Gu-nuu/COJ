<%@ page import="java.text.*" %>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<html>
<head>
</head>
<link rel="stylesheet" href="main_style.css">

<body>
	<%
		String url, title, info, content;
		Elements e, e1, e2, e3;
	
		url = "https://www.dongguk.edu/mbs/kr/jsp/board/list.jsp?boardId=3638&id=kr_010801000000";
		Document doc = Jsoup.connect(url).get();
	
		Element element = doc.selectFirst("body > div#WSub > div.midWrap_bg > div.midWrap > div.contentWrap > div#m-content > div#board > form > table#board_list > tbody > tr > td.title > a");
		
		url = element.attr("abs:href");
		
		doc = Jsoup.connect(url).get();
		
		e = doc.select("body > div#WSub > div.midWrap_bg > div.midWrap > div.contentWrap > div#m-content > div#board");
		e2 = e;
		e3 = e;
		
		e1= e.select("table#board_view > thead > tr > th");
		title = e1.text();
		
		e2 = e.select("div#board_info > div.info_text");	
		info = e2.html();
		
		e3 = e.select("table#board_view > tbody > tr > td > div#divView > p");
		content = e3.html();
		
	%>
	<div>
		<%=title %>
		<p><%=info %></p>
		
		
	</div>
</body>
</html>