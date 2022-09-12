<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--直接请求CusterFurnServlet 获取网站首页要显示的分页数据
类似网站入口--%>
<base href="<%=request.getContextPath()+"/"%>">
<jsp:forward page="customerFurnServlet?action=search&who=customer"></jsp:forward>