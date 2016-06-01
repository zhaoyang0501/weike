<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
      <header class="bar bar-nav">
              <a class="button button-link button-nav pull-left" href="javascript:void(0)"  onclick="history.back()">
                  <span class="icon icon-left"></span>
               	           返回
                  </a>
              <h1 class="title">微课</h1>
          </header>
          <nav class="bar bar-tab">
              <a class="tab-item external " href="login">
                  <span class="icon icon-card""></span>
                  <span class="tab-label">登录</span>
              </a>
               <a class="tab-item external" href="project">
                  <span class="icon icon-search"></span>
                  <span class="tab-label">课程检索</span>
              </a>
              <a class="tab-item external" href="upload">
                  <span class="icon icon-download"></span>
                  <span class="tab-label">我的上传</span>
              </a>
              <a class="tab-item external" href="center">
                  <span class="icon icon-me"></span>
                  <span class="tab-label">个人中心</span>
              </a>
          </nav>