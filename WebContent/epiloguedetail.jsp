
<%@page import="java.util.List"%>
<%@page import="dto.EpilogueDto"%>
<%@page import="epilogue.EpilogueDao"%>
<%@page import="member.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%!// 댓글의 여백과 이미지를 추가하는 함수
   public String arrow(int depth) {
      String rs = "<img src='./image/arrow.png' width='20px' height='20px'/>";
      String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";

      String ts = "";
      for (int i = 0; i < depth; i++) {
         ts += nbsp;
      }
      return depth == 0 ? "" : ts + rs;
   }%>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bit Board Game</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">


<script type="text/javascript">
$(function () {
   $("#").load("./GNB/.jsp");
})
</script>

<style type="text/css">
/* table.type02 {
   border-collapse: separate;
   border-spacing: 0;
   vertical-align: center;
   text-align: left;
   line-height: 1.0;
   border-top: 1px solid #ccc;
   border-left: 1px solid #ccc;
   margin: 20px 10px;
}

table.type02 th {
   /* width: 150px; */
   padding: 10px;
   font-weight: bold;
   vertical-align: top;
   border-right: 1px solid #ccc;
   border-bottom: 1px solid #ccc;
   border-top: 1px solid #fff;
   border-left: 1px solid #fff;
   background: #eee;
   text-align: center;
}

table.type02 td {
   /* width: 350px; */
   padding: 10px;
   vertical-align: top;
   line-height: 1.5;
   border-top: 1px solid #ccc;
   border-right: 1px solid #ccc;
   border-bottom: 1px solid #ccc;
} */


   table, tr, td {
       border-collapse: separate;
       border-spacing: 0px;
   }
   table {
           width: 90%;
   border-top: 1px solid #eaeaea;
   }
    
    th {
    
    text-align: center;
   height: 56px;
    color: #6a6a6a;
    padding: 10px;
    background: #f6f6f6;
    border-bottom: 1px solid #eaeaea;
   
    }
   
   td {
   height: 56px;
    color: #545b62;
    padding: 10px;
    background: #ffffff;
    border-bottom: 1px solid #eaeaea;}


</style>

</head>
<body>
<%-- GNB --%>
<div id="gnb"></div>
<script type="text/javascript">
$(function () {
   $("#gnb").load("./GNB/gnb.jsp");
})
</script>

<%
MemberDto mem = (MemberDto)request.getSession().getAttribute("login");

EpilogueDao dao = EpilogueDao.getInstance();
dao.readcount(seq);
EpilogueDto epilogue = dao.getEpilogue(seq);
List<EpilogueDto> list = null;


%>

<%-- <h3 align="right" style="background-color: #f0f0f0"><%=mem.getId() %>님의 글에 대한 자세한 내용입니다. --%>
<!-- </h3> -->

<div class="container">
   <br><p class="subject">Epilogue</p>
</div>

<div align="center"  class="container" style="max-width: 1000px">


<table >
   <colgroup>
<!-- <col width="100"><col width="100"><col width="100"><col width="200"><col width="100"><col width="100"> -->
<col width="150"><col>
   </colgroup>
   
<tr align="center">
   <th height="30" align="center">작성자</th>
   <td height="30"><%=epilogue.getId() %></td>
   <th height="30" align="center">작성일</th>
   <td height="30"><%=epilogue.getWdate() %></td>
   <th height="30" align="center">조회수</th>
   <td height="30"><%=epilogue.getReadcount() %></td>
</tr>
<tr>
   <th align="center">제목</th>
   <td colspan="3"><%=epilogue.getTitle() %></td>
   <th align="center">글번호</th>
   <td align="center"><%=epilogue.getSeq() %></td>
</tr>

<tr align="center">
   <th>내용</th>
   <td colspan="5">
   
   <div style="overflow:scroll; width:700px; height:400px; visibility: visible; 
            image:visible; name:content; readonly:readonly">
            <%=epilogue.getContent() %>
   </div>
   
   </td>
</tr>

</table>



<% 
if(epilogue.getId().equals(mem.getId())){
%>
<button type="button" class="btn btn-info" onclick="updateEpilogue(<%=epilogue.getSeq() %>)">수정</button>
<button type="button"  class="btn btn-danger"  onclick="deleteEpilogue(<%=epilogue.getSeq() %>)">삭제</button>
<%
}
%>
<hr>
<table class="type02"  style="line-height: 10px; vertical-align: center">
<col width="120"><col width="700"><col width="100"><col width="120">
<tr>
   <th>댓글번호</th><th>제목 : 내용</th><th>작성자</th><th>등록일</th>
</tr>
<% 
   list = dao.getEpilogueReplies(seq);

if(list == null || list.size() ==0){
%>
   <tr>
      <td colspan="6" align="center">작성된 후기가 없습니다</td>
   </tr>
<%   
}else{
   System.out.println("seq : " + seq);
   System.out.println("list : " + list);
   int c=1;
for(int i = 0; i < list.size() ; i++){
   
   EpilogueDto epilogueReply = list.get(i);   
            System.out.println("list.get(i) : " + list.get(i));
            System.out.println("epilogueReply : " + epilogueReply);

            %>
<% 
if((epilogueReply.getSeq() != epilogueReply.getRef()) && (epilogueReply.getStep() != 0)){
%>

<tr style="line-height: 10px">

   <th style = "align: center"> 
   <%=epilogueReply.getStep() %>
   </th>
   
   <td style="font-size: 12px">
      <b><font size="2.5px" face="돋움" ><%=epilogueReply.getTitle() %></font></b>
      <br><br>
      <%=epilogueReply.getContent() %>
   </td>   

   <td align = "center"><%=epilogueReply.getId() %></td>
   <td align = "center" style="font-size: 12px"><%=epilogueReply.getWdate() %></td>
</tr>
<%
 }
}
}
%>
</table>
<br>
<form action="epilogueanswer.jsp" method="get">
   <input type="hidden" name="seq" value="<%=epilogue.getSeq() %>">
   <input type="submit" class="btn btn-info" value="댓글">
   <input type="button" class="btn btn-danger" value="취소" onclick=" location.href='./epiloguelist.jsp' ">
</form>

</div>

<script type="text/javascript">
      function updateEpilogue( seq ) {
         location.href = "epilogueupdate.jsp?seq=" + seq;
      }
      function deleteEpilogue( seq ) {
         location.href = "epiloguedelete.jsp?seq=" + seq;      
      }
</script>


<br><br><br><br><Br>

<footer id="ft">
	<div id="footer"></div>
	<script type="text/javascript">
	$(function () {
		$("#footer").load("./GNB/footer.jsp");
	})
	</script>
</footer>





</body>
</html>