<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--这里的utf-8是指服务器发送给客服端时的内容编码 --%>
<%@ page pageEncoding="utf-8" %>
<%--这里的utf-8是指 .jsp文件本身的内容编码 --%>
<html>
<head>
    <title>员工列表</title>
    <script src="${pageContext.request.contextPath}/static/jQuery/jquery-3.5.1.min.js"></script>
    <%-- 引入bootstrap --%>
    <link href="${pageContext.request.contextPath}/static/bootstrap-4.5.0/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/static/bootstrap-4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <%-- 标题 --%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <%-- 按钮 --%>
        <div class="row">
            <div class="col-md-6 offset-md-8">
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
            <hr>
        <%-- 表格数据 --%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-striped  table-bordered table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>邮箱</th>
                            <th>部门</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <c:forEach items="${pageInfo.list}" var="item">
                        <tr>
                            <td>${item.empId}</td>
                            <td>${item.empName}</td>
                            <td>${item.gender=="1"?"男":"女"}</td>
                            <td>${item.email}</td>
                            <td>${item.department.deptName}</td>
                            <td>
                                <button class="btn btn-outline-success btn-sm">
                                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pencil" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5L13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175l-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
                                    </svg>
                                    编辑
                                </button>
                                <button class="btn btn-outline-danger btn-sm">
                                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                        <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                    </svg>
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
            <hr>
        <%-- 分页页码信息 --%>
        <div class="row">
            <div class="col-md-6">
                当前${pageInfo.pageNum}页 | 共${pageInfo.pages}页 | 共${pageInfo.total}条数据
            </div>
            <div class="col-md-6">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <li class="page-item ${pageInfo.pageNum==1?"disabled":""}">
                            <a class="page-link" href="${pageContext.request.contextPath}/emps?pn=1">首页</a>
                        </li>
                        <li class="page-item ${pageInfo.pageNum==1?"disabled":""}">
                            <a class="page-link" href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pageNum>1?pageInfo.pageNum-1:1}"
                               aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <%-- 页码 --%>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="item">
                            <li class="page-item ${pageInfo.pageNum==item?"disabled active":""}">
                                <a class="page-link" href="${pageContext.request.contextPath}/emps?pn=${item}">${item}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${pageInfo.pageNum==pageInfo.pages?"disabled":""}">
                            <a class="page-link" href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pageNum<pageInfo.pages?pageInfo.pageNum+1:pageInfo.pages}"
                               aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                        <li class="page-item ${pageInfo.pageNum==pageInfo.pages?"disabled":""}">
                            <a class="page-link" href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pages}">尾页</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
