<%@page import="java.util.ArrayList"%>
<%@page import="dto.EpilogueDto"%>
<%@page import="java.util.List"%>
<%@page import="epilogue.EpilogueDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
// 댓글의 여백과 이미지를 추가하는 함수
public String arrow(int depth){
	String rs = "<img src='./image/arrow.png' width='20px' height='20px'/>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
	
	String ts = "";
	for(int i = 0;i < depth; i++){
		ts += nbsp;
	}	
	return depth==0?"":ts + rs;
}
%>

<%
// 검색
String searchWord = request.getParameter("searchWord");
String choice = request.getParameter("choice");

if(choice == null || choice.equals("")){
	choice = "sel";
}

// 검색어를 지정하지 않고 choice가 넘어 왔을 때
if(choice.equals("sel")){
	searchWord = "";
}
if(searchWord == null){
	searchWord = "";
	choice = "sel";
}
%>
    
<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>epilogue list</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.js"></script>

<div id="gnb"></div>
<script type="text/javascript">
$(function () {
	$("#gnb").load("./GNB/gnb.jsp");
})
</script>


<style type="text/css">
table.type02 {
    border-collapse: separate;
    border-spacing: 0;
    vertical-align: center;
    text-align: left;
    line-height: 0.6;
    border-top: 0.5px solid #ccc;
    border-left: 0.5px solid #ccc;
  	margin : 20px 10px;
}
table.type02 th {
    /* width: 150px; */
    padding: 10px;
    font-weight: bold;
    vertical-align: center;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    border-top: 1px solid #fff;
    border-left: 1px solid #fff;
    background: #eee;
    text-align: center;
}
table.type02 td {
    /* width: 350px; */
    padding: 3px;
    line-height: 1.2;
    vertical-align: center;
    border-top: 0.1px solid #ccc;
    border-bottom: 0.1px solid #ccc;
}

</style>


</head>
<body>
<link type="text/css" rel="stylesheet" href="./css/ui.css">
<%
	Object ologin = session.getAttribute("login");
				// request.getSession().getAttribute(name)
	MemberDto mem = null;
	if(ologin == null){				
		%>
		<script type="text/javascript">
		alert("로그인 해 주십시오");
		location.href = "login.jsp";
		</script>
		<%
	}
	mem = (MemberDto)ologin;
%>	

<script type="text/javascript">
$(document).ready(function () {
	var _choice = '<%=choice %>';
	var _searchWord = '<%=searchWord %>';
	if(_choice != '' && _choice != 'sel'){		
		if(_searchWord != ""){			
			$("#choice").val(_choice);
			$("#search").val(_searchWord);
		}
	}
});

</script>

<%
String spageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
int count=0;
if(spageNumber != null && !spageNumber.equals("")){
	pageNumber = Integer.parseInt(spageNumber);
}

EpilogueDao dao = EpilogueDao.getInstance();	
	List<EpilogueDto> list = dao.getEpiloguePagingList(choice, searchWord, pageNumber);

int len = dao.getAllEpilogue(choice, searchWord); 
	System.out.println("총 글의 갯수:" + len);

int epiloguePage = len / 10;	// 예: 22개의 글 -> 3페이지

if(len % 10 > 0){
	epiloguePage = epiloguePage + 1;
}
%>
<table class="type02" style="width:95%; border: none">
<tr>
<td align="left" style="border: none; font-size: 20px; font-style: bold ">방문후기 페이지</td>
<td align="right" style="border: none">
	환영합니다 <%=mem.getId() %>님
</td>
</tr>
<tr>
<td align="left" style="border: none; font-size: 20px; font-style: bold"><font color="gray">총 방문 후기 수 / <%=len %></font></td>
</tr>
</table>

<div align="center">
<table class="type02">
<col width="70"><col width="70"><col width="600"><col width="70"><col width="70"><col width="100"><col width="120">

<tr>
	<th>번호</th><th style="font-size: 9pt">Image</th><th>제목</th><th>댓글수</th><th>조회수</th><th>작성자</th><th>등록일</th>
</tr>
<% 
if(list == null || list.size() == 0){
%>
	<tr>
		<th colspan="7">작성된 후기가 없습니다</th>
	</tr>
	
<%
}else{
%>
	
<%
for(int i = 0;i < list.size(); i++){
		EpilogueDto epilogue = list.get(i);	
%>
	<div class="test" hidden="true"><%=epilogue.getContent() %></div>
	<tr>			
<%
if(epilogue.getStep() == 0 ){
%>
		
		<th><%=++count %></th>
		 <td align = "center"> 
		 
					 <%
					 String str=epilogue.getContent().trim();
					 String[] array=str.split("http");
							str=array[1];
							array=str.split("/");
					 String url="";
					 String strUrl=(array[7].trim()).substring(0, 58);
 			 	     url="editor/multiupload/"+strUrl;

					 %>
					 
				 <a target="_blank" href="epiloguedetail.jsp?seq=<%=epilogue.getSeq() %>">	
				 	<img  src="<%=url %>" alt="url" style="width:60px; height:40px">
				 </a>	
		  </td>
		 	
		 	<% if(epilogue.getDel() == 0){ %>
				<td class="seqclick" seq=<%=epilogue.getSeq() %> style="font-size: 10pt">
					<%-- <%=arrow( epilogue.getDepth() ) %> --%>
					<b><%=epilogue.getTitle() %></b>
				</td>	
				
			<% }else { %>	
				<td><font color="#ff0000" style="font-size: 10pt">이 글은 작성자에 의해서 삭제되었습니다</font>
				</td> 
			<% } %>
			
		 <% int replyCount = dao.getReplyCount(epilogue.getRef()) - 1; // 댓글수%>
		 
		<td align = "center"><%=replyCount %></td> 
		<td align = "center"><%=epilogue.getReadcount() %> </td>
		<td align = "center"><%=epilogue.getId() %></td>
		<td align = "center" style="line-height: 10px; font-size: 12px"><%=epilogue.getWdate() %> </td>
	</tr>
	<%
	}
  }
}
%>

</table>

<%
for(int i = 0;i < epiloguePage; i++){	
	if(pageNumber == i){		
		%>
		<span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
			<%=i + 1 %>
		</span>&nbsp;
		<%
	}else{	
		%>
		<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
			style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none">
			[<%=i + 1 %>]
		</a>&nbsp;
		<%		
	}
}
%>
<br><br>
<a href="epiloguewrite.jsp">방문후기를 작성</a>
</div>
<br>
<div align="center">

<select id="choice" style="height: 25px">
	<option value="sel">선택</option>
	<option value="title">제목</option>
	<option value="writer">작성자</option>
	<option value="content">내용</option>
</select>

<input style="height: 20px" type="text" id="search" value="">
<button onclick="searchEpilogue()">검색</button>

</div>
<br><br><br>
<script type="text/javascript">

$(function () {
	
	$(".seqclick").mousedown(function() {
	
		location.href = "epiloguedetail.jsp?seq=" + $(this).attr("seq");
	});
	
	$(".seqclick").mouseover(function() {		
		$(this).css("background", "#e0e0e0");
	});
	$(".seqclick").mouseout(function() {
		$(this).css("background", "#ffffff");
	});
	
});

function searchEpilogue() {
	var choice = document.getElementById("choice").value;
	var word = $("#search").val();

	if(word == ""){
		document.getElementById("choice").value = 'sel';
	}
	
	location.href = "epiloguelist.jsp?searchWord=" + word + "&choice=" + choice;
	
}

function goPage( pageNum ) {
	var choice = $("#choice").val();
	var word = $("#search").val();

	if(word == ""){
		document.getElementById("choice").value = 'sel';
	}
	var linkStr = "epiloguelist.jsp?pageNumber=" + pageNum;
	if(choice != 'sel' && word != ""){
		linkStr = linkStr + "&searchWord=" + word + "&choice=" + choice;
	}
	location.href = linkStr;
}

</script>
</body>
</html>





