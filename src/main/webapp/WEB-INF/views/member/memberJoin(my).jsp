<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<title>회원가입</title>
 <script>
    'use strict';

    
    function idCheck() {
    	let mid = myform.mid.value.trim();
    	
    	if(!regMid.test(mid)) {
    		alert("아이디는 4~20자리의 영문 소/대문자와 숫자, 언더바(_)만 사용가능합니다.");
    		myform.mid.focus();
    		return false;
    	}
    	
			$.ajax({
				url  : "${ctp}/member/memberIdCheck",
				type : "post",
				data : {mid : mid},
				success: (res) => {
					if(res != '') {
						alert("이미 사용중인 아이디 입니다. 다시 입력하세요.");
						myform.mid.focus();
					}
					else {
						alert("사용 가능한 아이디 입니다.");
						document.getElementById("mid").disabled = true;
						if(document.getElementById("pwd").value == '') document.getElementById("pwd").focus();
		    		idCheckSw = 1;
					}
				},
				error : () => alert("전송 오류!")
			});
    }
    
    // 닉네임 중복체크
    function nickCheck() {
    	let nickName = myform.nickName.value.trim();
    	
    	if(!regNickName.test(nickName)) {
        alert("닉네임은 '한글/숫자/_'만 사용가능합니다.");
        myform.nickName.focus();
        return false;
      }
    	
    	$.ajax({
				url  : "${ctp}/member/memberNickCheck",
				type : "post",
				data : {nickName : nickName},
				success: (res) => {
					if(res != '') {
						alert("이미 사용중인 닉네임 입니다. 다시 입력하세요.");
						myform.nickName.focus();
					}
					else {
						alert("사용 가능한 닉네임 입니다.");
						document.getElementById("nickName").disabled = true;
						if(document.getElementById("name").value == '') document.getElementById("name").focus();
						nickCheckSw = 1;
					}
				},
				error : () =>	alert("전송 오류!")
			});
    }
    
    //my
    /* let idChecked = false;
    let nickChecked = false;

    function idCheck() {
      let mid = document.getElementById("mid").value.trim();
      if(mid === "") { alert("아이디를 입력하세요"); return; }
      fetch("${ctp}/member/idCheck?mid=" + encodeURIComponent(mid))
        .then(res => res.text())
        .then(data => {
          if(data === "0") {
            document.getElementById("idCheckMsg").innerHTML = "<span style='color:green;'>사용 가능한 아이디입니다.</span>";
            idChecked = true;
          } else {
            document.getElementById("idCheckMsg").innerHTML = "<span style='color:red;'>이미 사용중인 아이디입니다.</span>";
            idChecked = false;
          }
        });
    }

    function nickCheck() {
      let nick = document.getElementById("nickName").value.trim();
      if(nick === "") { alert("닉네임을 입력하세요"); return; }
      fetch("${ctp}/member/nickCheck?nickName=" + encodeURIComponent(nick))
        .then(res => res.text())
        .then(data => {
          if(data === "0") {
            document.getElementById("nickCheckMsg").innerHTML = "<span style='color:green;'>사용 가능한 닉네임입니다.</span>";
            nickChecked = true;
          } else {
            document.getElementById("nickCheckMsg").innerHTML = "<span style='color:red;'>이미 사용중인 닉네임입니다.</span>";
            nickChecked = false;
          }
        });
    }

    function validateForm() {
      if(!idChecked) { alert("아이디 중복체크를 해주세요."); return false; }
      if(!nickChecked) { alert("닉네임 중복체크를 해주세요."); return false; }
      return true;
    } */
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>

<div class="container">
  <h2>회원가입</h2>

  <c:if test="${not empty errorMsg}">
    <div class="alert alert-danger">${errorMsg}</div>
  </c:if>

  <form method="post" action="${ctp}/member/join" enctype="multipart/form-data" onsubmit="return validateForm()">
    <!-- 아이디 -->
    <div class="mb-3">
      <label for="mid" class="form-label">아이디</label>
      <div class="input-group">
        <input type="text" class="form-control" id="mid" name="mid" required />
        <button type="button" value="아이디체크" class="btn btn-outline-secondary" onclick="idCheck()">중복체크</button>
      </div>
      <div id="idCheckMsg" class="mt-1"></div>
    </div>

    <!-- 닉네임 -->
    <div class="mb-3">
      <label for="nickName" class="form-label">닉네임</label>
      <div class="input-group">
        <input type="text" class="form-control" id="nickName" name="nickName" required />
        <button type="button" value="닉네임 체크" class="btn btn-outline-secondary" onclick="nickCheck()">중복체크</button>
      </div>
      <div id="nickCheckMsg" class="mt-1"></div>
    </div>

    <!-- 비밀번호 -->
    <div class="mb-3">
      <label for="pwd" class="form-label">비밀번호</label>
      <input type="password" class="form-control" id="pwd" name="pwd" required />
    </div>

    <!-- 이름 -->
    <div class="mb-3">
      <label for="name" class="form-label">이름</label>
      <input type="text" class="form-control" id="name" name="name" required />
    </div>

    <!-- 성별 -->
    <div class="mb-3">
      <label class="form-label">성별</label><br>
      <input type="radio" name="gender" value="남자" checked> 남자
      <input type="radio" name="gender" value="여자"> 여자
    </div>

    <!-- 생일 -->
    <div class="mb-3">
      <label for="birthday" class="form-label">생일</label>
      <input type="text" class="form-control" id="birthday" name="birthday" placeholder="YYYY-MM-DD" />
    </div>

    <!-- 전화번호 -->
    <div class="mb-3">
      <label for="tel" class="form-label">전화번호</label>
      <input type="text" class="form-control" id="tel" name="tel" />
    </div>

    <!-- 이메일 -->
    <div class="mb-3">
      <label for="email" class="form-label">이메일</label>
      <input type="email" class="form-control" id="email" name="email" required />
    </div>

    <!-- 사진 -->
    <div class="mb-3">
      <label for="photo" class="form-label">사진</label>
      <input type="file" class="form-control" id="photo" name="photo" />
      <small class="form-text text-muted">사진을 업로드하지 않으면 기본 사진이 적용됩니다.</small>
    </div>

    <button type="submit" class="btn btn-primary">가입</button>
  </form>
</div>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>