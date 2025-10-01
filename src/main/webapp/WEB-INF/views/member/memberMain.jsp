<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
  <title>memberMain.jsp</title>
  <script>
    'use strict';
    
    // 스케줄 상세내역을 모달로 출력하기
    function modalView(part, content) {
   		$(".modal-body #part").html(part);
   		$(".modal-body #content").html(content);
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>${sNickName} 회원 전용방</h2>
  <hr/>
  <c:if test="${sLevel == 3}">
    정회원 등업 조건 : 방명록에 3회이상 글쓰기, 회원로그인 4일 이상<br/>
    (포인트는 정회원 이상일경우 1회방문 10포인트증정, 1일 최대 50포인트증정)
  </c:if>
  <hr/>
  <div class="row">
	  <div class="col">
	    현재 회원 등급 : ${strLevel}<br/>
	    총 방문횟수 : ${mVo.visitCnt}<br/>
	    오늘 방문횟수 : ${mVo.todayCnt}<br/>
	    현재 가용 포인트 : ${mVo.point}<br/>
	    최종 방문일 : ${fn:substring(sLastDate,0,19)}<br/>
	  </div>
	  <div class="col">
	    <img src="${ctp}/member/${mVo.photo}" width="200px"/>
	  </div>
  </div>
  <hr class="border-1 border-dark">
  <div class="row">
	  <div class="col">
		  <h4>활동내역</h4>
			<div>
			  방명록 올린 글수 : ${guestCnt}<br/>
			</div>  
		</div>
		<div class="col text-center">
		  <c:if test="${scheduleCnt != 0}">
		    <table class="table table-hover text-center">
		      <tr class="table-dark text-dark">
		        <th>번호</th>
		        <th>간단 내역</th>
		        <th>분류</th>
		      </tr>
		      <c:forEach var="vo" items="${scheduleVos}" varStatus="st">
		        <tr>
		          <td>${st.count}</td>
		          <td>
		          	<a href="#" onclick="modalView('${vo.part}','${fn:replace(vo.content,newLine,'<br/>')}')" data-bs-toggle="modal" data-bs-target="#myModal">
			            <c:if test="${fn:indexOf(vo.content,newLine) != -1}">${fn:substring(vo.content,0,fn:indexOf(vo.content,newLine))}</c:if>
			            <c:if test="${fn:indexOf(vo.content,newLine) == -1}">${fn:substring(vo.content,0,20)}</c:if>
		            </a>
		          </td>
		          <td>${vo.part}</td>
		        </tr>
		        <tr><td colspan="4" class="m-0 p-0"><div id="updateDemo${vo.idx}"></div></td></tr>
		      </c:forEach>
		      <tr><td colspan="4" class="m-0 p-0"></td></tr>
		    </table>
		  </c:if>
		  <c:if test="${scheduleCnt == 0}"><h5 class="text-success">오늘 등록된 일정은 없습니다.</h5></c:if>
			<div class="text-center"><a href="${ctp}/schedule/schedule" class="btn btn-success">전체일정보기</a></div>
		</div> 
	</div>
</div>

<!-- 내용클릭시 모달창을 통해서 상세내역 출력하기 -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title"><b>${ymd}</b></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <table class="table">
          <tr><th>분류 :</th><td><span id="part"></span></td></tr>
          <tr><th>내용 :</th><td><span id="content"></span></td></tr>
          <tr><th>작성자 :</th><td>${sMid}</td></tr>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>