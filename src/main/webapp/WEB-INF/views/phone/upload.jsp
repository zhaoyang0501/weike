<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>我的生活</title>
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
<link rel="shortcut icon" href="/favicon.ico">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<link href="http://dreyescat.github.io/bootstrap-rating/bower_components/fontawesome/css/font-awesome.css" rel="stylesheet">
<link href="//cdn.bootcss.com/bootstrap-rating/1.3.2/bootstrap-rating.min.css" rel="stylesheet">
<script src="http://dreyescat.github.io/bootstrap-rating/bower_components/jquery/dist/jquery.js"></script>
<script>
  $.noConflict();
  </script>
<script src=" http://dreyescat.github.io/bootstrap-rating/bower_components/bootstrap/js/tooltip.js"></script>
<script src="//cdn.bootcss.com/bootstrap-rating/1.3.2/bootstrap-rating.min.js"></script>

<link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm.min.css">
<script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
<link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/??sm.min.css,sm-extend.min.css">
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/??sm.min.js,sm-extend.min.js' charset='utf-8'></script>
<link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css">
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>

<style>
.custom-heart {
	font-size: 2.5em;
	color: yellow;
}

.custom-score {
	font-size: 1.5em;
	color: red;
}
</style>
</head>
<body>

	<div class="page-group">
		<!-- 你的html代码 -->
		<div class="page">
			<%@include file="./header.jsp"%>
			<div class="content">
				<div class="buttons-tab">
					<a href="#tab1" class="tab-link active  button">上传视频</a>
					 <a href="#tab2" class="tab-link  button">我的上传</a>
				</div>
				<div class="content-block" style="padding: 0px; margin: 0px">
					<div class="tabs">
						<div id="tab1" class="card tab active  content" style="padding: 0px; margin: 0px;height: 90%">
							  <div class="list-block">
							   <form method="post" enctype="multipart/form-data"  action="doupload">
							   
							    <ul>
							     <li>
							        <div class="item-content">
							          <div class="item-media"><i class="icon icon-form-name"></i></div>
							          <div class="item-inner">
							            <div class="item-title label">选择视频</div>
							            <div class="item-input">
							              <input type="file" name='uploadfile' placeholder="">
							            </div>
							          </div>
							        </div>
							      </li>
							      
							      <li>
							        <div class="item-content">
							          <div class="item-media"><i class="icon icon-form-name"></i></div>
							          <div class="item-inner">
							            <div class="item-title label">课程名称</div>
							            <div class="item-input">
							              <input name='name' type="text" placeholder="">
							            </div>
							          </div>
							        </div>
							      </li>
							      
							      <li>
							        <div class="item-content">
							          <div class="item-media"><i class="icon icon-form-name"></i></div>
							          <div class="item-inner">
							            <div class="item-title label">课程介绍</div>
							            <div class="item-input">
							              <textarea name='remark' rows="3" cols=""></textarea>
							            </div>
							          </div>
							        </div>
							      </li>
							      
							      </ul>
							      </form>
							       <div class="content-block">
    <div class="row">
      <div class="col-50"><a href="#" class="button button-big button-fill button-danger">取消</a></div>
      <div class="col-50"><a href="#" onclick="fun_submit()" class="button button-big button-fill button-success">提交</a></div>
    </div>
  </div>
  <script type="text/javascript">
  
  function fun_submit(){
	  $("form").submit();
  }
  function fun_goto(gotourl){
 	 location.href = gotourl;
  }
  </script>
							      </div>
						</div>

						<div id="tab2" class="tab " style="padding: 0px; margin: 0px">
		 
		   <div class="list-block media-list" style="margin-top: 2px">
			    <ul>
			    <c:forEach items="${projects }" var="bean">
			    <li>
			        <a onclick="fun_goto('viewmovie?id=${bean.id }')" href="javascript:void(0)" class="item-link item-content">
			          <div class="item-media"><img src="../img/video.ico" style='width: 4rem;'></div>
			          <div class="item-inner">
			            <div class="item-title-row">
			              <div class="item-title">${bean.name }</div>
			              <div class="item-after" style="    color: red;">${bean.price }</div>
			            </div>
			            <div class="item-subtitle"></div>
			            <div class="item-text" style="    color: #679c21;">“${bean.remark }”</div>
			          </div>
			        </a>
			      </li>
			    </c:forEach>
			    </ul>
			  </div>
		 
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
 <script>
     jQuery(function() {
    	  <c:if test="${tip!=null }">
    	 	 $.toast("评论成功");
    	  </c:if>
    	});
    </script>
</body>
</html>
